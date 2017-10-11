//
//  modelHandler.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//
import SwiftyJSON

class modelHandler {
    
    // vectores globales para el manejo de la data
    fileprivate var movies:[movie] = []
    
    
    //-----------------------------------------------------------------------
    //--------------------Funciones para las movies---------------------------
    /**
     Funcion para agregar una nueva movie al vector global de movies
     
     - parameter data: **JSON** para construir la movie
     
     - returns: **movie**
     */
    private func addMovie(data : JSON) -> movie {
        movies.append(movie(data: data))
        return movies.last!
        
    }
    
    /**
     Funcion para encontrar una movie en el vector global de movies, de no conseguirla, la crea y la retorna
     
     - parameter data: **JSON** para construir la movie
     
     - returns: **movie**
     */
    func findMovie(data : JSON)-> movie {

        let movieIndex = movies.index(where: { $0.getId() == (data["id"].int)! })
        if movieIndex == nil {
            return self.addMovie(data: data)
        }
        movies[movieIndex!].loadMovieData(data: data)
        return movies[movieIndex!]
    }
    
    /**
     Funcion para encontrar una movie en el vector global de movies y retornarla
     
     - parameter movieId: **String** id de la movie a buscar
     
     - returns: **movie**
     */
    func getUser(movieId : Int)-> movie? {
        let movieIndex = movies.index(where: { $0.getId() == movieId })
        if movieIndex == nil {
            return nil
        }
        return movies[movieIndex!]
    }
}
