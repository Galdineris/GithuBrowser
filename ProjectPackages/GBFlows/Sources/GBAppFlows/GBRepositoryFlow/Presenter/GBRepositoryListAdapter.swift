//
//  GBRepositoryListAdapter.swift
//  GithuBrowser
//
//  Created by Rafael Galdino on 20/03/22.
//

import Foundation
import GBDataFetcher
import GBVisualComponents
import UIKit

enum GBRepositoryListAdapter {
    static func adapt(_ values: [GBRepositoryDAO]) -> [GBRepositoryListCellModel] {
        return values.map { self.adapt($0) }
    }

    static func adapt(_ value: GBRepositoryDAO) -> GBRepositoryListCellModel {
        return GBRepositoryListCellModel(title: value.name,
                                         description: value.description ?? " ",
                                         forks: value.forks,
                                         stars: value.stars,
                                         avatarName: value.owner.username,
                                         avatarImagePath: value.owner.avatarPath)
    }

    static func adapt(_ value: GBUserDAO,
                      with image: UIImage? = nil) -> GBAvatarModel {
        return GBAvatarModel(username: value.username,
                             image: image)
    }
}
