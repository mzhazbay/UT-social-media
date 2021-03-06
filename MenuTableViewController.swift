//
//  MenuTableViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/11/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case home
    case sublease
    case buy
    case events }

class MenuTableViewController: UITableViewController {
    
    @IBOutlet weak var homeImageView: UIImageView!
    
    @IBOutlet weak var subleaseImageView: UIImageView!
    
    @IBOutlet weak var buySellImageView: UIImageView!
    
    @IBOutlet weak var eventsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        homeImageView.image = #imageLiteral(resourceName: "uttower")
        subleaseImageView.image = #imageLiteral(resourceName: "sublease")
        buySellImageView.image = #imageLiteral(resourceName: "buysell")
        eventsImageView.image = #imageLiteral(resourceName: "events")
        
        homeImageView.tintColor = .orange
        subleaseImageView.tintColor = .orange
        buySellImageView.tintColor = .orange
        eventsImageView.tintColor = .orange
        
        homeImageView.backgroundColor = .orange
        subleaseImageView.backgroundColor = .orange
        buySellImageView.backgroundColor = .orange
        eventsImageView.backgroundColor = .orange
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuType = MenuType(rawValue: indexPath.row)
        switch menuType as! MenuType {
        case .home:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeNavController") as? UINavigationController else {return}
            present(homeVC, animated: true, completion: nil)
            
        case .sublease:
            let SubleaseStoryboard = UIStoryboard(name: "Sublease", bundle: nil)
            if let vc = SubleaseStoryboard.instantiateViewController(withIdentifier: "subleaseNavCon") as? UINavigationController {
                present(vc, animated: true, completion: nil)
            }
            
        case .buy:
            let buySellVC = BuySellViewController()
            let navController = UINavigationController(rootViewController: buySellVC)
            present(navController, animated: true, completion: nil)
       
        case .events:
            let EventsStoryboard = UIStoryboard(name: "Events", bundle: nil)
            if let vc = EventsStoryboard.instantiateViewController(withIdentifier: "events") as? EventsViewController {
                present(vc, animated: true, completion: nil)
            }
        }
        //dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func dismissMenu(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
//end of class
}
