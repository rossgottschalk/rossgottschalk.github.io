//
//  MovieLayout.swift
//  FilmFest2
//
//  Created by Tyler on 10/2/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

protocol MovieLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class MoviesLayoutAttributes: UICollectionViewLayoutAttributes
{
    var photoHeight: CGFloat = 0.0
    
    override func copy(with zone: NSZone?) -> Any
    {
        let copy = super.copy(with: zone) as! MoviesLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool
    {
        if let attributtes = object as? MoviesLayoutAttributes
        {
            if( attributtes.photoHeight == photoHeight )
            {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}

class MovieLayout: UICollectionViewLayout
{
    var delegate: MovieLayoutDelegate!
    
    var numberOfColumns = 2
    var cellPadding: CGFloat = 15
    
    fileprivate var cache = [MoviesLayoutAttributes]()
    
    fileprivate var contentHeight: CGFloat = 0.0
    fileprivate var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override class var layoutAttributesClass : AnyClass
    {
        return MoviesLayoutAttributes.self
    }
    
    override func prepare()
    {
        cache.removeAll()
        if cache.isEmpty
        {
            
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns
            {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0)
            {
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = columnWidth - cellPadding * 2
                let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
                let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
                let height = cellPadding + photoHeight + annotationHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = MoviesLayoutAttributes(forCellWith: indexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                if column >= numberOfColumns - 1
                {
                    column = 0
                }
                else
                {
                    column += 1
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize
    {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache
        {
            if attributes.frame.intersects(rect)
            {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
}
