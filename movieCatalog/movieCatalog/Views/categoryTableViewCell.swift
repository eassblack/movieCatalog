//
//  categoryTableViewCell.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit

class categoryTableViewCell: UITableViewCell {

    fileprivate var moviesCollection : UICollectionView?
    fileprivate var flowLayout : UICollectionViewFlowLayout?
    
    
    /// DataSource
    fileprivate var categoryMovies : [movie] = []
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadComponents()
    }
    
    func setMovies(categoryMovies: [movie]){
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
}

extension categoryTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = detailViewController(detailMovie: self.categoryMovies[indexPath.row])
        self.parentViewController?.navigationController?.pushViewController(detail, animated: true)
    }
}
