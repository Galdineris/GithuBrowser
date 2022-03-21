//
//  GBPullsListModel.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import GBDataFetcher

public struct GBPullsListModel {
    var repo: String
    var username: String

    public init(repo: String,
                username: String) {
        self.repo = repo
        self.username = username
    }
}
