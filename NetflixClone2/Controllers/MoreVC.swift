//
//  MoreVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 13.02.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseAuth

class MoreVC: UIViewController {
    //MARK: Properties
    var userId: String = ""
    var documentId: String = ""
    let db = Firestore.firestore()
    
    //MARK: UI Elements
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.alignment = .leading
        return stackview
    }()
    
    let stackview2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profile Management", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(profileButton(_:)), for: .touchUpInside)
        button.titleEdgeInsets.left = -150
        button.imageEdgeInsets.left = -160
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(closeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(signOutButton(_:)), for: .touchUpInside)
        button.titleEdgeInsets.left = -270
        button.imageEdgeInsets.left = -280
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Setup Methods
    func setupViews(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(stackview2)
        
        stackview2.addArrangedSubview(profileButton)
        
        stackview2.addArrangedSubview(closeButton)
        
        stackView.addArrangedSubview(signOutButton)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        stackview2.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalToSuperview()
        }
        profileButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        signOutButton.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalToSuperview()
        }
    }
    
    //MARK: Actions
    @objc func closeButton(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    @objc func profileButton(_ sender: UIButton) {
        let pvc = ProfileVC()
        pvc.userId = userId
        let nvc = UINavigationController(rootViewController: pvc)
        nvc.modalPresentationStyle = .fullScreen
        nvc.isModalInPresentation = true
        Task{
            try await db.collection("Users").document(userId).collection("Profiles").document(documentId).updateData(["isEnabled": false])
            present(nvc, animated: true)
        }
    }
    
    @objc func signOutButton(_ sender: UIButton){
        let alert = UIAlertController(title: "Sign Out", message: "When you log out of your app, all other Netflix apps on this device will also be logged out.", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Cancel", style: .cancel)
        let action2 = UIAlertAction(title: "Sign Out", style: .default) { action2 in
            Task{
                try await self.db.collection("Users").document(self.userId).collection("Profiles").document(self.documentId).updateData(["isEnabled": false])
                try await Auth.auth().signOut()
                let lvc = LaunchScreen()
                lvc.isModalInPresentation = true
                lvc.modalPresentationStyle = .fullScreen
                self.present(lvc, animated: true)
            }
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
}
