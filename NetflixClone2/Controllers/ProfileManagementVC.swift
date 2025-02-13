//
//  ProfileManagementVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 12.02.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore
import Kingfisher

class ProfileManagementVC: UIViewController, ReloadData {
    //MARK: Protocol
    func didUpdateProfile() {
        viewWillAppear(true)
    }
    
    //MARK: Properties
    let db = Firestore.firestore()
    var userId: String = ""
    var documentId: String = ""
    var profiles: [Profile] = []
    var count: Int = 0
    
    // MARK: - UI Elements
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        return stackview
    }()
    
    let stackView2: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        return stackview
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "Change Profile"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .label
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(closeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 85)
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
    
    let profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profile Management", for: .normal)
        button.tintColor = .label
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.addTarget(self, action: #selector(profileAction), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getProfiles()
        setupViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup Methods
    func setupViews(){
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(label)
        
        stackView2.addArrangedSubview(closeButton)
        
        profileCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        stackView.addArrangedSubview(profileCollectionView)
        
        stackView.addArrangedSubview(profileButton)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        stackView2.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        profileCollectionView.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.width.equalToSuperview()
        }
        profileButton.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: Get Profiles
    func getProfiles(){
        if userId != ""{
            if documentId != "" {
                Task{
                    profiles.removeAll()
                    let profilee = try await db.collection("Users").document(userId).collection("Profiles").getDocuments()
                    count = profilee.documents.count
                    guard count != 0 else {
                        return
                    }
                    for profile in profilee.documents {
                        let isEnabled = profile.data()["isEnabled"] as? Bool
                        let profileImageURL = profile.data()["profileImageURL"] as? String
                        let profileName = profile.data()["profileName"] as? String
                        let prof = Profile(isEnabled: isEnabled, profileImageURL: profileImageURL, profileName: profileName)
                        profiles.append(prof)
                    }
                    profileCollectionView.reloadData()
                }
            }
        }
    }
    
    //MARK: Actions
    @objc func profileAction(_ sender: UIButton){
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
    
    @objc func closeButton(_ sender: UIButton){
        dismiss(animated: true)
    }
}

// MARK: - CollectionView Delegate & DataSource Methods
extension ProfileManagementVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if profiles.count == 4 {
            return profiles.count
        }
        return profiles.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        if indexPath.row == profiles.count {
            cell.imageView.image = UIImage(systemName: "plus")
            cell.label.text = "Add Profile"
            cell.imageView.tintColor = .label
        } else {
            let profile = profiles[indexPath.row]
            if let url = profile.profileImageURL {
                cell.imageView.kf.setImage(with: URL(string: url))
            }
            cell.label.text = profile.profileName
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == profiles.count {
            let evc = EditProfileVC()
            evc.delegate = self
            evc.userId = userId
            evc.count = count
            present(evc, animated: true)
        } else {
            let ls = LaunchScreen()
            ls.modalPresentationStyle = .fullScreen
            ls.isModalInPresentation = true
            let image = profiles[indexPath.row].profileImageURL
            ls.image = image!
            Task{
                if documentId == "profile\(indexPath.row + 1)" {
                    return
                } else {
                    try await db.collection("Users").document(userId).collection("Profiles").document(documentId).updateData(["isEnabled":false])
                    try await db.collection("Users").document(userId).collection("Profiles").document("profile\(indexPath.row + 1)").updateData(["isEnabled":true])
                    present(ls, animated: true)
                }
            }
            
        }
    }
    
}
