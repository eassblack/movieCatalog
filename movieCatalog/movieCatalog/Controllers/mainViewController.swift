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

//Controlador principal, contiene un tableView con cada una de las categorias y sus respectivas movies. contiene la barra de busqueda.
class mainViewController: UIViewController {
    
    ///Componentes
    fileprivate var mainTable : UITableView?
    fileprivate var searchView:UISearchController = UISearchController(searchResultsController: nil)
    
    ///Data Source
    fileprivate var seccionTitles: [String] = ["Popular","Top Rated","Upcoming"]
    fileprivate var moviesPopular:[movie] = []
    fileprivate var moviesTopRated:[movie] = []
    fileprivate var moviesUpcoming:[movie] = []
    fileprivate var moviesPopularSearch:[movie] = []
    fileprivate var moviesTopRatedSearch:[movie] = []
    fileprivate var moviesUpcomingSearch:[movie] = []
    fileprivate var moviesOnlineSearch: [movie] = []
    
    //Variables de control
    fileprivate var searchActive : Bool = false
    fileprivate var isOnlineSearch: Bool = false
    
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
    
    //Metodo que se ejecuta cada vez que la vista va a aparecer en la pantalla
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.lightGray]
        self.searchView.searchBar.isHidden = false
    }
    
    ///Metodo para crear la barra de busqueda
    func loadSearch(){
        self.searchView.searchResultsUpdater = self
        self.searchView.delegate = self
        self.searchView.searchBar.delegate = self
        
        self.searchView.hidesNavigationBarDuringPresentation = false
        self.searchView.dimsBackgroundDuringPresentation = true
        self.searchView.obscuresBackgroundDuringPresentation = false
        searchView.searchBar.placeholder = "Search for movies"
        searchView.searchBar.sizeToFit()
        searchView.searchBar.becomeFirstResponder()
        searchView.searchBar.barStyle = .blackTranslucent
        self.mainTable?.tableHeaderView = searchView.searchBar
    }
    
    ///Metodo para crear y configurar el tableViewPrincipal
    func loadComponent(){
        self.mainTable = UITableView(frame: CGRect.zero, style: .grouped)
        self.view.addSubview(self.mainTable!)
        self.mainTable?.translatesAutoresizingMaskIntoConstraints = false
        self.mainTable?.edges(to: self.view)
        self.loadSearch()
        self.mainTable?.backgroundColor = UIColor(hexString: "141414")
        self.mainTable?.backgroundView = UIView()
        self.view.backgroundColor = UIColor(hexString: "141414")
        self.mainTable!.showsVerticalScrollIndicator = false
        self.mainTable!.allowsSelection = false
        self.mainTable!.separatorColor = UIColor.clear
        self.mainTable!.delegate = self
        self.mainTable!.dataSource = self
        self.mainTable!.rowHeight = UITableViewAutomaticDimension
        self.mainTable!.estimatedRowHeight = 160
        for seccion in seccionTitles{
            self.mainTable!.register(categoryTableViewCell.self, forCellReuseIdentifier: seccion)
        }
        self.mainTable!.register(categoryTableViewCell.self, forCellReuseIdentifier: "search")
        self.getFistData()
    }
    
    ///Metodo para obtener la data de cada una de las categorias
    func getFistData(){
        let pupularURL = createUrl(type: 0, movieId: nil, searchKey: nil)
        getService(url: pupularURL, httpMethod: "GET", data: JSON()) { (data) in
            if data != nil{
                for item in (data?["results"].arrayValue)!{
                    let newMovie = GLOBAL_MODEL.findMovie(data: item)
                    if !self.moviesPopular.contains(where:{$0.getId() == newMovie.getId()}){
                        self.moviesPopular.append(newMovie)
                    }
                }
                self.mainTable?.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
        let topRatedURL = createUrl(type: 1, movieId: nil, searchKey: nil)
        getService(url: topRatedURL, httpMethod: "GET", data: JSON()) { (data) in
            if data != nil{
                for item in (data?["results"].arrayValue)!{
                    let newMovie = GLOBAL_MODEL.findMovie(data: item)
                    if !self.moviesTopRated.contains(where:{$0.getId() == newMovie.getId()}){
                        self.moviesTopRated.append(newMovie)
                    }
                }
                self.mainTable?.reloadSections(IndexSet(integer: 1), with: .none)
            }
        }
        let upcomingURL = createUrl(type: 2, movieId: nil, searchKey: nil)
        getService(url: upcomingURL, httpMethod: "GET", data: JSON()) { (data) in
            if data != nil{
                for item in (data?["results"].arrayValue)!{
                    let newMovie = GLOBAL_MODEL.findMovie(data: item)
                    if !self.moviesUpcoming.contains(where:{$0.getId() == newMovie.getId()}){
                        self.moviesUpcoming.append(newMovie)
                    }
                }
                self.mainTable?.reloadSections(IndexSet(integer: 2), with: .none)
            }
        }
    }
    //Metodo para obtener la barra de busqueda
    func getSearchBar()->UISearchBar{
        return self.searchView.searchBar
    }
}

///Metodos delegados del tableView
extension mainViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.isOnlineSearch ? 1:self.seccionTitles.count
    }
    
    ///Metodo que devuelve cada una de las filas del tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isOnlineSearch{
            //Caso que sea una busqueda online, se carga un collectionController en toda la interfaz
            tableView.isScrollEnabled = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "search") as! categoryTableViewCell
            cell.setMoviesSearch(categoryMovies: self.moviesOnlineSearch, Height: (self.mainTable?.frame.height)! - self.searchView.searchBar.frame.height - 50.0)
            return cell
        }else{
            //Caso contrario se cargan las categorias
            tableView.isScrollEnabled = true
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[0]) as! categoryTableViewCell
                cell.setMovies(categoryMovies: self.searchActive ? self.moviesPopularSearch : self.moviesPopular)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[1]) as! categoryTableViewCell
                cell.setMovies(categoryMovies: self.searchActive ? self.moviesTopRatedSearch : self.moviesTopRated)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[2]) as! categoryTableViewCell
                cell.setMovies(categoryMovies: self.searchActive ? self.moviesUpcomingSearch : self.moviesUpcoming)
                return cell
            default:
                print("seccion not handle")
                return UITableViewCell()
            }
        }
    }
    ///Metodo que devuelve los titulos de cada seccion dentro del tableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.isOnlineSearch ? nil : self.seccionTitles[section]
    }
}

