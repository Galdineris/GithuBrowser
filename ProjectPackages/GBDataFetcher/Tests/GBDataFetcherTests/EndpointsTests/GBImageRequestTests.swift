//
//  GBImageRequestTests.swift
//  
//
//  Created by Rafael Galdino on 17/03/22.
//

import XCTest
@testable import GBDataFetcher

class GBImageRequestTests: XCTestCase {
    var sut: GBImageRequest!
    var dataFixture: Data!
    var aux: UIImage!

    override func setUpWithError() throws {
        try super.setUpWithError()
        aux = .add
        dataFixture = aux.pngData() ?? Data()
        sut = GBImageRequest(fullPath: "")
    }

    override func tearDown() {
        super.tearDown()
        aux = nil
        sut = nil
        dataFixture = nil
    }

    func test_decode_whenGivenValidInput_shouldDecodeObject() throws {
        let decodedObject = try sut.decode(dataFixture)?.pngData()
        let expectedObject = buildDataDummy()?.pngData()

        XCTAssertEqual(decodedObject, expectedObject)
    }

    private func buildDataDummy() -> UIImage? {
        return UIImage(data: aux.pngData() ?? Data())
    }
}
