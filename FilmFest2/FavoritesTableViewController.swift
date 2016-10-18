//
//  FavoritesTableViewController.swift
//  FilmFest2
//
//  Created by Tyler on 9/21/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit
import Firebase

class FavoritesTableViewController: UITableViewController
{
    var favMovieItems: [Favorites] = []
    var ref: FIRDatabaseReference!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Favorites"
        getUserFavorites()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovieItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoritesCell
        let movie = favMovieItems[indexPath.row]

        // Configure the cell...
        cell.favoriteTitleLabel.text = movie.title
        cell.favoriteDateLabel.text = movie.date

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let uid = AppState.sharedInstance.uid
            ref = FIRDatabase.database().reference(withPath: "\(uid)")
            let movieToDelete = favMovieItems[indexPath.row]
            favMovieItems.remove(at: indexPath.row)
            // Delete the row from the data source
            ref.child(movieToDelete.title).removeValue()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert
        {
            
        }
    }
    

// MARK: - Action Handlers
    func getUserFavorites()
    {
        let uid = AppState.sharedInstance.uid
        ref = FIRDatabase.database().reference(withPath: "\(uid)")
        ref.observe(.value, with: { snapshot in
            var snapMovies: [Favorites] = []
            for item in snapshot.children {
                let aMovieItem = Favorites(snapshot: item as! FIRDataSnapshot)
                snapMovies.append(aMovieItem)
            }
            self.favMovieItems = snapMovies
            self.tableView?.reloadData()
        })
    }
}
