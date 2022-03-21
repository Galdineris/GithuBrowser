//
//  GBPullsRequest.swift
//  
//
//  Created by Rafael Galdino on 14/03/22.
//

import Foundation

struct GBPullsRequest: GBGetRequestType {
    let user: String
    let repository: String
    var page: Int = 1
    var perPage: Int = 10
    var path: String { "/repos/\(user)/\(repository)/pulls" }
    var queryItems: [String: String] {
        [
            "per_page":"\(perPage)",
            "page":"\(page)"
        ]
    }

    func decode(_ data: Data) throws -> [GBPullRequestDAO] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(GBRepositoryPullsDAO.self, from: data)
        return response.pulls
    }
}
