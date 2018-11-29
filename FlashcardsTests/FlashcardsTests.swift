//
//  FlashcardsTests.swift
//  FlashcardsTests
//
//  Created by Ralf Ebert on 29.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import XCTest
import CoreData
@testable import Flashcards

class FlashcardsTests: XCTestCase {

    var model : FlashcardsModel!
    var card : Card!

    override func setUp() {
        super.setUp()
        let persistentContainer = NSPersistentContainer(defaultContainerWithName: "Flashcards", inMemory: true)
        self.model = FlashcardsModel(persistentContainer: persistentContainer)
        self.card = self.model.createCard()
    }

    func dateFor(_ string : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: string)!
    }

    func testIncorrectScheduled1HourLater() {
        card.answered(correct:false, date:dateFor("2015-01-05 15:00"))
        XCTAssertEqual(card.scheduleDate, dateFor("2015-01-05 16:00"), "scheduleDate +1h")
    }

    func testCorrectScheduledTomorrow() {
        card.answered(correct:true, date:dateFor("2015-01-05 15:00"))
        XCTAssertEqual(card.scheduleDate, dateFor("2015-01-06 15:00"), "scheduleDate +1d")
    }
}
