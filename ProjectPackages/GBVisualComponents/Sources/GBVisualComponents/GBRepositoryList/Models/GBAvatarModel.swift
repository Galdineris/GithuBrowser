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
    var image: UIImage?

    public init(username: String, image: UIImage? = nil) {
        self.username = username
        self.image = image
    }
}
