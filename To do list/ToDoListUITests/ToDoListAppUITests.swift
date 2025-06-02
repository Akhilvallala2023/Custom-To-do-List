//
//  ToDoListAppUITests.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import XCTest

final class ToDoListAppUITests: XCTestCase {

    func testAppLaunchesToMainList() {
        let app = XCUIApplication()
        app.launch()

        let navBar = app.navigationBars["To-Do List"]
        XCTAssertTrue(navBar.exists)
    }

    func testAddingTaskViaUI() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["plus"].tap()
        let textField = app.textFields["Enter task title"]
        XCTAssertTrue(textField.exists)

        textField.tap()
        textField.typeText("New UI Task")

        app.buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["New UI Task"].exists)
    }
}
