//
//  GBPullsListAdapter.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import GBDataFetcher
import UIKit

enum GBPullsListAdapter {
    static func adapt(_ values: [GBPullRequestDAO]) -> [GBPullsListCellModel] {
        return values.map { self.adapt($0) }
    }

    static func adapt(_ value: GBPullRequestDAO) -> GBPullsListCellModel {
        return GBPullsListCellModel(title: value.title,
                                    description: value.body ?? " ",
                                    pullPath: value.htmlUrl,
                                    avatarName: value.user.username,
                                    avatarImagePath: value.user.avatarPath)
    }

    static func adapt(_ value: GBUserDAO,
                      with image: UIImage? = nil) -> GBAvatarModel {
        return GBAvatarModel(username: value.username,
                             image: image)
    }
}
