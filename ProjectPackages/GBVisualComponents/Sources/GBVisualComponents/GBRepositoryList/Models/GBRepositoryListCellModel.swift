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
    var avatar: GBAvatarModel

    public init(title: String,
                description: String,
                forks: Int,
                stars: Int,
                avatar: GBAvatarModel) {
        self.title = title
        self.description = description
        self.forks = forks
        self.stars = stars
        self.avatar = avatar
    }
}
