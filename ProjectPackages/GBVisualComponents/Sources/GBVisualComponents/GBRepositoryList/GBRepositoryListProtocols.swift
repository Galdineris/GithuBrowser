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
    func navigateTo()
}

public protocol GBRepositoryListControllerType: UIViewController {
    func reloadData()
    func navigateTo()
}
