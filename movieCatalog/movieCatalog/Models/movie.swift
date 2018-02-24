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

/// Modelo movie para el manejo dentro de la app
class movie{
    var id: Int!
    fileprivate var vote_average: Float?
    fileprivate var title: String?
    fileprivate var poster: String?
    fileprivate var overview: String?
    fileprivate var release_date: String?
    fileprivate var genres: [String] = []
    fileprivate var page: String?
    fileprivate var runtime: Int?
    fileprivate var video_id: String?
    fileprivate var backdrop_path: String?
    
    /**
     constructor de la clase movie
     - parameter data: JSON con toda la informacion de la movie.
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
    func getPoster()->String?{
        return self.poster != nil ? self.poster : nil
    }
    func getOverview()->String{
        return self.overview!
    }
    func getReleaseDate()->String{
        return self.release_date!
    }
    func getGenres()->[String]{
        return self.genres
    }
    func getPage()->String?{
        return self.page != nil ? self.page : nil
    }
    func getRuntime()->Int?{
        return self.runtime != nil ? self.runtime : nil
    }
    func getVideoId()->String?{
        return self.video_id != nil ? self.video_id : nil
    }
    func getBackdropPath()->String?{
        return self.backdrop_path != nil ? self.backdrop_path : nil
    }
    func setPage(page: String) {
        self.page = page
    }
    
    ///Setters
    func setRuntime(runtime: Int){
        self.runtime = runtime
    }
    func setVideoId(videoId:String) {
        self.video_id = videoId
    }
    
    /// Carga de la data
    ///
    /// - Parameter data: JSON data
    func loadMovieData(data: JSON){
        self.id = data["id"] != JSON.null ? data["id"].int : self.id
        self.vote_average = data["vote_average"] != JSON.null ? data["vote_average"].float : self.vote_average
        self.title = data["title"] != JSON.null ? data["title"].string : self.title
        self.poster = data["poster_path"] != JSON.null ? data["poster_path"].string : self.poster
        self.backdrop_path = data["backdrop_path"] != JSON.null ? data["backdrop_path"].string : self.backdrop_path
        self.overview = data["overview"] != JSON.null ? data["overview"].string : self.overview
        self.release_date = data["release_date"] != JSON.null ? data["release_date"].string : self.release_date
        if data["genres"] != JSON.null{
        for item in data["genres"].arrayValue{
            if item["name"] != JSON.null{
               self.genres.append(item["name"].string!)
            }
        }
        }
        self.page = data["page"] != JSON.null ? data["page"].string : self.page
        self.runtime = data["runtime"] != JSON.null ? data["runtime"].int : self.runtime
        self.video_id = data["video_id"] != JSON.null ? data["video_id"].string : self.video_id
    }
}

extension movie: Equatable {
    ///Funcion para poder comparar objetos de tipo movie
    static func == (lhs: movie, rhs: movie) -> Bool {
        return lhs.id == rhs.id
    }
}
