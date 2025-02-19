//
//  MainTabBarViewController.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import AVFoundation
import SnapKit
class MainTabBarViewController: UITabBarController{
    
    // MARK: - Properties
    var profileName: String = ""
    var profileImageURL: String = ""
    var userId: String = ""
    var documentId: String = ""
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        return activity
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    // MARK: - Setup Methods
    func setupViews(){
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
            //MARK: -Main Controllers
            var vc1 = UINavigationController(rootViewController: HomeVC())
            let vc2 = SearchVC()
            var vc3 = UINavigationController(rootViewController: LoginVC())
            
            //MARK: -TabBar Symbols
            vc1.tabBarItem.image = UIImage(systemName: "house")
            vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
            vc3.tabBarItem.image = UIImage(systemName: "person")
            
            //MARK: -TabBar Titles
            vc1.title = "Home"
            vc2.title = "Search"
            vc3.title = "Login"
            
            tabBar.tintColor = .white
            
            if userId != "" {
                let hvc = HomeVC()
                hvc.userId = userId
                hvc.documentId = documentId
                hvc.profileName = profileName
                vc1 = UINavigationController(rootViewController: hvc)
                vc1.title = "Home"
                vc1.tabBarItem.image = UIImage(systemName: "house")
                vc2.documentId = documentId
                vc2.userId = userId
                let mpvc3 = MyProfileVC()
                if let url = URL(string: profileImageURL) {
                    mpvc3.profileImage = profileImageURL
                    mpvc3.profileName = profileName
                    mpvc3.userId = userId
                    mpvc3.documentId = documentId
                    vc3 = UINavigationController(rootViewController: mpvc3)
                    vc3.title = profileName
                    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                        guard let data else { return }

                        do {
                            let image = UIImage(data: data)
                            let resized = image?.resize(25, 25).withRenderingMode(.alwaysOriginal)
                            DispatchQueue.main.async {
                                vc3.tabBarItem.image = resized
                            }
                        }catch {
                            print(error.localizedDescription)
                        }
                    }
                    task.resume()
                }
            }
            setViewControllers([vc1,vc2,vc3], animated: true)
            activityIndicator.stopAnimating()
        
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
