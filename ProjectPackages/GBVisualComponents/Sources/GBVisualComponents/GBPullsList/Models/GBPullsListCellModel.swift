//
//  GBPullsListCellModel.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
public struct GBPullsListCellModel {
    var title: String
    var description: String
    var pullPath: String
    var avatarName: String
    var avatarImagePath: String?

    public init(title: String,
                description: String,
                pullPath: String,
                avatarName: String,
                avatarImagePath: String) {
        self.title = title
        self.description = description
        self.pullPath = pullPath
        self.avatarName = avatarName
        self.avatarImagePath = avatarImagePath
    }
}
