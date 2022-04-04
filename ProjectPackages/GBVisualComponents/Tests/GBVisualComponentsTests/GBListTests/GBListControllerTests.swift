//
//  GBListControllerTests.swift
//  
//
//  Created by Rafael Galdino on 04/04/22.
//

import XCTest
import GBVisualComponents

class GBListControllerTests: XCTestCase {
    var sut: GBListController<GBListCellMock>!
    var presenter: GBListPresenterSpy!

    override func setUp() {
        presenter = GBListPresenterSpy()
        sut = GBListController(presenter: presenter,
                               title: "title")
    }

    override func tearDown() {
        sut = nil
        presenter = nil
    }

    func test_init_shouldConfigureObject() throws {
        XCTAssertEqual(presenter.controller, sut)
        XCTAssertEqual(sut.title, "title")
    }

    func test_viewDidAppear_shouldCallFetchData() throws {
        sut.viewDidAppear(false)
        XCTAssertEqual(presenter.fetchDataCallCount, 1)
    }

    func test_reloadData_shouldSetLoadingToFalse() throws {
        let loadingIndicator = try XCTUnwrap(sut.view.viewWith(accessibilityIdentifier: "loadingIndicatorList") as? UIActivityIndicatorView)

        XCTAssertFalse(loadingIndicator.isAnimating)
    }

    func test_numberOfRowsInSection_shouldReturnPresenterCellsCount() throws {
        let tableView = try XCTUnwrap(sut.view.viewWith(accessibilityIdentifier: "listRepository") as? UITableView)
        presenter.cells = [" "]
        let expectedCount = presenter.cells.count
        let count = sut.tableView(tableView, numberOfRowsInSection: 1)
        XCTAssertEqual(expectedCount, count)
    }

    func test_didSelectRowAt_shouldCallPresenter() throws {
        let tableView = try XCTUnwrap(sut.view.viewWith(accessibilityIdentifier: "listRepository") as? UITableView)
        sut.tableView(tableView, didSelectRowAt: IndexPath(row: 1, section: 1))
        XCTAssertEqual(presenter.selectCellAtCallCount, 1)
    }

    func test_cellForRowAt_shouldReturnCorrectCell() throws {
        let tableView = try XCTUnwrap(sut.view.viewWith(accessibilityIdentifier: "listRepository") as? UITableView)

        presenter.cells = ["model"]

        let cell = try XCTUnwrap(sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? GBListCellMock)
        XCTAssertEqual(cell.showCallCount, 1)
        XCTAssertEqual(cell.showModels, ["model"])
        XCTAssertNotNil(cell.delegate)
    }
}
