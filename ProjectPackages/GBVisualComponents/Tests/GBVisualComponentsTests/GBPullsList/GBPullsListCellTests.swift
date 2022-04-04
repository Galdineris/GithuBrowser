//
//  GBPullsListCellTests.swift
//  
//
//  Created by Rafael Galdino on 04/04/22.
//

import XCTest

@testable import GBVisualComponents

class GBPullsListCellTests: XCTestCase {
    var sut: GBPullsListCell!
    var delegate: GBListCellDelegateSpy!

    override func setUp() {
        delegate = GBListCellDelegateSpy()
        sut = GBPullsListCell(style: .default, reuseIdentifier: "")
        sut.delegate = delegate
    }

    override func tearDown() {
        sut = nil
        delegate = nil
    }

    func test_init_shouldHaveDisclosureIndicator() throws {
        XCTAssertEqual(sut.accessoryType, .disclosureIndicator)
    }

    func test_show_shouldCallFetchImage() throws {
        let model = buildFixture()
        delegate.fetchImageCompletionResult = .add

        sut.show(model)
        
        XCTAssertEqual(delegate.fetchImageCallCount, 1)
        XCTAssertEqual(delegate.fetchImagePath, model.avatarImagePath)
    }

    func test_show_shouldSetCorrectTitle() throws {
        let model = buildFixture()
        let label = try XCTUnwrap(sut.viewWith(accessibilityIdentifier: "labelTitle") as? UILabel)
        sut.show(model)
        XCTAssertEqual(label.text, model.title)
    }

    func test_show_shouldSetCorrectDescription() throws {
        let model = buildFixture()
        let label = try XCTUnwrap(sut.viewWith(accessibilityIdentifier: "labelDescription") as? UILabel)
        sut.show(model)
        XCTAssertEqual(label.text, model.description)
    }

    func test_prepareForReuse_shouldCallPrepareForReuse() throws {
        sut.prepareForReuse()
        XCTAssertEqual(delegate.prepareForReuseCallCount, 1)
    }

    private func buildFixture(title: String = "title",
                              description: String = "description",
                              pullPath: String = "pullPath",
                              avatarName: String = "avatarName",
                              avatarImagePath: String = "avatarImagePath") -> GBPullsListCellModel {
        return GBPullsListCellModel(title: title,
                                    description: description,
                                    pullPath: pullPath,
                                    avatarName: avatarName,
                                    avatarImagePath: avatarImagePath)
    }
}
