//
//  GBRepositoryRequestTests.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import XCTest
@testable import GBDataFetcher

class GBRepositoryRequestTests: XCTestCase {
    var sut: GBRepositoryRequest!
    var dataFixture: Data!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let fixturePath = Bundle.module.path(forResource: "GBRepositoryRequestFixture",
                                             ofType: "json") ?? ""
        let fixtureURL = URL(fileURLWithPath: fixturePath)
        sut = GBRepositoryRequest()
        dataFixture = try Data(contentsOf: fixtureURL)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        dataFixture = nil
    }

    func test_decode_whenGivenValidInput_shouldDecodeObject() throws {
        let decodedObject = try sut.decode(dataFixture)
        guard !decodedObject.isEmpty else {
            throw GBErrors.genericError
        }
        let expectedObject = buildDataDummy()

        XCTAssertEqual(decodedObject[0], expectedObject)
    }

    private func buildDataDummy() -> GBRepositoryDAO {
        let user = GBUserDAO(username: "username",
                             avatarPath: "avatarPath")
        let repository = GBRepositoryDAO(name: "name", owner: user, description: "description", stars: 10, forks: 20)
        return repository
    }
}
