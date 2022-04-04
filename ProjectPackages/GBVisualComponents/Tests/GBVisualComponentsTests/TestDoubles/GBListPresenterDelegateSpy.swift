//
//  GBListPresenterDelegateMock.swift
//  
//
//  Created by Rafael Galdino on 04/04/22.
//

import Foundation

@testable import GBVisualComponents

final class GBListPresenterDelegateSpy: GBListPresenterDelegate {
    private (set) var handleSelectionCallCount: Int = 0
    private (set) var handleSelectionArgs: [String : Any] = [:]
    func handleSelection(with args: [String : Any]) {
        handleSelectionCallCount += 1
        handleSelectionArgs.merge(args) { key, _ in return key }
    }
}
