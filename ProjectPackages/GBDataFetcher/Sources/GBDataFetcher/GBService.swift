//
//  GBService.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation
import UIKit

enum GBErrors: Error {
    case invalidURL
    case apiError(Error)
    case unexpectedStatusCode(code: Int)
    case noDataReceived
    case failedToDecode
    case genericError
}

public struct GBService: GBServiceType {

    public init(session: URLSessionProtocol) {
        self.session = session
    }
    public var session: URLSessionProtocol

    @discardableResult
    public func getRepositories(for page: Int,
                                pageSize: Int = 10,
                                completion: @escaping (Result<[GBRepositoryDAO], Error>) -> Void) -> URLSessionDataTask? {
        let service = GBRepositoryRequest(page: page, perPage: pageSize)
        return request(service, session: session) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    public func getPulls(from user: GBUserDAO,
                         for page: Int,
                         pageSize: Int = 10,
                         completion: @escaping (Result<[GBPullRequestDAO], Error>) -> Void) -> URLSessionDataTask? {
        let service = GBPullsRequest(user: user.username,
                                     repository: user.avatarPath,
                                     page: page,
                                     perPage: pageSize)
        return request(service, session: session) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    public func getImage(from path: String,
                         completion: @escaping (Result<UIImage?, Error>) -> Void) -> URLSessionDataTask? {
        let service = GBImageRequest(fullPath: path)
        return request(service, session: session) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
