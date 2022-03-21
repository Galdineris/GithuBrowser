//
//  GBUserDAO.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

public struct GBUserDAO: Decodable, Equatable {
    public let username: String
    public let avatarPath: String

    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarPath = "avatarUrl"
    }

    public init(username: String,
                avatarPath: String = "") {
        self.username = username
        self.avatarPath = avatarPath
    }
}
