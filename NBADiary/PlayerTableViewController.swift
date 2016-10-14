//
//  PlayerTableViewController.swift
//  Swift-GrailDiary
//
//  Created by Ross Gottschalk on 8/17/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController
{
    var players = Array<PlayerClass>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadNBAPlayers()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    func loadNBAPlayers()
    {
        do
        {
            let filePath = Bundle.main.path(forResource: "NBAPlayers", ofType: "json")
            let dataFromFile = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
            let playerData: NSArray! = try JSONSerialization.jsonObject(with: dataFromFile!, options: []) as! NSArray
            for playerDictionary in playerData
            {
                let aPlayer = PlayerClass(dictionary: playerDictionary as! NSDictionary)
                players.append(aPlayer)
            }
        }
        catch let error as NSError
        {
            print(error)
        }
    }
 
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }


    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)

        // Configure the cell...
        let aPlayer = players[indexPath.row]
        cell.textLabel?.text = aPlayer.name
        cell.detailTextLabel?.text = aPlayer.position
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "PlayerBioSegue"
        {
            let detailVC = segue.destination as! PlayerDetailViewController
            let selectedCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: selectedCell)
            let selectedPlayer = players[(indexPath?.row)!]
            detailVC.player = selectedPlayer
        }
    }
    

    
}
