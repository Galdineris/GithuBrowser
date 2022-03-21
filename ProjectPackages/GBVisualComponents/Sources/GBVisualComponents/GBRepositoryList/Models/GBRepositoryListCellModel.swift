//
//  GBRepositoryListCellModel.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation

public struct GBRepositoryListCellModel {
    var title: String
    var description: String
    var forks: Int
    var stars: Int
    var avatarName: String
    var avatarImagePath: String?

    public init(title: String,
                description: String,
                forks: Int,
                stars: Int,
                avatarName: String,
                avatarImagePath: String) {
        self.title = title
        self.description = description
        self.forks = forks
        self.stars = stars
        self.avatarName = avatarName
        self.avatarImagePath = avatarImagePath
    }
}
