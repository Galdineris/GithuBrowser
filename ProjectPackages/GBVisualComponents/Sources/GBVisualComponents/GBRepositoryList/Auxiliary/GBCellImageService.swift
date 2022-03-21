//
//  GBCellImageService.swift
//
//
//  Created by Rafael Galdino on 20/03/22.
//

import Foundation
import UIKit
import GBDataFetcher

final class GBCellImageService {
    var dataTask: URLSessionDataTask? {
        willSet {
            dataTask?.cancel()
        }
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

