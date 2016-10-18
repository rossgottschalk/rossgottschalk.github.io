//
//  MoviesCollectionViewController.swift
//  FilmFest2
//
//  Created by Tyler on 9/21/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import AVFoundation
protocol SortDelegate
{
    func sortCategoryWasSelected(category: String)
}
class MoviesCollectionViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate, SortDelegate
{    
    var movieItems: [Movie] = []
    var sortedMovies: [Movie]?
    var ref: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle!
    var favoriteList: [Movie] = []
    var favoriteMovieSnaps = Array <FIRDataSnapshot>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllMovieData()
        
        
        // This is to get custom layout
        if let layout = collectionView?.collectionViewLayout as? MovieLayout
        {
           layout.delegate = self
        }
        collectionView!.backgroundColor = UIColor.gray
        collectionView!.contentInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        
        if !AppState.sharedInstance.signedIn
        {
            performSegue(withIdentifier: "ModalLoginSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
// MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sorted = sortedMovies
        {
            return sorted.count
        }
        else
        {
            return movieItems.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCell", for: indexPath) as! MoviePosterCell
        
        let movie = fetchMovie(index: indexPath.row)
        
        cell.titleLabelCVC.text = movie.title
        cell.genreLabelCVC.text = "\(movie.genre1)" + " \(movie.genre2)"
        cell.posterImageCVC.image = UIImage(named: movie.poster)

        return cell
    }
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "popoverSegue"
        {
            let popoverVC = segue.destination as! GenreTableViewController
            popoverVC.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverVC.preferredContentSize = CGSize(width: 150, height: 300)
            popoverVC.popoverPresentationController?.delegate = self
            popoverVC.delegate = self
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem)
    {
        do{
            try FIRAuth.auth()?.signOut()
            AppState.sharedInstance.signedIn = false
            print("Sign out successful")
            performSegue(withIdentifier: "ModalLoginSegue", sender: self)
        }catch let signOutError as NSError
        {
            print("Error signing out: \(signOutError)")
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailTableView") as! MovieDetailTableViewController
        let aMovie = fetchMovie(index: indexPath.item)
        movieDetailVC.movieItem = aMovie
        present(movieDetailVC, animated: true, completion: nil)
        
    }
    
//MARK: - Action Handlers
    func getAllMovieData ()
    {
        
        ref = FIRDatabase.database().reference(withPath: "Detail")
        
        ref.observe(.value, with: { snapshot in
            var snapMovies: [Movie] = []
            for item in snapshot.children {
                let aMovieItem = Movie(snapshot: item as! FIRDataSnapshot)
                snapMovies.append(aMovieItem)
            }
            self.movieItems = snapMovies
            self.collectionView?.reloadData()

        })
    }
    
    func sortCategoryWasSelected(category: String)
    {
        if let _ = sortedMovies
        {
            sortedMovies = nil
        }
        if (category != "All")
        {
            sortedMovies = [Movie]()
            
            for aMovie in movieItems
            {
                if aMovie.genre1 == category || aMovie.genre2 == category
                {
                    sortedMovies?.append(aMovie)
                }
                
            }
            collectionView?.reloadData()
            self.title = category
        }
        else
        {
            collectionView?.reloadData()
            self.title = ""
        }
    }
    
    //Decides whether to show all movies array or sorted movies array
    func fetchMovie(index: Int) -> Movie
    {
        let movie: Movie
        if let sorted = sortedMovies
        {
            movie = sorted[index]
        }
        else
        {
            movie = movieItems[index]
        }
        return movie
    }
}


// MARK: UICollectionViewDelegate

// This will be to have the collectionview conform to custom layout created in MovieLayout.
extension MoviesCollectionViewController : MovieLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    {
        let movie = fetchMovie(index: indexPath.item)
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: (movie.posterImage?.size)!, insideRect: boundingRect)
        return rect.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(30)
        
        let movie = fetchMovie(index: indexPath.item)
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = movie.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        
        return height
    }
}
