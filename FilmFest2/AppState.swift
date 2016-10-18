//
//  AppState.swift
//  TwoCans
//
//  Created by Ben Gohlke on 8/31/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit

class AppState: NSObject
{
    static let sharedInstance = AppState()
    
    var signedIn = false
    var displayName: String?
    var uid: String?
}
