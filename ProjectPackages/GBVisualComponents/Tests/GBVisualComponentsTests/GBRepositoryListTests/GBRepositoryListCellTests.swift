//
//  GBRepositoryListCellTests.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import XCTest
@testable import GBVisualComponents

class GBRepositoryListCellTests: XCTestCase {
    var sut: GBRepositoryListCell!
    var delegate: GBListCellDelegateSpy!

    override func setUp() {
        delegate = GBListCellDelegateSpy()
        sut = GBRepositoryListCell(style: .default,
                                   reuseIdentifier: "")
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

    func test_show_shouldSetCorrectForkValue() throws {
        let model = buildFixture()
        let label = try XCTUnwrap(sut.viewWith(accessibilityIdentifier: "labelForks") as? GBIconLabel)
        sut.show(model)
        XCTAssertEqual(label.text, "\(model.forks)")
    }

    func test_show_shouldSetCorrectStarsValue() throws {
        let model = buildFixture()
        let label = try XCTUnwrap(sut.viewWith(accessibilityIdentifier: "labelStars") as? GBIconLabel)
        sut.show(model)
        XCTAssertEqual(label.text, "\(model.stars)")
    }

    func test_prepareForReuse_shouldCallPrepareForReuse() throws {
        sut.prepareForReuse()
        XCTAssertEqual(delegate.prepareForReuseCallCount, 1)
    }

    private func buildFixture() -> GBRepositoryListCellModel {
        return GBRepositoryListCellModel(title: "title",
                                         description: "description",
                                         forks: 10,
                                         stars: 10,
                                         avatarName: "avatarName",
                                         avatarImagePath: "avatarImagePath")
    }
}
