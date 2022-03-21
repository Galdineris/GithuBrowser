//
//  GBPullsListPresenter.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import GBDataFetcher

public final class GBPullsListPresenter {
    public weak var controller: GBPullsListViewController?
    public var models: [GBPullsListCellModel] = []

    private let model: GBPullsListModel
    let service = GBService(session: URLSession.shared)


    public init(model: GBPullsListModel) {
        self.model = model
    }

    private var lastPageFetched: Int = 1

    public func fetchData() {
        service.getPulls(from: model.user,
                         for: lastPageFetched) { [weak self] result in
            switch result {
            case .success(let pulls):

                self?.models.append(contentsOf: GBPullsListAdapter.adapt(pulls))
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
