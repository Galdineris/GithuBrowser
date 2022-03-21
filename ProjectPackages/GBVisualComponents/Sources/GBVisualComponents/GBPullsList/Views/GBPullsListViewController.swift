//
//  GBPullsListViewController.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import UIKit


public final class GBPullsListViewController: UIViewController {
    public weak var delegate: GBRepositoryListControllerDelegate?
    private var presenter: GBPullsListPresenter

    private lazy var repositoryList: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.register(GBPullsListCell.self,
                           forCellReuseIdentifier: GBPullsListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    public init(presenter: GBPullsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.controller = self
        title = "Pull Requests"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchData()
    }

    private func setupView() {
        buildViewHierarchy()
        configureConstraints()

        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.startAnimating()
        repositoryList.tableFooterView = activityIndicator
    }

    private func buildViewHierarchy() {
        view.addSubview(repositoryList)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            repositoryList.topAnchor.constraint(equalTo: view.topAnchor),
            repositoryList.rightAnchor.constraint(equalTo: view.rightAnchor),
            repositoryList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            repositoryList.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
}

extension GBPullsListViewController: GBRepositoryListControllerType {
    public func reloadData() {
        repositoryList.reloadData()
    }

    public func navigateTo() {
        delegate?.navigateTo()
    }
}

extension GBPullsListViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.models.count
    }

    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GBPullsListCell.reuseIdentifier) as? GBPullsListCell,
              presenter.models.count >= indexPath.row else {
            return UITableViewCell()
        }

        cell.show(presenter.models[indexPath.row])

        if indexPath.row > presenter.models.count - 2 {
            presenter.fetchData()
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectCellAt(index: indexPath.row)
    }
}

