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
    public weak var controller: GBListControllerType?
    public weak var delegate: GBListPresenterDelegate?
    public var cells: [Any] = []

    private let model: GBPullsListModel
    let service = GBService(session: URLSession.shared)
    private var lastPageFetched: Int = 1


    public init(repo: String, username: String) {
        self.model = GBPullsListModel(repo: repo, username: username)
    }

}

extension GBPullsListPresenter: GBListPresenterType {
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
                self?.cells.append(contentsOf: GBPullsListAdapter.adapt(pulls))
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
              let pullModel = cells[index] as? GBPullsListCellModel
        else { return }
        delegate?.handleSelection(with: ["path": pullModel.pullPath])
    }
}
