//
//  GBRepositoryListPresenter.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation
import GBDataFetcher

public final class GBRepositoryListPresenter: GBRepositoryListPresenterType {
    public weak var controller: GBRepositoryListControllerType?
    let service = GBService(session: URLSession.shared)
    public var models: [GBRepositoryListCellModel] = []

    public init() { }

    private var lastPageFetched: Int = 1

    public func fetchData() {
        service.getRepositories(for: lastPageFetched) { [weak self] result in
            switch result {
            case .success(let repositories):

                self?.models.append(contentsOf: GBRepositoryListAdapter.adapt(repositories))
                self?.lastPageFetched += 1
                DispatchQueue.main.async {
                    self?.controller?.reloadData()
                }
            case .failure(let error):
                // TODO: Error Handling
                return
            }
        }
    }

    public func selectCellAt(index: Int) {
        controller?.navigateTo()
    }
}
