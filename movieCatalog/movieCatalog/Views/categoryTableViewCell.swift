//
//  categoryTableViewCell.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit

/// Vista que representa cada uno de los row dentro del tableView principal y que contienen los CollectionsViews
class categoryTableViewCell: UITableViewCell {

    /// Componentess
    fileprivate var moviesCollection : UICollectionView?
    fileprivate var flowLayout : UICollectionViewFlowLayout?
    
    /// DataSource
    fileprivate var categoryMovies : [movie] = []
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    ///Metodo para cambiar de un vector de movies a otro
    func setMovies(categoryMovies: [movie]){
        if self.moviesCollection == nil{
        loadComponents()
        }
        self.categoryMovies = categoryMovies
        self.moviesCollection?.reloadData()
    }
    
    ///Metodo para cambiar de un vector de movies a otro proveniente de una busqueda online
    func setMoviesSearch(categoryMovies: [movie], Height: CGFloat){
        if self.moviesCollection == nil{
        loadComponentsSearch(Height: Height)
        }
        self.categoryMovies = categoryMovies
        self.moviesCollection?.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    ///Metodo que se encarga de contruir el collectionView horizontal para mostrar las movies de una  categoria
    func loadComponents(){
        self.backgroundColor = UIColor.clear
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout?.itemSize = CGSize(width: 100.0, height: 150.0)
        self.flowLayout?.scrollDirection = .horizontal
        self.flowLayout?.minimumInteritemSpacing = 5.0
        self.flowLayout?.minimumLineSpacing = 5.0
        self.flowLayout?.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        moviesCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout!)
        self.addSubview(moviesCollection!)
        moviesCollection?.backgroundColor = UIColor.clear
        moviesCollection?.edgesToSuperview()
        moviesCollection?.width(SCREEN_SIZE.width)
        moviesCollection?.height(160)
        moviesCollection!.delegate = self
        moviesCollection!.dataSource = self
        moviesCollection?.register(movieCollectionViewCell.self , forCellWithReuseIdentifier: NSStringFromClass(movieCollectionViewCell.self))
    }
    
    ///Metodo que se encarga de contruir el collectionView vertical para mostrar las movies de una busqueda
    func loadComponentsSearch(Height: CGFloat){
        self.backgroundColor = UIColor.clear
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout?.itemSize = CGSize(width: 100.0, height: 150.0)
        self.flowLayout?.scrollDirection = .vertical
        self.flowLayout?.minimumInteritemSpacing = 5.0
        self.flowLayout?.minimumLineSpacing = 5.0
        self.flowLayout?.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        moviesCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout!)
        self.addSubview(moviesCollection!)
        moviesCollection?.backgroundColor = UIColor.clear
        moviesCollection?.edgesToSuperview()
        moviesCollection?.width(SCREEN_SIZE.width)
        moviesCollection?.height(Height)
        moviesCollection!.delegate = self
        moviesCollection!.dataSource = self
        moviesCollection?.register(movieCollectionViewCell.self , forCellWithReuseIdentifier: NSStringFromClass(movieCollectionViewCell.self))
    }
}

//Metodos delegados del collectionView
extension categoryTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    ///Metodo que devuelve cada uno de los items del collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(movieCollectionViewCell.self), for: indexPath) as! movieCollectionViewCell
        cell.setMovie(newMovie: self.categoryMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryMovies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///Metdo que se ejecuta al momento de tocar un item dentro del collectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = detailViewController(detailMovie: self.categoryMovies[indexPath.row])
        if self.parentViewController is mainViewController{
        (self.parentViewController as! mainViewController).getSearchBar().isHidden = true
        }
        self.parentViewController?.navigationController?.pushViewController(detail, animated: true)
    }
}
