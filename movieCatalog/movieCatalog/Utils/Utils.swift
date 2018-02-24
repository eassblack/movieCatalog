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

///Tama;o de la pantalla en donde se esta ejecutando
let SCREEN_SIZE: CGRect = UIScreen.main.bounds

///manejador del modelo global
let GLOBAL_MODEL: modelHandler = modelHandler()

///Configuracion e inicializaion de la cache
let diskConfig = DiskConfig(name: "local")
let memoryConfig = MemoryConfig(expiry: .never, countLimit: 500, totalCostLimit: 524288000)
//Cache global
let GLOBAL_CACHE = try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)

func compareVectorMovies(movies1: [movie], movies2: [movie]) -> Bool{
    var array1 = movies1
    var array2 = movies2
    
    if array1.count != array2.count {
        return false
    }
    array1.sort() { $0.id > $1.id }
    array2.sort() {$0.id > $1.id }
    
    // get count of the matched items
    let result = zip(array1, array2).enumerated().filter() {
        $1.0.id == $1.1.id
        }.count
    
    if result == movies1.count {
        return true
    }
    
    return false
}
