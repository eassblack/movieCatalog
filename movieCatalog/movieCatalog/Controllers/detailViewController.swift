//
//  datailViewController.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import SwiftyJSON

//Controlador detalle de pelicula, contiene un scrollView y dentro se visualizan los detalles de la movie. Tambien se puede visualizar el trailes de la pelicula
class detailViewController: UIViewController {

    //Componentes de la inerfaz
    fileprivate var mainScroll: UIScrollView?
    fileprivate var headerImage : UIImageView?
    fileprivate var titleLabel : UILabel?
    fileprivate var descriptionLabel : UILabel?
    fileprivate var moreInfoLabel : UILabel?
    fileprivate var videoPlayer : YTPlayerView?
    
    //Data source
    fileprivate var detailMovie : movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }

    init(detailMovie: movie) {
        super.init(nibName: nil, bundle: nil)
        self.detailMovie = detailMovie
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Metodo que se ejecuta cada vez que la vista va a aparecer en la pantalla
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.lightGray]
    }
    
    ///Metodo que se encarga de crear y configurar el scrollView y los components para visualizar el detalle de la movie
    func loadComponets(){
        self.mainScroll = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(mainScroll!)
        self.mainScroll?.edgesToSuperview()
        self.mainScroll?.backgroundColor = UIColor(hexString: "141414")
        
        self.headerImage = UIImageView()
        self.mainScroll?.addSubview(headerImage!)
        self.headerImage?.topToSuperview()
        self.headerImage?.leftToSuperview()
        self.headerImage?.width(SCREEN_SIZE.width)
        self.headerImage?.height(200.0)
        self.headerImage?.contentMode = .scaleAspectFill
        getPoster(newMovie: self.detailMovie!, imageView: self.headerImage!, type: 1)
        
        self.titleLabel = UILabel()
        self.mainScroll?.addSubview(titleLabel!)
        self.titleLabel?.left(to: self.mainScroll!, nil, offset: 20.0, relation: .equal, priority: .required, isActive: true)
        self.titleLabel?.topToBottom(of: self.headerImage!, offset: 20.0, relation: .equal, priority: .required, isActive: true)
        self.titleLabel?.width(SCREEN_SIZE.width - 40.0)
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        self.titleLabel?.numberOfLines = 1
        self.titleLabel?.text = self.detailMovie?.getTitle()
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.titleLabel?.height((self.titleLabel?.font.lineHeight)!)
        
        self.descriptionLabel = UILabel()
        self.mainScroll?.addSubview(descriptionLabel!)
        self.descriptionLabel?.left(to: self.mainScroll!, nil, offset: 20.0, relation: .equal, priority: .required, isActive: true)
        self.descriptionLabel?.topToBottom(of: self.titleLabel!, offset: 10.0, relation: .equal, priority: .required, isActive: true)
        self.descriptionLabel?.width(SCREEN_SIZE.width - 40.0)
        self.descriptionLabel?.height(20.0, relation: .equalOrGreater, priority: .required, isActive: true)
        self.descriptionLabel?.lineBreakMode = .byTruncatingTail
        self.descriptionLabel?.numberOfLines = 100
        self.descriptionLabel?.text = self.detailMovie?.getOverview()
        self.descriptionLabel?.textColor = UIColor.lightGray
        self.descriptionLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        self.moreInfoLabel = UILabel()
        self.mainScroll?.addSubview(moreInfoLabel!)
        self.moreInfoLabel?.topToBottom(of: self.descriptionLabel!, offset: 10.0, relation: .equal, priority: .required, isActive: true)
        self.moreInfoLabel?.left(to: self.mainScroll!, nil, offset: 20.0, relation: .equal, priority: .required, isActive: true)
        self.moreInfoLabel?.width(SCREEN_SIZE.width - 40.0)
        self.moreInfoLabel?.height(20.0, relation: .equalOrGreater, priority: .required, isActive: true)
        self.moreInfoLabel?.lineBreakMode = .byTruncatingTail
        self.moreInfoLabel?.numberOfLines = 100
        self.moreInfoLabel?.textColor = UIColor.white
        self.moreInfoLabel?.font = UIFont.systemFont(ofSize: 10.0)
        var moreInfoText: String = "Release Date: " + (self.detailMovie?.getReleaseDate())! + " \n"
        if (self.detailMovie?.getGenres().count)! > 0 {
            moreInfoText += "Genres: "
            for item in (self.detailMovie?.getGenres())!{
                moreInfoText += item + " "
            }
            moreInfoText += " \n"
        }
        moreInfoText += "Vote Average: " + (self.detailMovie?.getVoteAverage().description)! + " \n"
        if self.detailMovie?.getRuntime() != nil{
            moreInfoText += "Runtime: " + (self.detailMovie?.getRuntime()?.description)! + "m \n"
        }
        if self.detailMovie?.getPage() != nil{
        moreInfoText += "Web Site: " + (self.detailMovie?.getPage())! + " \n"
        }
        self.moreInfoLabel?.text = moreInfoText
        if self.detailMovie?.getVideoId() != nil {
        self.videoPlayer = YTPlayerView(frame: CGRect.zero)
            self.videoPlayer?.load(withVideoId: (self.detailMovie?.getVideoId())!, playerVars: [
            "autoplay":1 , "playsinline":1 ,"controls" : 1 ,"loop":1 , "rel":0 , "showinfo":0  ,"fs":0 ,"disablekb":1 ])
        self.mainScroll?.addSubview(videoPlayer!)
            self.videoPlayer?.topToBottom(of: self.moreInfoLabel!, offset: 10.0, relation: .equal, priority: .required, isActive: true)
            self.videoPlayer?.left(to: self.mainScroll!, nil, offset: 20.0, relation: .equal, priority: .required, isActive: true)
            self.videoPlayer?.width(SCREEN_SIZE.width - 40.0)
            self.videoPlayer?.height(200.0)
            self.videoPlayer?.contentMode = .scaleAspectFill
            self.videoPlayer?.bottom(to: self.mainScroll!, nil, offset: 20.0, relation: .equal, priority: .required, isActive: true)
            
            self.mainScroll?.contentSize = CGSize(width: SCREEN_SIZE.width, height: (self.videoPlayer?.frame.maxY)! + 20.0)
            self.mainScroll?.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
            self.mainScroll?.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 20.0, right: 0.0)
            
        }else{
        self.moreInfoLabel?.bottom(to: self.mainScroll!, nil, offset: 20.0, relation: .equal, priority: .required, isActive: true)
            self.mainScroll?.contentSize = CGSize(width: SCREEN_SIZE.width, height: (self.moreInfoLabel?.frame.maxY)! + 20.0)
            self.mainScroll?.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
            self.mainScroll?.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 20.0, right: 0.0)
            
        }
        self.mainScroll?.contentOffset.y = 0.0
    }

    ///Metodo que se encarga de solicitar el datella de la movie y los videos para visualizar el triler
    func getData(){
        //Grupo para manejar las diferentes llamadas asincronas
        let downloadGroup = DispatchGroup()
        
        let videoURL = createUrl(type: 4, movieId: self.detailMovie?.getId(), searchKey: nil)
        downloadGroup.enter()
        getService(url: videoURL, httpMethod: "GET", data: JSON()) { (data) in
            if data != nil{
                if (data?["results"].arrayValue.count)! > 0{
                self.detailMovie?.setVideoId(videoId: (data?["results"][0]["key"].string)!)
                }
            }
            downloadGroup.leave()
        }
        let movieURL = createUrl(type: 5, movieId: self.detailMovie?.getId(), searchKey: nil)
        downloadGroup.enter()
        getService(url: movieURL, httpMethod: "GET", data: JSON()) { (data) in
            if data != nil{
                self.detailMovie = GLOBAL_MODEL.findMovie(data: data!)
            }
            downloadGroup.leave()
        }
        downloadGroup.notify(queue: DispatchQueue.main) {
            self.loadComponets()
        }
    }

}
