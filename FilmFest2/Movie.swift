//
//  Movie.swift
//  FloridaFilmFest
//
//  Created by Tyler on 9/21/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase



class Movie
{
    
    
    let key: String
    
    let title: String
    let director1: String
    let director2: String
    let genre1: String
    let genre2: String
    let genre3: String
    let location1: String
    let location2: String
    let plot: String
    let poster: String
    let runTime: String
    let showingDay1: String
    let showingDay2: String
    let showingTime1: String
    let showingTime2: String
    let trailerLink: String
    var posterImage: UIImage?
    
    var favorited: Bool = true
    
    let ref: FIRDatabaseReference?
    
    
    init(title: String, director1: String, director2: String, genre1:String, genre2:String, genre3:String, location1:String, location2:String, plot:String, poster:String, runTime:String, showingDay1:String, showingDay2:String, showingTime1:String, showingTime2:String, trailerLink:String, key: String = "", posterImage: UIImage)
    {
        self.key = key
        
        self.title = title
        self.director1 = director1
        self.director2 = director2
        self.genre1 = genre1
        self.genre2 = genre2
        self.genre3 = genre3
        self.location1 = location1
        self.location2 = location2
        self.plot = plot
        self.poster = poster
        self.runTime = runTime
        self.showingDay1 = showingDay1
        self.showingDay2 = showingDay2
        self.showingTime1 = showingTime1
        self.showingTime2 = showingTime2
        self.trailerLink = trailerLink
        self.posterImage = UIImage(named: "\(poster)")!
        
        self.ref = nil
    }
    
    
    init(snapshot: FIRDataSnapshot)
    {
        let snapValue = snapshot.value as! NSDictionary
        
        key = snapshot.key
        
        title = snapValue["Title"] as! String
        director1 = snapValue["Director1"] as! String
        director2 = snapValue["Director2"] as! String
        genre1 = snapValue["Genre1"] as! String
        genre2 = snapValue["Genre2"] as! String
        genre3 = snapValue["Genre3"] as! String
        location1 = snapValue["Location1"] as! String
        location2 = snapValue["Location2"] as! String
        plot = snapValue["Plot"] as! String
        poster = snapValue["Poster"] as! String
        runTime = snapValue["RunTime"] as! String
        showingDay1 = snapValue["ShowingDay1"] as! String
        showingDay2 = snapValue["ShowingDay2"] as! String
        showingTime1 = snapValue["ShowingTime1"] as! String
        showingTime2 = snapValue["ShowingTime2"] as! String
        trailerLink = snapValue["TrailerLink"] as! String
        posterImage = UIImage(named: poster)
        
        
        ref = snapshot.ref
    }
    
    
    func toAnyObject() -> [String:String]
    {
        return [
            "Title": title as String,
            "Director1": director1 as String,
            "Director2": director2 as String,
            "Genre1": genre1 as String,
            "Genre2": genre2 as String,
            "Genre3": genre3 as String,
            "Location1": location1 as String,
            "Location2": location2 as String,
            "Plot": plot as String,
            "Poster": poster as String,
            "RunTime": runTime as String,
            "ShowingDay1": showingDay1 as String,
            "ShowingDay2": showingTime2 as String,
            "ShowingTime1": showingTime1 as String,
            "ShowingTime2": showingTime2 as String,
            "TrailerLink": trailerLink as String
        ]
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: genre1).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }

}
