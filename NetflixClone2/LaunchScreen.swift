//
//  LaunchScreen.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 11.02.2025.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import SnapKit
import Kingfisher
class LaunchScreen : UIViewController {
    
    let db = Firestore.firestore()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "netflixx")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        setupConstraints()
        loadData()
    }
    
    func loadData(){
        if let userId = Auth.auth().currentUser?.uid {
            Task{
                let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("isEnabled", isEqualTo: true).getDocuments()
                let count = profile.documents.count
                guard count != 0 else { return }
                if let profileImage = profile.documents[0].data()["profileImageURL"] as? String, let profileNamee = profile.documents[0].data()["profileName"] as? String {
                    let mvc = MainTabBarViewController()
                    mvc.profileName = profileNamee
                    mvc.profileImageURL = profileImage
                    mvc.userId = userId
                    let nvc = UINavigationController(rootViewController: mvc)
                    
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = nvc
                    }
                }
            }
        } else {
            let mvc = MainTabBarViewController()
            let nvc = UINavigationController(rootViewController: mvc)
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = nvc
            }
        }
    }
    
    func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
