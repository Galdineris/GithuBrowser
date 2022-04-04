//
//  GBListController.swift
//  
//
//  Created by Rafael Galdino on 03/04/22.
//

import Foundation
import UIKit


public final class GBListController<GBListCell: GBListCellType>: UIViewController, UITableViewDelegate, UITableViewDataSource, GBListControllerType {
    private var presenter: GBListPresenterType

    private let listLoadingIndicator: UIActivityIndicatorView = {
        let rect = CGRect(x: 0, y: 0, width: 50, height: 100)
        let view = UIActivityIndicatorView(frame: rect)
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
        tableView.register(GBListCell.self,
                           forCellReuseIdentifier: GBListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = listLoadingIndicator
        return tableView
    }()

    public init(presenter: GBListPresenterType, title: String? = nil) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.controller = self
        self.title = title
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

    public func reloadData() {
        repositoryList.reloadData()
        setLoading(to: false)
    }

    public func setLoading(to isLoading: Bool) {
        if isLoading {
            listLoadingIndicator.startAnimating()
        } else {
            listLoadingIndicator.stopAnimating()
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cells.count
    }


    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: GBListCell.reuseIdentifier) as? GBListCell,
              presenter.cells.count >= indexPath.row,
              let cellModel = presenter.cells[indexPath.row] as? GBListCell.GBCellModel else {
            return UITableViewCell()
        }

        cell.delegate = presenter
        cell.show(cellModel)

        if indexPath.row > presenter.cells.count - 2 {
            presenter.fetchData()
        }

        return cell
    }


    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectCellAt(index: indexPath.row)
    }
}

