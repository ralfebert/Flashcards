//
//  StartViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 15.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView() {
        var title = NSLocalizedString("StartButtonTitle", value:"Learn {count} cards", comment:"Placeholders {count}")
        title = title.replacingOccurrences(of: "{count}", with: String(FlashcardsModel.shared.cards.count))
        self.btnStart.setTitle(title, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CardViewController {
            controller.cards = FlashcardsModel.shared.cards
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }

}
