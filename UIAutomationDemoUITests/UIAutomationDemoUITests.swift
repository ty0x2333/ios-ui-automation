//
//  UIAutomationDemoUITests.swift
//  UIAutomationDemoUITests
//
//  Created by ty0x2333 on 2018/12/18.
//  Copyright © 2018 ty0x2333. All rights reserved.
//

import XCTest

extension XCUIElement {
    // The following is a workaround for inputting text in the
    //simulator when the keyboard is hidden
    func setText(text: String, application: XCUIApplication) {
        UIPasteboard.general.string = text
        coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: 10, dy: 10)).doubleTap()
        let pasteMenuItem = application.menuItems.firstMatch
        pasteMenuItem.tap()
    }
}

class UIAutomationDemoUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchEnvironment = ["animations": "0"]
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
    }

    func testExample() {
        
        let app = XCUIApplication()
        snapshot("0Launch")
        
        app.tables.cells.staticTexts["Simple"].tap()
        snapshot("1Simple")
        let rotateButton = app.buttons["rotate"]
        rotateButton.tap()
        snapshot("2Simple")
        app.navigationBars["Simple"].buttons["UIAutomationDemo"].tap()
        
        app.tables.cells.staticTexts["Special"].tap()
        snapshot("3Special")
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.setText(text: "abs", application: app)
        snapshot("4Special")
        app.navigationBars["Special"].buttons["UIAutomationDemo"].tap()
    }
}
