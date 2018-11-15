//
//  ViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 08.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var textLabel : UILabel!
    @IBOutlet weak var btnWrong: UIButton!
    @IBOutlet weak var btnFlip: UIButton!
    @IBOutlet weak var btnCorrect: UIButton!
    
    let card = FlashcardsModel.shared.cards[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabel.text = card.frontText
        self.btnWrong.isHidden = true
        self.btnFlip.isHidden = false
        self.btnCorrect.isHidden = true
    }

    @IBAction func flip() {
        self.textLabel.text = card.backText
        self.btnWrong.isHidden = false
        self.btnFlip.isHidden = true
        self.btnCorrect.isHidden = false
    }

    @IBAction func wrong() {
        print("wrong")
    }

    @IBAction func correct() {
        print("correct")
    }

}

