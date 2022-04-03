//
//  GBRepositoryListPresenter.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation
import UIKit
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
        guard index < models.count else { return }
        let repoModel = models[index]
        controller?.openPullsList(in: repoModel.title, of: repoModel.avatarName)
    }
}

extension GBRepositoryListPresenter: GBRepositoryListCellDelegate {
    public func prepareForReuse() { }

    public func fetchImage(for path: String,
                           completion: @escaping (UIImage?) -> Void) {
        service.getImage(from: path) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure:
                completion(nil)
            }
        }
    }
}
