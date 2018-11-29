//
//  FlashcardsUITests.swift
//  FlashcardsUITests
//
//  Created by Ralf Ebert on 29.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import XCTest

class FlashcardsUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments = ["--clear", "-AppleLocale", "de_DE", "-AppleLanguages", "(de)"]
        app.launch()
    }

    func testFlashcardDownload() {

        let app = XCUIApplication()
        app.navigationBars.buttons["Hinzufügen"].tap()

        app.tables.staticTexts["Kostenfreie Kartenstapel"].tap()
        app.tables.staticTexts["Say Hello Around the World"].tap()

        app.buttons["3 Karten lernen"].tap()
        
        app.buttons["Antwort zeigen"].tap()
        app.buttons["Korrekt"].tap()

        XCTAssertTrue(app.navigationBars["Noch 2 Lernkarten"].exists)
    }

}
