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


