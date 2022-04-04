//
//  GBRepositoryListPresenter.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation
import UIKit
import GBDataFetcher
import GBVisualComponents

public final class GBRepositoryListPresenter {
    public weak var controller: GBListControllerType?
    public weak var delegate: GBListPresenterDelegate?
    public var cells: [Any] = []

    let service = GBService(session: URLSession.shared)
    private var currentPage: Int = 1
    private var isNotFetching: Bool = true

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
        guard currentPage > 0, isNotFetching else {
            return
        }
        isNotFetching = false
        controller?.setLoading(to: true)
        service.getRepositories(for: currentPage) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.cells.append(contentsOf: GBRepositoryListAdapter.adapt(repositories))
                self?.currentPage += 1
                DispatchQueue.main.async {
                    self?.controller?.reloadData()
                }
            case .failure(let error):
                // TODO: Error Handling
                return
            }
            self?.isNotFetching = true
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
