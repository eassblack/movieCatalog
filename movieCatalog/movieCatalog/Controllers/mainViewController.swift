//
//  mainViewController.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 10/10/17.
//  Copyright © 2017 Edwin Sierra. All rights reserved.
//

import UIKit
import TinyConstraints

class mainViewController: UIViewController {
    
    fileprivate var mainTable : UITableView?
    fileprivate var seccionTitles: [String] = ["Popular","Top Rated","Upcoming"]
    
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
            cell.setMovies(categoryMovies: ["hola","chao","bye"])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[1]) as! categoryTableViewCell
            cell.setMovies(categoryMovies: ["hola","chao","bye"])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: seccionTitles[2]) as! categoryTableViewCell
            cell.setMovies(categoryMovies: ["hola","chao","bye"])
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
