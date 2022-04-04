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

    private func createRepositoryList() -> GBListControllerType {
        let presenter = GBRepositoryListPresenter()
        presenter.delegate = self
        let controller = GBListController<GBRepositoryListCell>(presenter: presenter,
                                                                title: "Swift Repositories")
        return controller
    }

    private func createPullsList(repo: String, username: String) -> GBListControllerType {
        let presenter = GBPullsListPresenter(repo: repo,
                                             username: username)
        presenter.delegate = self
        let controller = GBListController<GBPullsListCell>(presenter: presenter,
                                                           title: "\(repo)")
        return controller
    }

    private func openWebPage(_ path: String) -> SFSafariViewController? {
        guard let url = URL(string: path) else { return nil }
        let controller = SFSafariViewController(url: url)
        controller.modalPresentationStyle = .pageSheet
        return controller
    }
}

extension GBCoordinator: GBListPresenterDelegate {
    func handleSelection(with args: [String : Any]) {
        if let path = args["path"] as? String {
            openPullRequest(path)
            return
        }
        if let repo = args["repo"] as? String,
           let username = args["username"] as? String {
            openPullsList(in: repo, of: username)
            return
        }
    }

    private func openPullsList(in repo: String, of username: String) {
        let controller = createPullsList(repo: repo, username: username)
        navigationController.pushViewController(controller, animated: true)
    }

    private func openPullRequest(_ path: String) {
        guard let controller = openWebPage(path) else { return }
        navigationController.present(controller, animated: true)
    }
}
