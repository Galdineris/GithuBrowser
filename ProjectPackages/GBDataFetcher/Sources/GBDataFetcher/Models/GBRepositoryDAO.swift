//
//  GBRepositoryDAO.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

public struct GBRepositoryDAO: Decodable, Equatable {
    public let name: String
    public let owner: GBUserDAO
    public let description: String?
    public let stars: Int
    public let forks: Int

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case description
        case stars = "stargazersCount"
        case forks = "forksCount"
    }
}
