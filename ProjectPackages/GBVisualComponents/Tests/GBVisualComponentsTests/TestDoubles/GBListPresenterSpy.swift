//
//  GBListPresenterMock.swift
//  
//
//  Created by Rafael Galdino on 04/04/22.
//

import Foundation
import UIKit

@testable import GBVisualComponents

final class GBListPresenterSpy: GBListPresenterType {
    var controller: GBListControllerType? = nil
    var delegate: GBListPresenterDelegate? = nil
    var cells: [Any] = []

    private (set) var fetchDataCallCount: Int = 0
    func fetchData() {
        fetchDataCallCount += 1
    }

    private (set) var selectCellAtCallCount: Int = 0
    private (set) var selectCellAtIndeces: [Int] = []
    func selectCellAt(index: Int) {
        selectCellAtCallCount += 1
        selectCellAtIndeces.append(index)
    }

    private (set) var fetchImageCallCount: Int = 0
    private (set) var fetchImageIndeces: [String] = []
    var fetchImageCompletionResult: UIImage? = nil
    func fetchImage(for path: String,
                    completion: @escaping (UIImage?) -> Void) {
        fetchImageCallCount += 1
        fetchImageIndeces.append(path)
        completion(fetchImageCompletionResult)
    }

    private (set) var prepareForReuseCallCount: Int = 0
    func prepareForReuse() {
        prepareForReuseCallCount += 1
    }
}
