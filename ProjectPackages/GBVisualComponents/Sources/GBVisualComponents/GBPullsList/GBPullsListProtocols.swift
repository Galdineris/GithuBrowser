//
//  GBPullsListProtocols.swift
//  
//
//  Created by Rafael Galdino on 03/04/22.
//

import Foundation
import UIKit

public protocol GBPullsListPresenterType: GBPullsListCellDelegate {
    var controller: GBPullsListControllerType? { get set }
    var models: [GBPullsListCellModel] { get }
    func fetchData()
    func selectCellAt(index: Int)
}

public protocol GBPullsListControllerDelegate: AnyObject {
    func openPullRequest(_ path: String)
}

public protocol GBPullsListControllerType: UIViewController {
    func reloadData()
    func openPullRequest(in path: String)
    func setLoading(to isLoading: Bool)
}

public protocol GBPullsListCellDelegate: AnyObject {
    func fetchImage(for path: String, completion: @escaping (UIImage?) -> Void)
    func prepareForReuse()
}
