//
//  Utils.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import Foundation
import UIKit
import Cache
import Imaginary

let SCREEN_SIZE: CGRect = UIScreen.main.bounds
let GLOBAL_MODEL: modelHandler = modelHandler()

let diskConfig = DiskConfig(name: "local")
let memoryConfig = MemoryConfig(expiry: .never, countLimit: 500, totalCostLimit: 524288000)
//Cache global
let GLOBAL_CACHE = try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)

/**
 Funcion que extrae una imagen a partir de un thumbnail.
 */
func getPoster(newMovie : movie, imageView : UIImageView, type: Int) -> Void {
    var urlBase : String = "https://image.tmdb.org/t/p/w500"
    if type == 0 {
    urlBase += newMovie.getPoster()
    }else{
        urlBase += newMovie.getBackdropPath()
    }
    let posterMovie = URL(string: urlBase)
    let placeholder = imageView.image
    imageView.setImage(url: posterMovie!, placeholder: placeholder)
}
