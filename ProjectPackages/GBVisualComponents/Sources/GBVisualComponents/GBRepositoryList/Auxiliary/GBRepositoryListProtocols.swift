//
//  GBRepositoryListProtocols.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import UIKit

public protocol GBRepositoryListPresenterType: GBRepositoryListCellDelegate {
    var controller: GBRepositoryListControllerType? { get set }
    var models: [GBRepositoryListCellModel] { get }
    func fetchData()
    func selectCellAt(index: Int)
}

public protocol GBRepositoryListControllerDelegate: AnyObject {
    func openPullsList(repo: String, username: String)
}

public protocol GBRepositoryListControllerType: UIViewController {
    func reloadData()
    func openPullsList(in repo: String, of user: String)
    func setLoading(to isLoading: Bool)
}

public protocol GBRepositoryListCellDelegate: AnyObject {
    func fetchImage(for path: String, completion: @escaping (UIImage?) -> Void)
    func prepareForReuse()
}
