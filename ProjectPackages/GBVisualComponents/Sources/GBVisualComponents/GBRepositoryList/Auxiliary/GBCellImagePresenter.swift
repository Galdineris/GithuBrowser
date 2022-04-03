//
//  GBCellImageService.swift
//
//
//  Created by Rafael Galdino on 20/03/22.
//

import Foundation
import UIKit
import GBDataFetcher

final class GBCellImagePresenter {
    let service: GBService?
    var dataTask: URLSessionDataTask?

    init(service: GBService? = GBService(session: URLSession.shared)) {
        self.service = service
    }

    deinit {
        dataTask?.cancel()
    }

    func fetchImage(for path: String, completion: @escaping (UIImage?) -> Void) {
        let dataTask = GBService(session: URLSession.shared).getImage(from: path) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure:
                completion(nil)
            }
        }

        self.dataTask = dataTask
    }
}

extension GBCellImagePresenter: GBPullsListCellDelegate,
                                GBRepositoryListCellDelegate {
    func prepareForReuse() {
        dataTask?.cancel()
    }
}

