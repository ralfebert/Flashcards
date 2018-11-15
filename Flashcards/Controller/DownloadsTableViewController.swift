//
//  DownloadsTableViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 15.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class DownloadsTableViewController: UITableViewController {

    let backend = DemoFlashcardsAPIClient()
    var allSets = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.allSets = backend.allSets
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSets.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadCell", for: indexPath)

        let cellItem = allSets[indexPath.row]

        cell.textLabel?.text = cellItem
        cell.detailTextLabel?.text = "? Lernkarten"

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let set = allSets[indexPath.row]
        let alert = UIAlertController(title: "Download", message: "Kartenstapel \(set) herunterladen.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
