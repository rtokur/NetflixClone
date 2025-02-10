//
//  MainTabBarViewController.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import FirebaseAuth
import Kingfisher

class MainTabBarViewController: UITabBarController,Reload {
    
    // MARK: - Methods
    func reload() {
        viewWillAppear(true)
    }
    
    // MARK: - Properties
    var profileName: String = ""
    var profileImage: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //MARK: -Main Controllers
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: FavoriteVC())
        let vc3 = UINavigationController(rootViewController: SearchVC())
        let vc4 = UINavigationController(rootViewController: LoginVC())
        if Auth.auth().currentUser != nil {
//            let vc4 = UINavigationController(rootViewController:)
        }
        //MARK: -TabBar Symbols
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "plus")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(named: "unknown")
        if Auth.auth().currentUser != nil {
            vc4.tabBarItem.image = profileImage
        }
        //MARK: -TabBar Titles
        vc1.title = "Home"
        vc2.title = "Favorites"
        vc3.title = "Search"
        vc4.title = "Login"
        if Auth.auth().currentUser != nil{
            vc4.title = "My Netflix"
        }
        tabBar.tintColor = .label
        
        //MARK: -Adding VC
        setViewControllers([vc1,vc3,vc2,vc4], animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
}
