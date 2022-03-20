//
//  GBPullRequestDAO.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

public struct GBPullRequestDAO: Decodable, Equatable {
    let user: GBUserDAO
    let htmlUrl: String
    let title: String
    let body: String
}
