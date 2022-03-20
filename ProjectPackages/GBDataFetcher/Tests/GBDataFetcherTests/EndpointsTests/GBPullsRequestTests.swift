//
//  GBPullsRequestTests.swift
//  
//
//  Created by Rafael Galdino on 16/03/22.
//

import XCTest
@testable import GBDataFetcher

class GBPullsRequestTests: XCTestCase {
    var sut: GBPullsRequest!
    var dataFixture: Data!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let fixturePath = Bundle.module.path(forResource: "GBPullsRequestFixture",
                                             ofType: "json") ?? ""
        let fixtureURL = URL(fileURLWithPath: fixturePath)
        sut = GBPullsRequest(user: "",
                             repository: "")
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

    private func buildDataDummy() -> GBPullRequestDAO {
        let user = GBUserDAO(username: "username",
                             avatarPath: "avatarPath")
        let repository = GBPullRequestDAO(user: user,
                                          htmlUrl: "htmlUrl",
                                          title: "title",
                                          body: "body")
        return repository
    }
}
