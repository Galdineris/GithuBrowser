//
//  GBRepositoryListPresenter.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation
import UIKit
import GBDataFetcher

public final class GBRepositoryListPresenter {
    public weak var controller: GBListControllerType?
    public weak var delegate: GBListPresenterDelegate?
    public var cells: [Any] = []

    let service = GBService(session: URLSession.shared)
    private var lastPageFetched: Int = 1

    public init() { }
}

extension GBRepositoryListPresenter: GBListPresenterType {
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

    public func fetchData() {
        service.getRepositories(for: lastPageFetched) { [weak self] result in
            switch result {
            case .success(let repositories):

                self?.cells.append(contentsOf: GBRepositoryListAdapter.adapt(repositories))
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
        guard index < cells.count,
              let pullsModel = cells[index] as? GBRepositoryListCellModel
        else { return }
        delegate?.handleSelection(with: ["repo": pullsModel.title,
                                         "username": pullsModel.avatarName])
    }
}
