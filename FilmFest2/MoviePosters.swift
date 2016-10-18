//
//  MoviePosters.swift
//  FilmFest2
//
//  Created by Tyler on 10/3/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


class MoviePosters
{
    
    let key: String
    var ref: FIRDatabaseReference?
    
    var title: String
    var genre1: String
    var poster: String
    
    var moviePosterItems: [MoviePosters] = []
    
    
    init(title: String, genre1: String, poster: String, key: String)
    {
        self.title = title
        self.genre1 = genre1
        self.poster = poster
        self.key = key
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        let snapValue = snapshot.value as! NSDictionary
        
        key = snapshot.key
        ref = snapshot.ref
        
        title = snapValue["Title"] as! String
        genre1 = snapValue["Genre1"] as! String
        poster = snapValue["Poster"] as! String
    }
    
    func toAnyObject() -> [String:String]
    {
        return [
            "Title": title as String,
            "Genre1": genre1 as String,
            "Poster": poster as String
        ]
    }
    
    func allPosters() -> [MoviePosters]
    {
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference(withPath: "Detail")
        
        ref.observe(.value, with: { snapshot in
            var snapMovies: [MoviePosters] = []
            for item in snapshot.children {
                let aMoviePoster = MoviePosters(snapshot: item as! FIRDataSnapshot)
                snapMovies.append(aMoviePoster)
                print("***********************\(snapMovies.count)************************")
            }
            self.moviePosterItems = snapMovies
        })
    
        return moviePosterItems
    }
    
}
