//
//  GBRepositoryRequest.swift
//  
//
//  Created by Rafael Galdino on 14/03/22.
//

import Foundation

struct GBRepositoryRequest: GBGetRequestType {
    var path: String { "/search/repositories" }
    var page: Int = 1
    var perPage: Int = 10
    var queryItems: [String: String] {
        [
            "q":"language:Swift",
            "sort":"stars",
            "per_page":"\(perPage)",
            "page":"\(page)"
        ]
    }

    func decode(_ data: Data) throws -> [GBRepositoryDAO] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(GBRepositorySearchDAO.self, from: data)
        return response.items
    }
}
