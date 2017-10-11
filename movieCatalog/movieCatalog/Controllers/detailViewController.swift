//
//  datailViewController.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    fileprivate var mainScroll: UIScrollView?
    fileprivate var headerImage : UIImageView?
    fileprivate var titleLabel : UILabel?
    fileprivate var descriptionLabel : UILabel?
    
    fileprivate var detailMovie : movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadComponets()
        // Do any additional setup after loading the view.
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
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.lightGray]
    }
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
        self.descriptionLabel?.topToBottom(of: self.titleLabel!)
        self.descriptionLabel?.width(SCREEN_SIZE.width - 40.0)
        self.descriptionLabel?.height(20.0, relation: .equalOrGreater, priority: .required, isActive: true)
        self.descriptionLabel?.lineBreakMode = .byTruncatingTail
        self.descriptionLabel?.numberOfLines = 100
        self.descriptionLabel?.text = self.detailMovie?.getOverview()
        self.descriptionLabel?.textColor = UIColor.lightGray
        self.descriptionLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.descriptionLabel?.bottom(to: self.mainScroll!, nil, offset: 20.0, relation: .equal, priority: .required, isActive: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
