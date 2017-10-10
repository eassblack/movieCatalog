//
//  movieCollectionViewCell.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit

class movieCollectionViewCell: UICollectionViewCell {
    fileprivate var imageMovie: UIImageView?
    //fileprivate var movie : movie?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageMovie = UIImageView()
        self.addSubview(imageMovie!)
        imageMovie?.edgesToSuperview()
        imageMovie?.width(100.0)
        imageMovie?.height(150.0)
        imageMovie?.backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMovie(/*newMovie: moviep*/){
        //self.movie = movie
    }
}
