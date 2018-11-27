//
//  DownloadsTableViewController.swift
//  Flashcards
//
//  Created by Ralf Ebert on 15.11.18.
//  Copyright © 2018 Ralf Ebert. All rights reserved.
//

import UIKit

protocol DownloadsTableViewControllerDelegate {

    func downloadFinished(terms : [Term])

}

class DownloadsTableViewController: UITableViewController {

    let backend = URLFlashcardsAPIClient()
    var allSets = [SetDownload]()

    var delegate : DownloadsTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let resource = backend.allSets
        resource.addValueObserver(owner: self) { (result) in
            self.allSets = result.sets
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSets.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadCell", for: indexPath)

        let cellItem = allSets[indexPath.row]

        cell.textLabel?.text = cellItem.title
        cell.detailTextLabel?.text = "\(cellItem.term_count) Lernkarten"

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let set = allSets[indexPath.row]
        let resource = backend.downloadSet(id: set.id)

        resource.addValueObserver(owner: self) { (result) in
            self.delegate?.downloadFinished(terms: result.terms)
            self.navigationController?.popViewController(animated: true)
        }

    }
    
}
