//
//  ProfileVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 8.02.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore
import Kingfisher

class ProfileVC: UIViewController, ReloadData{
    
    // MARK: - Methods
    func didUpdateProfile() {
        getProfileData()
        
        imageView.image = UIImage(systemName: "plus")
        imageView2.image = UIImage(systemName: "plus")
        imageView3.image = UIImage(systemName: "plus")
        imageView4.image = UIImage(systemName: "plus")
        
        label1.text = "Add Profile"
        label2.isHidden = true
        label2.text = "Add Profile"
        label3.isHidden = true
        label3.text = "Add Profile"
        label4.isHidden = true
        label4.text = "Add Profile"
        
        imageView2.isHidden = true
        imageView3.isHidden = true
        imageView4.isHidden = true
        
        vieww.isHidden = true
        vieww2.isHidden = true
        vieww3.isHidden = true
        vieww4.isHidden = true
        
        navigationItem.rightBarButtonItem?.title = "Edit"
        
        
    }
    
    // MARK: - Properties
    let db = Firestore.firestore()
    var count : Int = 0
    var profileUrll: String = ""
    var profileUrll2: String = ""
    var profileUrll3: String = ""
    var profileUrll4: String = ""
    var userId: String = ""
    
    // MARK: - UI Elements
    let stackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 40
        return stackview
    }()
    
    let stackView2 : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 25
        return stackview
    }()
    
    let stackView4: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .clear
        imageview.layer.borderColor = UIColor .lightGray.cgColor
        imageview.layer.borderWidth = 1
        imageview.tintColor = .white
        imageview.layer.cornerRadius = 5
        imageview.clipsToBounds = true
        imageview.isUserInteractionEnabled = true
        imageview.image = UIImage(systemName: "plus")
        imageview.tag = 1
        return imageview
    }()
    
    let vieww : UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.tag = 1
        return view
    }()
    
    let pencilView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "pencil"))
        image.tintColor = .white
        return image
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let stackView5: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let imageView2: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .clear
        imageview.layer.borderColor = UIColor .lightGray.cgColor
        imageview.layer.borderWidth = 1
        imageview.tintColor = .white
        imageview.layer.cornerRadius = 5
        imageview.clipsToBounds = true
        imageview.isUserInteractionEnabled = true
        imageview.image = UIImage(systemName: "plus")
        imageview.isHidden = true
        imageview.tag = 2
        return imageview
    }()
    
    let vieww2 : UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.isHidden = true
        view.tag = 2
        return view
    }()
    
    let pencilView2 : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "pencil"))
        image.tintColor = .white
        return image
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let stackView3 : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 25
        return stackview
    }()
    
    let stackView6: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let imageView3: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .clear
        imageview.layer.borderColor = UIColor .lightGray.cgColor
        imageview.layer.borderWidth = 1
        imageview.tintColor = .white
        imageview.layer.cornerRadius = 5
        imageview.clipsToBounds = true
        imageview.isUserInteractionEnabled = true
        imageview.image = UIImage(systemName: "plus")
        imageview.isHidden = true
        imageview.tag = 3
        return imageview
    }()
    
    let vieww3 : UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.isHidden = true
        view.tag = 3
        return view
    }()
    
    let pencilView3 : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "pencil"))
        image.tintColor = .white
        return image
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let stackView7: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let imageView4: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .clear
        imageview.layer.borderColor = UIColor .lightGray.cgColor
        imageview.layer.borderWidth = 1
        imageview.tintColor = .white
        imageview.layer.cornerRadius = 5
        imageview.clipsToBounds = true
        imageview.isUserInteractionEnabled = true
        imageview.image = UIImage(systemName: "plus")
        imageview.isHidden = true
        imageview.tag = 4
        return imageview
    }()
    
    let vieww4 : UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.tag = 4
        return view
    }()
    
    let pencilView4: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "pencil"))
        image.tintColor = .white
        return image
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let navLabel: UILabel = {
        let label = UILabel()
        label.text = "Who is watching?"
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getProfileData()
        setupViews()
        setupConstraints()
        navigationItem.titleView = navLabel
        navigationController?.navigationBar.isTranslucent = true
        var editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonAction))
        editButton.tintColor = .label
        navigationItem.rightBarButtonItem = editButton
    }
    
    // MARK: - Firebase Methods
    func getProfileData(){
        if userId != "" {
            Task{
                do {
                    let profiles = try await db.collection("Users").document(userId).collection("Profiles").getDocuments()
                    
                    count = profiles.documents.count
                    
                    guard count != 0 else {
                        return
                    }
                    
                    if let profile = profiles.documents[0].data()["profileName"] as? String, let profileUrl = profiles.documents[0].data()["profileImageURL"] as? String {
                        label1.text = profile
                        profileUrll = profileUrl
                        let profileURL = URL(string: profileUrl)
                        imageView.kf.setImage(with: profileURL)
                        imageView2.isHidden = false
                        label2.isHidden = false
                        if count > 1 ,let profile2 = profiles.documents[1].data()["profileName"] as? String, let profileUrl2 = profiles.documents[1].data()["profileImageURL"] as? String{
                            imageView3.isHidden = false
                            label3.isHidden = false
                            label2.text = profile2
                            profileUrll2 = profileUrl2
                            let profileURL2 = URL(string: profileUrl2)
                            imageView2.kf.setImage(with: profileURL2)
                            if count > 2, let profile3 = profiles.documents[2].data()["profileName"] as? String, let profileUrl3 = profiles.documents[2].data()["profileImageURL"] as? String {
                                imageView4.isHidden = false
                                label4.isHidden = false
                                label3.text = profile3
                                profileUrll3 = profileUrl3
                                let profileURL3 = URL(string: profileUrl3)
                                imageView3.kf.setImage(with: profileURL3)
                                if count > 3, let profile4 = profiles.documents[3].data()["profileName"] as? String,let profileUrl4 = profiles.documents[3].data()["profileImageURL"] as? String {
                                    label4.text = profile4
                                    profileUrll4 = profileUrl4
                                    let profileURL4 = URL(string: profileUrl4)
                                    imageView4.kf.setImage(with: profileURL4)
                                }
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
                
                
            }
        }
    }
    
    // MARK: - Setup Methods
    func setupViews(){
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(stackView4)
        
        vieww.addSubview(pencilView)
        stackView4.addArrangedSubview(imageView)
        let tapView = UITapGestureRecognizer(target: self, action: #selector(EditProfile(_:)))
        vieww.addGestureRecognizer(tapView)
        vieww.isHidden = true
        view.addSubview(vieww)
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditProfileAction(_:)))
        imageView.addGestureRecognizer(tap)
        
        stackView4.addArrangedSubview(label1)
        
        stackView2.addArrangedSubview(stackView5)
        
        vieww2.addSubview(pencilView2)
        stackView5.addArrangedSubview(imageView2)
        let tapView2 = UITapGestureRecognizer(target: self, action: #selector(EditProfile(_:)))
        vieww2.addGestureRecognizer(tapView2)
        vieww2.isHidden = true
        view.addSubview(vieww2)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(EditProfileAction(_:)))
        imageView2.addGestureRecognizer(tap2)
        
        stackView5.addArrangedSubview(label2)
        
        stackView.addArrangedSubview(stackView3)
        
        stackView3.addArrangedSubview(stackView6)
        
        vieww3.addSubview(pencilView3)
        stackView6.addArrangedSubview(imageView3)
        let tapView3 = UITapGestureRecognizer(target: self, action: #selector(EditProfile(_:)))
        vieww3.addGestureRecognizer(tapView3)
        vieww3.isHidden = true
        view.addSubview(vieww3)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(EditProfileAction(_:)))
        imageView3.addGestureRecognizer(tap3)
        
        stackView6.addArrangedSubview(label3)
        
        stackView3.addArrangedSubview(stackView7)
        

        vieww4.addSubview(pencilView4)
        stackView7.addArrangedSubview(imageView4)
        let tapView4 = UITapGestureRecognizer(target: self, action: #selector(EditProfile(_:)))
        vieww4.addGestureRecognizer(tapView4)
        vieww4.isHidden = true
        view.addSubview(vieww4)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(EditProfileAction(_:)))
        imageView4.addGestureRecognizer(tap4)
        
        stackView7.addArrangedSubview(label4)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(245)
            make.height.equalTo(316)
        }
        stackView2.snp.makeConstraints { make in
            make.height.equalTo(138)
            make.width.equalToSuperview()
        }
        stackView4.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(110)
        }
        vieww.snp.makeConstraints { make in
            make.edges.equalTo(imageView)
        }
        pencilView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(35)
        }
        label1.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        stackView5.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalToSuperview()
        }
        imageView2.snp.makeConstraints { make in
            make.height.equalTo(110)
        }
        vieww2.snp.makeConstraints { make in
            make.edges.equalTo(imageView2)
        }
        pencilView2.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(35)
        }
        label2.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        stackView3.snp.makeConstraints { make in
            make.height.equalTo(138)
            make.width.equalToSuperview()
        }
        stackView6.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalToSuperview()
        }
        imageView3.snp.makeConstraints { make in
            make.height.equalTo(110)
        }
        vieww3.snp.makeConstraints { make in
            make.edges.equalTo(imageView3)
        }
        pencilView3.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(35)
        }
        label3.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        stackView7.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalToSuperview()
        }
        imageView4.snp.makeConstraints { make in
            make.height.equalTo(110)
        }
        vieww4.snp.makeConstraints { make in
            make.edges.equalTo(imageView4)
        }
        pencilView4.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(35)
        }
        label4.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
    }
    // MARK: - Actions
    @objc func EditProfileAction(_ sender: UITapGestureRecognizer) {
        let tappedImageView = sender.view as? UIImageView
        if tappedImageView?.image == UIImage(systemName: "plus") {
            let evc = EditProfileVC()
            evc.delegate = self
            evc.userId = userId
            evc.deleteButton.isHidden = true
            evc.stackView.snp.updateConstraints { make in
                make.height.equalTo(218)
            }
            present(evc, animated: true)
        }
        else {
            let ls = LaunchScreen()
            ls.modalPresentationStyle = .fullScreen
            ls.isModalInPresentation = true
            if tappedImageView?.tag == 1 {
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label1.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    try await db.collection("Users").document(userId).collection("Profiles").document(documentId).updateData(["isEnabled":true])
                    ls.image = profileUrll
                    present(ls, animated: true)
                }
            } else if tappedImageView?.tag == 2 {
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label2.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    try await db.collection("Users").document(userId).collection("Profiles").document(documentId).updateData(["isEnabled":true])
                    ls.image = profileUrll2
                    present(ls, animated: true)
                }
            } else if tappedImageView?.tag == 3 {
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label3.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    try await db.collection("Users").document(userId).collection("Profiles").document(documentId).updateData(["isEnabled":true])
                    ls.image = profileUrll3
                    present(ls, animated: true)
                }
            } else {
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label4.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    try await db.collection("Users").document(userId).collection("Profiles").document(documentId).updateData(["isEnabled":true])
                    ls.image = profileUrll4
                    present(ls, animated: true)
               }
           }
        }
    }
    
    @objc func EditProfile(_ sender: UITapGestureRecognizer){
        let tappedView = sender.view
        if vieww.isHidden == false{
            let evc = EditProfileVC()
            if tappedView?.tag == 1 {
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label1.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    evc.profileName = label1.text ?? ""
                    evc.profileImageURL = profileUrll
                    evc.documentId = documentId
                    evc.delegate = self
                    evc.userId = userId
                    present(evc, animated: true)
                }
            } else if tappedView?.tag == 2{
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label2.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    evc.profileName = label2.text ?? ""
                    evc.profileImageURL = profileUrll2
                    evc.documentId = documentId
                    evc.delegate = self
                    evc.userId = userId

                    present(evc, animated: true)
                }
            }else if tappedView?.tag == 3{
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label3.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    evc.profileName = label3.text ?? ""
                    evc.profileImageURL = profileUrll3
                    evc.documentId = documentId
                    evc.delegate = self
                    evc.userId = userId
                    present(evc, animated: true)
                }
            } else if tappedView?.tag == 4{
                Task{
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("profileName", isEqualTo: label4.text).getDocuments()
                    let documentId = profile.documents[0].documentID
                    evc.profileName = label4.text ?? ""
                    evc.profileImageURL = profileUrll4
                    evc.documentId = documentId
                    evc.delegate = self
                    evc.userId = userId
                    present(evc, animated: true)
                }
            }
            
        }
    }
    
    @objc func editButtonAction(_ sender: UIBarButtonItem){
        if sender.title == "Edit" {
            sender.title = "Okey"
            if imageView.image != UIImage(systemName: "plus") {
                vieww.isHidden = false
                if imageView2.image != UIImage(systemName: "plus") {
                    vieww2.isHidden = false
                    if imageView3.image != UIImage(systemName: "plus") {
                        vieww3.isHidden = false
                        if imageView4.image != UIImage(systemName: "plus") {
                            vieww4.isHidden = false
                        }
                    }
                }
            }
        } else {
            sender.title = "Edit"
            if imageView.image != UIImage(systemName: "plus") {
                vieww.isHidden = true
                if imageView2.image != UIImage(systemName: "plus") {
                    vieww2.isHidden = true
                    if imageView3.image != UIImage(systemName: "plus") {
                        vieww3.isHidden = true
                        if imageView4.image != UIImage(systemName: "plus") {
                            vieww4.isHidden = true
                        }
                    }
                }
            }
        }
        
    }
}
