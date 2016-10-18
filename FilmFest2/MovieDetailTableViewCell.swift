//
//  MovieDetailTableViewCell.swift
//  FilmFest2
//
//  Created by Tyler on 10/1/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell

{
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

    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
