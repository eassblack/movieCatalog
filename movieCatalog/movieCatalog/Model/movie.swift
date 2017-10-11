//
//  movie.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class movie{
    fileprivate var id: Int?
    fileprivate var vote_average: Float?
    fileprivate var title: String?
    fileprivate var poster: String?
    fileprivate var overview: String?
    fileprivate var realease_date: String?
    fileprivate var genres: [String] = []
    fileprivate var page: String?
    fileprivate var runtime: Int?
    fileprivate var video_id: String?
    
    /**
     constructor de la clase movie
     - parameter data: JSON con toda la inforamcion del comentario.
     */
    init(data: JSON){
        loadMovieData(data: data)
    }
    
    /// Getters
    func getId()->Int{
        return self.id!
    }
    func getVoteAverage()->Float{
        return self.vote_average!
    }
    func getTitle()->String{
        return self.title!
    }
    func getPoster()->String{
        return self.poster!
    }
    func getOverview()->String{
        return self.overview!
    }
    func getReleaseDate()->String{
        return self.realease_date!
    }
    func getGenres()->[String]{
        return self.genres
    }
    func getPage()->String{
        return self.page!
    }
    func getRuntime()->Int{
        return self.runtime!
    }
    func getVideoId()->String{
        return self.video_id!
    }
    
    /// Carga de la data
    ///
    /// - Parameter data: JSON data
    func loadMovieData(data: JSON){
        self.id = data["id"] != JSON.null ? data["id"].int : self.id
        self.vote_average = data["vote_average"] != JSON.null ? data["vote_average"].float : self.vote_average
        self.title = data["title"] != JSON.null ? data["title"].string : self.title
        self.poster = data["poster_path"] != JSON.null ? data["poster_path"].string : self.poster
        
        self.overview = data["overview"] != JSON.null ? data["overview"].string : self.overview
        self.realease_date = data["realease_date"] != JSON.null ? data["realease_date"].string : self.realease_date
        if data["genres"] != JSON.null{
        for item in data["genres"].arrayValue{
            self.genres.append(item.string!)
        }
        }
        self.page = data["page"] != JSON.null ? data["page"].string : self.page
        self.runtime = data["runtime"] != JSON.null ? data["runtime"].int : self.runtime
        self.video_id = data["video_id"] != JSON.null ? data["video_id"].string : self.video_id
    }
}