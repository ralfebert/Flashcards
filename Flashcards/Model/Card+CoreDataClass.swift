//
//  Card+CoreDataClass.swift
//  Flashcards
//
//  Created by Ralf Ebert on 22.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Card)
public class Card: NSManagedObject {

    static let entityName = "Card"

    func answered(correct : Bool, date : Date) {
        let interval = correct ? DateComponents(day: 1) : DateComponents(hour: 1)
        self.scheduleDate = Calendar.current.date(byAdding: interval, to: date)
    }
    
}
