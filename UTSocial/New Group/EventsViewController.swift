//
//  EventsViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
    var posts = [PFObject]()

    @IBOutlet weak var tableView: UITableView!
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        myRefreshControl.addTarget(self, action: #selector(queryData), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.queryData()
    }
    
    @objc func queryData(){
        let query = PFQuery(className: "eventPost")
        query.includeKeys(["Title", "Time", "Description", "Poster"])
        query.order(byAscending: "Time")
        query.limit = 20
        
        query.findObjectsInBackground{
            (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }else {
                print("error!")
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
        let post = posts[indexPath.row]
        
        cell.TitleLabel.text = post["Title"] as? String
        cell.TimeLabel.text = post["Time"] as? String
        
        let imageFile = post["Poster"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.PosterView.af_setImage(withURL: url)
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (sender is UITableViewCell){
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let post = posts[indexPath.row]
            
            //Pass the selected movie to destination
            let detailsViewController = segue.destination as! EventDetailViewController
            detailsViewController.post = post
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    @IBAction func menuButton(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "menuVC") as? MenuTableViewController else {return}
        
        let navController = UINavigationController(rootViewController: menuVC)
        navController.modalPresentationStyle = .overCurrentContext
        navController.transitioningDelegate = self
        present(navController, animated: true, completion: nil)
    }
}
