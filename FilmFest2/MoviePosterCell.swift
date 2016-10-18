//
//  MovieCell.swift
//  FilmFest2
//
//  Created by Tyler on 9/22/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

class MoviePosterCell: UICollectionViewCell
{
    @IBOutlet weak var posterImageCVC: UIImageView!
    @IBOutlet weak var titleLabelCVC: UILabel!
    @IBOutlet weak var genreLabelCVC: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var posterButton: UIButton!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                posterImageCVC.image = movie.posterImage
                titleLabelCVC.text = movie.title
                genreLabelCVC.text = movie.genre1
            }
        }
    }

    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
    {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? MoviesLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
    
}
