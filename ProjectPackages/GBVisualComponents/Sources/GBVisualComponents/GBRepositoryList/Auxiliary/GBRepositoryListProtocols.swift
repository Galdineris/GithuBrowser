//
//  GBRepositoryListProtocols.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import UIKit

public protocol GBRepositoryListPresenterType {
    var controller: GBRepositoryListControllerType? { get set }
    var models: [GBRepositoryListCellModel] { get }
    func fetchData()
    func selectCellAt(index: Int)
}

public protocol GBRepositoryListControllerDelegate: AnyObject {
    func openPullsList(repo: String, username: String)
    func openPullRequest(_ path: String)
}

public protocol GBRepositoryListControllerType: UIViewController {
    func reloadData()
    func openPullsList(in repo: String, of user: String)
    func openPullsRequest(in path: String)
    func setLoading(to isLoading: Bool)
}