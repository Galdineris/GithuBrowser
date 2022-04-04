//
//  GBListCellDelegateSpy.swift
//  
//
//  Created by Rafael Galdino on 04/04/22.
//

import Foundation
@testable import GBVisualComponents
import UIKit

final class GBListCellDelegateSpy: GBListCellDelegate {
    private(set) var fetchImageCallCount: Int = 0
    private(set) var fetchImagePath: String?
    var fetchImageCompletionResult: UIImage?
    func fetchImage(for path: String,
                    completion: @escaping (UIImage?) -> Void) {
        fetchImageCallCount += 1
        fetchImagePath = path
        completion(fetchImageCompletionResult)
    }

    private(set) var prepareForReuseCallCount: Int = 0
    func prepareForReuse() {
        prepareForReuseCallCount += 1
    }
}
