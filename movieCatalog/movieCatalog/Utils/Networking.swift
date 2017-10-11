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

fileprivate var api_key = "15429c545386310822734aada8a1b95e"

func createUrl(type: Int,movieId: Int?)->String{
    var urlBase = "https://api.themoviedb.org/3/movie/"
    switch type {
    case 0:
        urlBase += "popular"
    case 1:
        urlBase += "top_rated"
    case 2:
        urlBase += "upcoming"
    case 3:
            let id : Int = movieId!
            let idString : String = "\(id)"
                urlBase += idString
            urlBase += "/videos"
    case 4:
            urlBase += "\(movieId!)"
    default:
        print("type not handle")
    }
    urlBase += "?api_key=" + api_key + "&language=en-US"
    if type < 3 && type > 0 {
        urlBase += "&page=1"
    }
    return urlBase
}

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
