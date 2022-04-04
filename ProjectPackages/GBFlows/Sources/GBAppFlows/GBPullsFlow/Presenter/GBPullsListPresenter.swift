//
//  GBPullsListPresenter.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import GBVisualComponents
import GBDataFetcher
import UIKit

public final class GBPullsListPresenter {
    public weak var controller: GBListControllerType?
    public weak var delegate: GBListPresenterDelegate?
    public var cells: [Any] = []

    private let model: GBPullsListModel
    let service = GBService(session: URLSession.shared)
    private var currentPage: Int = 1
    private var isNotFetching: Bool = true


    public init(repo: String, username: String) {
        self.model = GBPullsListModel(repo: repo, username: username)
    }

}

extension GBPullsListPresenter: GBListPresenterType {
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
        service.getPulls(of: model.repo,
                         user: model.username,
                         for: currentPage) { [weak self] result in
            switch result {
            case .success(let pulls):
                guard !pulls.isEmpty else {
                    self?.currentPage = -1
                    DispatchQueue.main.async {
                        self?.controller?.setLoading(to: false)
                    }
                    return
                }
                self?.cells.append(contentsOf: GBPullsListAdapter.adapt(pulls))
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
              let pullModel = cells[index] as? GBPullsListCellModel
        else { return }
        delegate?.handleSelection(with: ["path": pullModel.pullPath])
    }
}
