//
//  GBListCellMock.swift
//  
//
//  Created by Rafael Galdino on 04/04/22.
//

import Foundation
import UIKit

@testable import GBVisualComponents

final class GBListCellMock: UITableViewCell, GBListCellType {
    typealias GBCellModel = String
    static var reuseIdentifier: String = "GBListCellMock"
    var delegate: GBListCellDelegate? = nil

    private(set) var showCallCount: Int = 0
    private(set) var showModels: [String] = []
    func show(_ model: String) {
        showCallCount += 1
        showModels.append(model)
    }
}
