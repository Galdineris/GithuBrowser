//
//  GBPullsListPresenter.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import GBDataFetcher
import UIKit

public final class GBPullsListPresenter {
    public weak var controller: GBPullsListControllerType?
    public var models: [GBPullsListCellModel] = []

    private let model: GBPullsListModel
    let service = GBService(session: URLSession.shared)


    public init(model: GBPullsListModel) {
        self.model = model
    }

    var lastPageFetched: Int = 1
}

extension GBPullsListPresenter: GBPullsListPresenterType {
    public func fetchImage(for path: String, completion: @escaping (UIImage?) -> Void) {
        service.getImage(from: path) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure:
                completion(nil)
            }
        }
    }

    public func prepareForReuse() { }

    public func fetchData() {
        guard lastPageFetched > 0 else {
            return
        }
        controller?.setLoading(to: true)
        service.getPulls(of: model.repo,
                         user: model.username,
                         for: lastPageFetched) { [weak self] result in
            switch result {
            case .success(let pulls):
                guard !pulls.isEmpty else {
                    self?.lastPageFetched = -1
                    DispatchQueue.main.async {
                        self?.controller?.setLoading(to: false)
                    }
                    return
                }
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
        guard index < models.count else { return }
        let pullModel = models[index]
        controller?.openPullRequest(in: pullModel.pullPath)
    }
}
