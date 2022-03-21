//
//  GBPullRequestDAO.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

public struct GBPullRequestDAO: Decodable, Equatable {
    public let user: GBUserDAO
    public let htmlUrl: String
    public let title: String
    public let body: String?
}
