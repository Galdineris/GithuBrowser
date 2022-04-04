//
//  GBPullsListModel.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation

public struct GBPullsListModel {
    public var repo: String
    public var username: String

    public init(repo: String,
                username: String) {
        self.repo = repo
        self.username = username
    }
}
