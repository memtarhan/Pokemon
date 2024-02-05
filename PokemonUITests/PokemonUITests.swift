//
//  PokemonUITests.swift
//  PokemonUITests
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import XCTest

// MARK: Those tests are for demonstration, Of course, there should be more and more tests

final class PokemonUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }

    func testHomeScreenDisplayed() throws {
        /// Checking if collection view in Home screen is dislayed thus home screen is displayed
        let collectionView = app.collectionViews["home_collectionView"]
        XCTAssertTrue(collectionView.exists, "Home screen is not displayed")
    }

    func testHomeScreenSearch() throws {
        let searchBar = app.searchFields["Search for a Pokemon"]
        XCTAssertTrue(searchBar.exists)

        searchBar.tap()
        XCTAssertTrue(app.keyboards.firstMatch.exists)

        searchBar.typeText("bu")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
