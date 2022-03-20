//
//  GBImageRequest.swift
//  
//
//  Created by Rafael Galdino on 14/03/22.
//

import Foundation
import UIKit

struct GBImageRequest: GBGetRequestType {
    var path: String { "" }
    var url: String { "\(fullPath)" }
    var queryItems: [String : String] { [:] }
    let fullPath: String

    func decode(_ data: Data) throws -> UIImage? {
        return UIImage(data: data)
    }
}
