//
//  GBCoordinator.swift
//  GithuBrowser
//
//  Created by Rafael Galdino on 03/04/22.
//

import GBVisualComponents
import UIKit
import SafariServices

public enum GBScreen {
    case repositories
    case pulls(repo: String, username: String)
    case webPage(path: String)

    init?(from args: [String: Any]) {
        if let path = args["path"] as? String {
            self = GBScreen.webPage(path: path)
        } else if let repo = args["repo"] as? String,
           let username = args["username"] as? String {
            self = GBScreen.pulls(repo: repo,
                                  username: username)
        } else {
            return nil
        }
    }
}

public final class GBCoordinator {
    let navigationController: UINavigationController

    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    public func start(with flow: GBScreen = .repositories) {
        let controller: UIViewController
        switch flow {
        case .repositories:
            controller = createRepositoryList()
        case let .pulls(repo, username):
            controller = createPullsList(repo: repo, username: username)
        case let .webPage(path):
            controller = createWebPageController(path) ?? UIViewController()
        }
        navigationController.setViewControllers(navigationController.viewControllers
                                                + [controller],
                                                animated: true)
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

    private func createWebPageController(_ path: String) -> SFSafariViewController? {
        guard let url = URL(string: path) else { return nil }
        let controller = SFSafariViewController(url: url)
        controller.modalPresentationStyle = .pageSheet
        return controller
    }
}

extension GBCoordinator: GBListPresenterDelegate {
    public func handleSelection(with args: [String : Any]) {
        switch GBScreen(from: args) {
        case let .pulls(repo, username):
            openPullsList(in: repo, of: username)
        case let .webPage(path):
            openPullRequest(path)
        default:
//            handle error
            return
        }
    }

    private func openPullsList(in repo: String, of username: String) {
        let controller = createPullsList(repo: repo, username: username)
        navigationController.pushViewController(controller, animated: true)
    }

    private func openPullRequest(_ path: String) {
        guard let controller = createWebPageController(path) else { return }
        navigationController.present(controller, animated: true)
    }
}
