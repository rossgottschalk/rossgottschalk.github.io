//
//  FavoritesCell.swift
//  FilmFest2
//
//  Created by Tyler on 9/22/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var favoriteTitleLabel: UILabel!
    
    @IBOutlet weak var favoriteDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
