//
//  GBUserDAO.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

public struct GBUserDAO: Decodable, Equatable {
    let username: String
    let avatarPath: String

    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarPath = "avatarUrl"
    }
}
