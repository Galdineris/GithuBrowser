import XCTest
import GBVisualComponents
@testable import GBAppFlows
import SafariServices

final class GBCoordinatorTests: XCTestCase {
    var sut: GBCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
        sut = GBCoordinator(navigationController: navigationController)
    }

    override func tearDown() {
        sut = nil
        navigationController = nil
    }

    func test_start_withRepositoryFlow_shouldShowListController() throws {
        sut.start(with: .repositories)
        XCTAssertNotNil( navigationController.viewControllers.popLast() as? GBListController<GBRepositoryListCell>)
    }

    func test_start_withPullsFlow_shouldShowListController() throws {
        let repo = "repo"
        let username = "username"
        sut.start(with: .pulls(repo: repo,
                               username: username))
        XCTAssertNotNil( navigationController.viewControllers.popLast() as? GBListController<GBPullsListCell>)
    }

    func test_start_withWebPage_shouldShowSafariController() throws {
        let path = "https://www.example.com"
        sut.start(with: .webPage(path: path))
        XCTAssertNotNil( navigationController.viewControllers.popLast() as? SFSafariViewController)
    }

    func test_handleSelection_withPullListArgs_shouldShowListController() throws {
        sut.handleSelection(with: ["repo": "repo", "username":"username"])

        XCTAssertNotNil( navigationController.viewControllers.popLast() as? GBListController<GBPullsListCell>)
    }
}
