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

    override func setUp() {
        sut = GBRepositoryListCell()
    }

    override func tearDown() {
        sut = nil
    }

    func test_init_shouldHaveDisclosureIndicator() throws {
        XCTAssertEqual(sut.accessoryType, .disclosureIndicator)
    }

    func test_show_shouldAssignValues() throws {
        let model = buildModelFixture()
        sut.show(model)
        let starsLabel = sut.viewWith(accessibilityIdentifier: "labelStars") as? GBIconLabel
        let forksLabel = sut.viewWith(accessibilityIdentifier: "labelForks") as? GBIconLabel
        let titleLabel = sut.viewWith(accessibilityIdentifier: "labelTitle") as? UILabel
        let descriptionLabel = sut.viewWith(accessibilityIdentifier: "labelDescription") as? UILabel
        let avatarView = sut.viewWith(accessibilityIdentifier: "viewAvatar") as? GBRepositoryAvatar

        XCTAssertNotNil(starsLabel)
        XCTAssertNotNil(forksLabel)
        XCTAssertNotNil(titleLabel)
        XCTAssertNotNil(descriptionLabel)
        XCTAssertNotNil(avatarView)

        XCTAssertEqual(starsLabel?.text, "\(model.stars)")
        XCTAssertEqual(forksLabel?.text, "\(model.forks)")
        XCTAssertEqual(titleLabel?.text, model.title)
        XCTAssertEqual(descriptionLabel?.text, model.description)
    }

    private func buildModelFixture() -> GBRepositoryListCellModel {
        let avatar = GBAvatarModel(username: "username")
        return GBRepositoryListCellModel(title: "title",
                                         description: "description",
                                         forks: 10,
                                         stars: 10,
                                         avatar: avatar)
    }
}
