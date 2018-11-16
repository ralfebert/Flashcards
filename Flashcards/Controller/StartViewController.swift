//
//  StartViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 15.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, DownloadsTableViewControllerDelegate {

    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView() {
        self.btnStart.setTitle("\(FlashcardsModel.shared.cards.count) Karten lernen", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DownloadsTableViewController {
            controller.delegate = self
        }
        if let controller = segue.destination as? CardViewController {
            controller.cards = FlashcardsModel.shared.cards
        }
    }

    // MARK: - DownloadsTableViewControllerDelegate

    func downloadFinished(terms: [Term]) {
        let newCards = terms.map { Card(frontText: $0.term, backText: $0.definition) }
        FlashcardsModel.shared.cards.append(contentsOf: newCards)
    }
    
}
