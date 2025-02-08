//
//  MainTabBarViewController.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        //MARK: -Main Controllers
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: FavoriteVC())
        let vc3 = UINavigationController(rootViewController: SearchVC())
        //MARK: -TabBar Symbols
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "plus")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        //MARK: -TabBar Titles
        vc1.title = "Home"
        vc2.title = "Favorites"
        vc3.title = "Search"
        
        tabBar.tintColor = .label
        
        //MARK: -Adding VC
        setViewControllers([vc1,vc3,vc2], animated: true)
    }

}
