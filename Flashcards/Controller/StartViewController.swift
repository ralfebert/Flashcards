//
//  StartViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 15.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CardViewController {
            controller.card = FlashcardsModel.shared.cards.first
        }
    }
    
}
