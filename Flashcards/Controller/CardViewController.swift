//
//  ViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 08.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    enum Side {
        case front
        case back
    }

    var side = Side.front

    @IBOutlet weak var textLabel : UILabel!
    @IBOutlet weak var btnWrong: UIButton!
    @IBOutlet weak var btnFlip: UIButton!
    @IBOutlet weak var btnCorrect: UIButton!

    var cards : [Card] = []
    var card : Card?

    override func viewDidLoad() {
        super.viewDidLoad()
        showNextCard()
    }

    fileprivate func updateView() {
        switch(side) {
        case .front: self.textLabel.text = card?.frontText
        case .back: self.textLabel.text = card?.backText
        }
        self.btnWrong.isHidden = side == .front
        self.btnFlip.isHidden = side == .back
        self.btnCorrect.isHidden = side == .front
        self.navigationItem.title = "Noch \(self.cards.count + 1) Lernkarten"
    }

    @IBAction func flip() {
        switch(side) {
        case .front: self.side = .back
        case .back: self.side = .front
        }
        updateView()
    }

    @IBAction func wrong() {
        showNextCard()
    }

    @IBAction func correct() {
        showNextCard()
    }

    func showNextCard() {
        // Nächste Lernkarte:
        if let nextCard = cards.first {
            cards.removeFirst()
            self.card = nextCard
            self.side = .front
            updateView()
        } else {
            // Letzte Lernkarte:
            // ViewController vom Navigations-Stapel entfernen
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

