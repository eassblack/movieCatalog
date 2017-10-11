//
//  movieCollectionViewCell.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit

/// Vista que representa cada una de las movies en los collectionsViews
class movieCollectionViewCell: UICollectionViewCell {
    fileprivate var imageMovie: UIImageView?
    fileprivate var movie : movie?
    
    
    /// Contructor de la interfaz
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
    
    
    /// Metodo que se llama cuando se reusa el componente
    override func prepareForReuse() {
        self.movie = nil
        self.imageMovie?.image = nil
    }
    
    
    /// Metodo para cambiar de una movie a otra
    ///
    /// - Parameter newMovie: nueva movie
    func setMovie(newMovie: movie){
        self.movie = newMovie
        getPoster(newMovie: self.movie!, imageView: self.imageMovie!,type: 0)
    }
    
}
