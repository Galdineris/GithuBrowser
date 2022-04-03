//
//  GBCoordinator.swift
//  GithuBrowser
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import GBVisualComponents
import UIKit
import SafariServices

final class GBCoordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = createRepositoryList()
        navigationController.viewControllers = [controller]
    }

    private func createRepositoryList() -> GBRepositoryListController {
        let presenter = GBRepositoryListPresenter()
        let controller = GBRepositoryListController(presenter: presenter)
        controller.delegate = self
        return controller
    }

    private func createPullsList(repo: String, username: String) -> GBPullsListController {
        let presenter = GBPullsListPresenter(model: GBPullsListModel(repo: repo,
                                                                     username: username))
        let controller = GBPullsListController(presenter: presenter)
        controller.delegate = self
        return controller
    }

    private func openWebPage(_ path: String) -> SFSafariViewController? {
        guard let url = URL(string: path) else { return nil }
        let controller = SFSafariViewController(url: url)
        controller.modalPresentationStyle = .pageSheet
        return controller
    }
}
extension GBCoordinator: GBRepositoryListControllerDelegate {
    func openPullsList(repo: String, username: String) {
        let controller = createPullsList(repo: repo, username: username)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension GBCoordinator: GBPullsListControllerDelegate {
    func openPullRequest(_ path: String) {
        guard let controller = openWebPage(path) else { return }
        navigationController.present(controller, animated: true)
    }
}
