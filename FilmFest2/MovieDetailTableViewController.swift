//
//  MovieDetailTableViewController.swift
//  FilmFest2
//
//  Created by Tyler on 10/1/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class MovieDetailTableViewController: UITableViewController
{
    var ref: FIRDatabaseReference!
    var movieItem: Movie?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var director1Label: UILabel!
    @IBOutlet weak var director2Label: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var location1Label: UILabel!
    @IBOutlet weak var location2Label: UILabel!
    @IBOutlet weak var genre1Label: UILabel!
    @IBOutlet weak var genre2Label: UILabel!
    @IBOutlet weak var genre3Label: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var plotLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleLabel.text = movieItem?.title
        director1Label.text = movieItem?.director1
        director2Label.text = movieItem?.director2
        durationLabel.text = (movieItem?.runTime)! + " mins"
        location1Label.text = (movieItem?.showingDay1)! + " " + (movieItem?.showingTime1)! + " " + (movieItem?.location1)!
        location2Label.text = (movieItem?.showingDay2)! + " " + (movieItem?.showingTime2)! + " " + (movieItem?.location2)!
        genre1Label.text = movieItem?.genre1
        genre2Label.text = movieItem?.genre2
        genre3Label.text = movieItem?.genre3
        plotLabel.text = movieItem?.plot
        posterImage.image = UIImage(named: (movieItem?.poster)!)

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: - Action Handlers
    @IBAction func addFavoritePressed(_ sender: UIBarButtonItem)
    {
        addFavoriteMovie(fTitle: movieItem?.title, fDate: movieItem?.showingDay1)
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func backPressed(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func addFavoriteMovie(fTitle: String?, fDate: String?)
    {
        let ft = fTitle
        let fd = fDate
        let uid = AppState.sharedInstance.uid
        ref = FIRDatabase.database().reference(withPath: "\(uid)")
        if let username = AppState.sharedInstance.displayName
        {
            let movieData = ["name" : username, "Title" : ft!, "Date" : fd!]
            ref.child(ft!).setValue(movieData)
        }
    }
}
