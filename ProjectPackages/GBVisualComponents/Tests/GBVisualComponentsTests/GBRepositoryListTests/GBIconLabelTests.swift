//
//  GBIconLabelTests.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import XCTest
import UIKit
@testable import GBVisualComponents

class GBIconLabelTests: XCTestCase {
    var sut: GBIconLabel!

    override func setUp() {
        sut = GBIconLabel()
    }

    override func tearDown() {
        sut = nil
    }

    func test_text_whenChanged_shouldChangeLabel() throws {
        sut.text = "test"
        let sutLabel = sut.viewWith(accessibilityIdentifier: "label") as? UILabel

        XCTAssertNotNil(sutLabel)
        XCTAssertEqual(sutLabel?.text, "test")
    }

    func test_icon_whenChanged_shouldChangeImage() throws {
        sut.icon = .add
        let sutIconView = sut.viewWith(accessibilityIdentifier: "viewIcon") as? UIImageView

        XCTAssertNotNil(sutIconView)
        XCTAssertEqual(sutIconView?.image, .add)
    }

    func test_tintColor_whenChanged_shouldChangeColors() throws {
        sut.tintColor = .orange
        let sutLabel = sut.viewWith(accessibilityIdentifier: "label") as? UILabel
        let sutIconView = sut.viewWith(accessibilityIdentifier: "viewIcon") as? UIImageView

        XCTAssertNotNil(sutLabel)
        XCTAssertNotNil(sutIconView)
        XCTAssertEqual(sutLabel?.textColor, .orange)
        XCTAssertEqual(sutIconView?.tintColor, .orange)
    }
}
