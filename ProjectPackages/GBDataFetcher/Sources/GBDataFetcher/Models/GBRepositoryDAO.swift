//
//  GBRepositoryDAO.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

public struct GBRepositoryDAO: Decodable, Equatable {
    let name: String
    let owner: GBUserDAO
    let description: String
    let stars: Int
    let forks: Int

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case description
        case stars = "stargazersCount"
        case forks = "forksCount"
    }
}
