//
//  GBRepositoryProtocols.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation

protocol GBGetRequestType {
    associatedtype ResponseType

    var url: String { get }
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var queryItems: [String: String] { get }

    func decode(_ data: Data) throws -> ResponseType
}

extension GBGetRequestType {
    var url: String {
        return baseURL + path
    }
    var baseURL: String {
        return "https://api.github.com"
    }
    var httpMethod: String {
        return "GET"
    }
}

protocol GBServiceType {
    func request<RequestType: GBGetRequestType>(_ requestType: RequestType,
                                                session: URLSessionProtocol,
                                                responseBlock: @escaping (Result<RequestType.ResponseType, GBErrors>) -> Void) ->
    URLSessionDataTask?
}

extension GBServiceType {
    @discardableResult
    func request<RequestType: GBGetRequestType>(_ requestType: RequestType,
                                                session: URLSessionProtocol = URLSession.shared,
                                                responseBlock: @escaping (Result<RequestType.ResponseType, GBErrors>) -> Void) ->
    URLSessionDataTask? {
        do {
            let request = try buildRequest(from: requestType)
            let dataTask = session.dataTask(with: request) { [responseBlock] data, response, error in
                if let apiError = error {
                    responseBlock(.failure(.apiError(apiError)))
                }
                guard isHttpSuccess(response) else {
                    let code = (response as? HTTPURLResponse)?.statusCode
                    return responseBlock(.failure(.unexpectedStatusCode(code: code ?? 400)))
                }
                guard let data = data else {
                    return responseBlock(.failure(.noDataReceived))
                }
                do {
                    try responseBlock(.success(requestType.decode(data)))
                } catch {
                    responseBlock(.failure(.failedToDecode))
                }
            }

            dataTask?.resume()
            return dataTask
        } catch {
            responseBlock(.failure((error as? GBErrors) ?? .genericError))
            return nil
        }
    }

    private func buildRequest<RequestType: GBGetRequestType>(from request: RequestType) throws -> URLRequest {
        guard var components = URLComponents(string: request.url) else {
            throw GBErrors.invalidURL
        }

        components.queryItems = request.queryItems.map { item in
            return URLQueryItem(name: item.key, value: item.value)
        }

        guard let url = components.url else {
            throw GBErrors.invalidURL
        }

        var fullRequest = URLRequest(url: url)
        fullRequest.httpMethod = request.httpMethod
        return fullRequest
    }

    private func isHttpSuccess(_ response: URLResponse?) -> Bool {
        if let response = response as? HTTPURLResponse {
            let successRange = (200..<300)
            return successRange ~= response.statusCode
        }
        return false
    }
}

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
}

extension URLSession: URLSessionProtocol {
    public func dataTask(with request: URLRequest,
                         completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return dataTask(with: request, completionHandler: completion)
    }
}
