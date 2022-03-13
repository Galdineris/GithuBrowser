//
//  GBAvatarModel.swift
//  
//
//  Created by Rafael Galdino on 12/03/22.
//

import Foundation
import UIKit

public struct GBAvatarModel {
    var username: String
    var realName: String?
    var image: UIImage?

    public init(username: String, realName: String? = nil, image: UIImage? = nil) {
        self.username = username
        self.realName = realName
        self.image = image
    }
}
