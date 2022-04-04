//
//  GBListProtocols.swift
//  
//
//  Created by Rafael Galdino on 03/04/22.
//

import Foundation
import UIKit

public protocol GBListPresenterType: GBListCellDelegate {
    var controller: GBListControllerType? { get set }
    var delegate: GBListPresenterDelegate? { get set }
    var cells: [Any] { get set }
    func fetchData()
    func selectCellAt(index: Int)
}

public protocol GBListPresenterDelegate: AnyObject {
    func handleSelection(with args: [String: Any])
}

public protocol GBListControllerType: UIViewController {
    func reloadData()
    func setLoading(to isLoading: Bool)
}

public protocol GBListCellType: UITableViewCell {
    associatedtype GBCellModel
    static var reuseIdentifier: String { get }
    func show(_ model: GBCellModel)
    var delegate: GBListCellDelegate? { get set }
    func prepareForReuse()
}

public protocol GBListCellDelegate: AnyObject {
    func fetchImage(for path: String,
                    completion: @escaping (UIImage?) -> Void)
    func prepareForReuse()
}
