//
//  ViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 08.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    let card = FlashcardsModel.shared.cards[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        print("Aktuelle Lernkarte:", card.frontText, card.backText)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
}

