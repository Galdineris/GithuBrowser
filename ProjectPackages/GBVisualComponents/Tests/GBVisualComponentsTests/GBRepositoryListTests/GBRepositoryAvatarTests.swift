//
//  GBRepositoryAvatarTests.swift
//  
//
//  Created by Rafael Galdino on 12/03/22.
//

import XCTest
@testable import GBVisualComponents

final class GBRepositoryAvatarTests: XCTestCase {
    var sut: GBRepositoryAvatar!

    override func setUp() {
        sut = GBRepositoryAvatar()
    }

    override func tearDown() {
        sut = nil
    }

// MARK: #Init

    func test_init_withVertical_shouldSetAxisVertical() throws {
        let stackView = sut.viewWith(accessibilityIdentifier: "stackViewContent") as? UIStackView
        XCTAssertNotNil(stackView)
        XCTAssertEqual(stackView?.axis, .vertical)
    }

    func test_init_withHorizontal_shouldSetAxisHorizontal() throws {
        sut = GBRepositoryAvatar(orientation: .horizontal)

        let stackView = sut.viewWith(accessibilityIdentifier: "stackViewContent") as? UIStackView
        XCTAssertNotNil(stackView)
        XCTAssertEqual(stackView?.axis, .horizontal)
    }

// MARK: #Show

    func test_show_withEmptyValues_shouldHideElements() throws {
        let model = GBAvatarModel(username: "")
        sut.show(model)

        let imageView = sut.viewWith(accessibilityIdentifier: "imageViewAvatar") as? UIImageView
        let subtitleLabel = sut.viewWith(accessibilityIdentifier: "labelSubtitle") as? UILabel
        XCTAssertNotNil(imageView)
        XCTAssertNotNil(subtitleLabel)
        XCTAssertTrue(imageView?.isHidden ?? false)
        XCTAssertTrue(subtitleLabel?.isHidden ?? false)
    }

    func test_show_withImage_shouldShowImage() throws {
        let model = GBAvatarModel(username: "", image: .add)
        sut.show(model)

        let imageView = sut.viewWith(accessibilityIdentifier: "imageViewAvatar") as? UIImageView
        XCTAssertNotNil(imageView)
        XCTAssertFalse(imageView?.isHidden ?? true)
        XCTAssertEqual(imageView?.image, .add)
    }

    func test_show_withRealName_shouldShowSubtitle() throws {
        let model = GBAvatarModel(username: "", realName: "realName")
        sut.show(model)

        let subtitleLabel = sut.viewWith(accessibilityIdentifier: "labelSubtitle") as? UILabel
        XCTAssertNotNil(subtitleLabel)
        XCTAssertFalse(subtitleLabel?.isHidden ?? true)
        XCTAssertEqual(subtitleLabel?.text, "realName")
    }
}
