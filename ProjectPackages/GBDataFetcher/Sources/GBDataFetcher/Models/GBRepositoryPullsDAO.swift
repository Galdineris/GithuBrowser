//
//  GBRepositoryPullsDAO.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

struct GBRepositoryPullsDAO: Decodable {
    var pulls: [GBPullRequestDAO]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.pulls = try container.decode([GBPullRequestDAO].self)
    }
}
