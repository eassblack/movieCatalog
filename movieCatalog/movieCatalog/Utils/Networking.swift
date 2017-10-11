//
//  Networking.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

///Clave de acceso a la API de TMBD
fileprivate var api_key = "15429c545386310822734aada8a1b95e"


/// funcion que se encarga de armar las diferentes urls segun los endPoints.
///
/// - Parameters:
///   - type: 0-Popular, 1-top_rates, 2-Upcoming, 3-Search, 4-Videos de una movie, 5-detalles de una movie
///   - movieId: para los tipos 4 y 5 se necesita el id de la movie
///   - searchKey: para el tipo 3 se debe pasar un string para la busqueda
/// - Returns: String con la url ya armada
func createUrl(type: Int,movieId: Int?,searchKey: String?)->String{
    var urlBase = "https://api.themoviedb.org/3/movie/"
    switch type {
    case 0:
        urlBase += "popular"
    case 1:
        urlBase += "top_rated"
    case 2:
        urlBase += "upcoming"
    case 3:
        urlBase = "https://api.themoviedb.org/3/search/movie"
    case 4:
            let id : Int = movieId!
            let idString : String = "\(id)"
                urlBase += idString
            urlBase += "/videos"
    case 5:
            urlBase += "\(movieId!)"
    default:
        print("type not handle")
    }
    urlBase += "?api_key=" + api_key + "&language=en-US"
    if type < 4 && type > 0 {
        urlBase += "&page=1"
        if type == 3{
            urlBase += "&query=\(searchKey!)&include_adult=false"
        }
    }
    return urlBase
}


/// Funcion generica para realizar peticiones a la API REST de TMDB
///
/// - Parameters:
///   - url: url del endPoint mas los parametros pasados por el metodo GET
///   - httpMethod: tipo de peticion: GET,POST,PUT,DELETE
///   - data: cuerpo de la peticion
///   - callback: para retornar los datos devueltos por la peticion. JSON-de ser satisfactoria, nil-si ocurre algun error
func getService(url: String ,httpMethod:String, data : JSON,callback: @escaping  (JSON?) -> Void){
    let urlRequest = URL(string: url)
    var request = URLRequest(url: urlRequest!)
    request.httpMethod = httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if data != JSON.null && !data.isEmpty {
        request.httpBody = try! data.rawData()
    }
    Alamofire.request(request)
        .responseJSON { response in
            switch response.result {
            case .failure(_):
                print("Error handle")
                callback(nil)
            case .success(let responseObject):
                let json = JSON(responseObject)
                callback(json)
                
            }
    }
}

/**
 Funcion para obtener las imagenes.
 */
func getPoster(newMovie : movie, imageView : UIImageView, type: Int) -> Void {
    var urlBase : String = "https://image.tmdb.org/t/p/w500"
    if type == 0 {
        guard let poster = newMovie.getPoster() else{return}
        urlBase += poster
    }else{
        guard let header = newMovie.getBackdropPath() else{return}
        urlBase += header
    }
    let posterMovie = URL(string: urlBase)
    let placeholder = imageView.image
    imageView.setImage(url: posterMovie!, placeholder: placeholder)
}
