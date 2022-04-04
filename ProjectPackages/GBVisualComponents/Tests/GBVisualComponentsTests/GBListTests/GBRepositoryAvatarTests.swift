//
//  GBRepositoryAvatarTests.swift
//  
//
//  Created by Rafael Galdino on 12/03/22.
//

import XCTest
@testable import GBVisualComponents

final class GBRepositoryAvatarTests: XCTestCase {
    var sut: GBImageAvatar!

    override func setUp() {
        sut = GBImageAvatar()
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
        sut = GBImageAvatar(orientation: .horizontal)

        let stackView = sut.viewWith(accessibilityIdentifier: "stackViewContent") as? UIStackView
        XCTAssertNotNil(stackView)
        XCTAssertEqual(stackView?.axis, .horizontal)
    }

// MARK: #Show

    func test_show_withEmptyValues_shouldHideElements() throws {
        let model = GBAvatarModel(username: "")
        sut.show(model)

        let imageView = sut.viewWith(accessibilityIdentifier: "imageViewAvatar") as? UIImageView
        XCTAssertNotNil(imageView)
        XCTAssertTrue(imageView?.isHidden ?? false)
    }

    func test_show_withImage_shouldShowImage() throws {
        let model = GBAvatarModel(username: "", image: .add)
        sut.show(model)

        let imageView = sut.viewWith(accessibilityIdentifier: "imageViewAvatar") as? UIImageView
        XCTAssertNotNil(imageView)
        XCTAssertFalse(imageView?.isHidden ?? true)
        XCTAssertEqual(imageView?.image, .add)
    }

    func test_show_withUsername_shouldShowTitle() throws {
        let model = GBAvatarModel(username: "username")
        sut.show(model)

        let titleLabel = sut.viewWith(accessibilityIdentifier: "labelTitle") as? UILabel
        XCTAssertNotNil(titleLabel)
        XCTAssertEqual(titleLabel?.text, "username")
    }
}
