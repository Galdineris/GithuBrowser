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
    var user: GBUserDAO
    var pullPath: String

    public init(repo: String,
                user: GBUserDAO,
                pullPath: String) {
        self.repo = repo
        self.user = user
        self.pullPath = pullPath
    }
}
