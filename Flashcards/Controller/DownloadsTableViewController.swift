//
//  DownloadsTableViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 15.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

class DownloadsTableViewController: UITableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadCell", for: indexPath)

        cell.textLabel?.text = "Zelle \(indexPath.section).\(indexPath.row)"
        cell.detailTextLabel?.text = "? Lernkarten"

        return cell
    }
}
