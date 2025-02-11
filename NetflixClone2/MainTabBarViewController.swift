//
//  MainTabBarViewController.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import AVFoundation
class MainTabBarViewController: UITabBarController{
    
    // MARK: - Properties
    var profileName: String = ""
    var profileImageURL: String = ""
    var userId: String = ""
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        //MARK: -Main Controllers
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: SearchVC())
        var vc3 = UINavigationController(rootViewController: LoginVC())

        //MARK: -TabBar Symbols
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(named: "unknown")
        
        //MARK: -TabBar Titles
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Login"
        
        tabBar.tintColor = .label
        
        if userId != "" {
            vc3 = UINavigationController(rootViewController: MyProfileVC())
            let data = try? Data(contentsOf: URL(string: profileImageURL)!)
            guard let data else { return }
            let image = UIImage(data: data)
            let resized = image?.resize(25, 25)
            vc3.tabBarItem.image = resized
            vc3.title = profileName
        }
        setViewControllers([vc1,vc2,vc3], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
}

public extension UIImage {
    /// Resize image while keeping the aspect ratio. Original image is not modified.
    /// - Parameters:
    ///   - width: A new width in pixels.
    ///   - height: A new height in pixels.
    /// - Returns: Resized image.
    func resize(_ width: Int, _ height: Int)-> UIImage {
        // Keep aspect ratio
        let maxSize = CGSize(width: width, height: height)
        let availableRect = AVFoundation.AVMakeRect(aspectRatio: self.size, insideRect: .init(origin: .zero, size: maxSize))
        let targetSize = availableRect.size
        
        // Set scale of renderer so that 1pt == 1px
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        
        // Resize the image
        let resized = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        
        return resized
    }
}
