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

    private let listLoadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.style = .large
        view.hidesWhenStopped = true
        return view
    }()

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
        tableView.tableFooterView = listLoadingIndicator
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
        view.backgroundColor = .white
        buildViewHierarchy()
        configureConstraints()
    }

    private func buildViewHierarchy() {
        view.addSubview(repositoryList)
    }

    private func configureConstraints() {
        let contraintGuides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            repositoryList.topAnchor.constraint(equalTo: contraintGuides.topAnchor),
            repositoryList.rightAnchor.constraint(equalTo: contraintGuides.rightAnchor),
            repositoryList.bottomAnchor.constraint(equalTo: contraintGuides.bottomAnchor),
            repositoryList.leftAnchor.constraint(equalTo: contraintGuides.leftAnchor)
        ])
    }
}

extension GBPullsListViewController: GBRepositoryListControllerType {
    public func openPullsList(in repo: String, of user: String) { }

    public func reloadData() {
        repositoryList.reloadData()
        setLoading(to: false)
    }

    public func openPullsRequest(in path: String) {
        delegate?.openPullRequest(path)
    }

    public func setLoading(to isLoading: Bool) {
        if isLoading {
            listLoadingIndicator.startAnimating()
        } else {
            listLoadingIndicator.stopAnimating()
        }
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

