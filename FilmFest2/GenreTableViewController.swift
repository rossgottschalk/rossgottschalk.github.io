//
//  GenreTableViewController.swift
//  FilmFest2
//
//  Created by Tyler on 9/22/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

class GenreTableViewController: UITableViewController {
    
    let genres: [String] = ["All", "Animation", "Biography", "Comedy", "Documentary", "Drama", "Family", "Food", "Foreign", "History", "Horror", "Music", "Romance", "Sci-Fi", "Teen"]
    var delegate: SortDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = genres[indexPath.row]
        return cell
    }

//MARK: - Action Handlers
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        let sortCategory = currentCell.textLabel?.text
        delegate?.sortCategoryWasSelected(category: sortCategory!)
        self.dismiss(animated: true, completion: nil)
        
    }

}