///Metodos delegados de la barra de busqueda
extension mainViewController : UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    //MARK: Search Bar
    ///Metodo que se ejecuta cuando se cancela la busqueda
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true) {
            self.searchActive = false
            self.isOnlineSearch = false
            self.mainTable?.reloadData()
        }
    }
    
    //Metodo que se ejecuta cada vez que se escribe algo en la barra de busqueda
    func updateSearchResults(for searchController: UISearchController)
    {
        if searchView.searchBar.text != ""{
            searchActive = true
            let searchString = searchView.searchBar.text
            let searchURL = createUrl(type: 3, movieId: nil, searchKey: searchString)
            print(searchURL)
            getService(url: searchURL, httpMethod: "GET", data: JSON(), callback: { (data) in
                if data != nil {
                    self.isOnlineSearch = true
                    self.moviesOnlineSearch.removeAll()
                    for item in (data?["results"].arrayValue)!{
                        let newMovie = GLOBAL_MODEL.findMovie(data: item)
                        self.moviesOnlineSearch.append(newMovie)
                    }
                    self.mainTable?.reloadData()
                }else{
                    self.isOnlineSearch = false
                    self.moviesPopularSearch = self.moviesPopular.filter({$0.getTitle().containsIgnoringCase(searchString!)})
                    self.moviesTopRatedSearch = self.moviesTopRated.filter({$0.getTitle().containsIgnoringCase(searchString!)})
                    self.moviesUpcomingSearch = self.moviesUpcoming.filter({$0.getTitle().containsIgnoringCase(searchString!)})
                    self.mainTable?.reloadData()
                }
            })
        }else{
            if searchActive == true{
                searchActive = false
                self.isOnlineSearch = false
                self.mainTable?.reloadData()
            }
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            self.mainTable?.reloadData()
        }
        searchView.searchBar.resignFirstResponder()
    }
}
