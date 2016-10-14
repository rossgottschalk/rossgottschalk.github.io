//
//  PlayerClass.swift
//  Swift-GrailDiary
//
//  Created by Ross Gottschalk on 8/17/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation

class PlayerClass
{
    let name: String
    let position: String
    let team: String
    let picture: String
    let teamLogo: String
    let stats: String
    
    init(dictionary: NSDictionary)
    {
        name = dictionary["name"] as! String
        position = dictionary["position"] as! String
        team = dictionary["team"] as! String
        picture = dictionary["picture"] as! String
        teamLogo = dictionary["teamLogo"] as! String
        stats = dictionary["accolades"] as! String
    }
}
