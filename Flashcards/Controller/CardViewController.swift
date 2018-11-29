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
        updateCardLabels()
        updateButtons()
        updateNavigationItem()
    }

    private func updateCardLabels() {
        UIView.transition(with: self.textLabel, duration: 0.5, options: .transitionFlipFromTop, animations: {

            switch(self.side) {
            case .front: self.textLabel.text = self.card?.frontText
            case .back: self.textLabel.text = self.card?.backText
            }

        })
    }

    private func updateButtons() {
        self.btnWrong.isHidden = side == .front
        self.btnFlip.isHidden = side == .back
        self.btnCorrect.isHidden = side == .front

        // Ursprüngliche Position der Buttons sichern
        let posWrong = btnWrong.center
        let posCorrect = btnCorrect.center

        // Falsch/Richtig Button in die Mitte über den Flip-Button positionieren...
        btnCorrect.center = btnFlip.center
        btnWrong.center = btnFlip.center

        // ...und animiert an die ursprüngliche Position zurückbewegen
        UIView.animate(withDuration: 0.2) {
            self.btnWrong.center = posWrong
            self.btnCorrect.center = posCorrect
        }
    }

    private func updateNavigationItem() {
        var title = NSLocalizedString("CardTitle", value:"{count} cards remaining", comment:"Placeholders {count}")
        title = title.replacingOccurrences(of: "{count}", with: String(self.cards.count + 1))
        self.navigationItem.title = title
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

