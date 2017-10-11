//
//  mainViewController.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit
import TinyConstraints
import SwiftyJSON

class mainViewController: UIViewController {
    
    fileprivate var mainTable : UITableView?
    fileprivate var seccionTitles: [String] = ["Popular","Top Rated","Upcoming"]
    fileprivate var moviesPopular:[movie] = []
    fileprivate var moviesTopRated:[movie] = []
    fileprivate var moviesUpcoming:[movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadComponent()
        self.title = "Movies Catalog"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadComponent(){
        self.mainTable = UITableView(frame: CGRect.zero, style: .grouped)
        self.view.addSubview(self.mainTable!)
        self.mainTable?.translatesAutoresizingMaskIntoConstraints = false
        self.mainTable?.edges(to: self.view)
        self.mainTable?.backgroundColor = UIColor.black
        self.mainTable!.showsVerticalScrollIndicator = false
        self.mainTable!.allowsSelection = false
        self.mainTable!.separatorColor = UIColor.gray
        self.mainTable!.delegate = self
        self.mainTable!.dataSource = self
        self.mainTable!.rowHeight = UITableViewAutomaticDimension
        self.mainTable!.estimatedRowHeight = 160
        for seccion in seccionTitles{
            self.mainTable!.register(categoryTableViewCell.self, forCellReuseIdentifier: seccion)
        }
        self.getFistData()
    }
    
    func getFistData(){
        
        let pupularURL = createUrl(type: 0, movieId: nil)
        getService(url: pupularURL, httpMethod: "GET", data: JSON()) { (data) in
            for item in data["results"].arrayValue{
                let newMovie = GLOBAL_MODEL.findMovie(data: item)
                if !self.moviesPopular.contains(where:{$0.getId() == newMovie.getId()}){
                    self.moviesPopular.append(newMovie)
                }
            }
            self.mainTable?.reloadSections(IndexSet(integer: 0), with: .none)
        }
        let topRatedURL = createUrl(type: 1, movieId: nil)
        getService(url: topRatedURL, httpMethod: "GET", data: JSON()) { (data) in
            for item in data["results"].arrayValue{
                let newMovie = GLOBAL_MODEL.findMovie(data: item)
                if !self.moviesTopRated.contains(where:{$0.getId() == newMovie.getId()}){
                    self.moviesTopRated.append(newMovie)
                }
            }
            self.mainTable?.reloadSections(IndexSet(integer: 1), with: .none)
        }
        let upcomingURL = createUrl(type: 2, movieId: nil)
        getService(url: upcomingURL, httpMethod: "GET", data: JSON()) { (data) in
            for item in data["results"].arrayValue{
                let newMovie = GLOBAL_MODEL.findMovie(data: item)
                if !self.moviesUpcoming.contains(where:{$0.getId() == newMovie.getId()}){
                    self.moviesUpcoming.append(newMovie)
                }
            }
            self.mainTable?.reloadSections(IndexSet(integer: 2), with: .none)
        }
    }
    
}

extension mainViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.seccionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[0]) as! categoryTableViewCell
            cell.setMovies(categoryMovies: self.moviesPopular)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[1]) as! categoryTableViewCell
            cell.setMovies(categoryMovies: self.moviesTopRated)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[2]) as! categoryTableViewCell
            cell.setMovies(categoryMovies: moviesUpcoming)
            return cell
        default:
            print("seccion not handle")
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.seccionTitles[section]
    }
    
    
    
}
