//
//  EditProfileVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 8.02.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Kingfisher
// MARK: - ReloadData Protocol
protocol ReloadData: AnyObject {
    func didUpdateProfile()
}

class EditProfileVC: UIViewController,ReLoadImage {
    // MARK: - Methods
    func ReloadImage(image: UIImage) {
        imageView.image = image
    }
    // MARK: - Properties
    var delegate: ReloadData?
    var count: Int = 0
    let db = Firestore.firestore()
    let storage = Storage.storage()
    // MARK: - UI Elements
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        stackview.alignment = .center
        return stackview
    }()
    
    let stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.isEnabled = true
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.layer.cornerRadius = 5
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        button.backgroundColor = .clear
        button.isEnabled = true
        button.tintColor = .label
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(IconAction), for: .touchUpInside)
        return button
    }()
    
    let nameText: UITextField = {
        let text = UITextField()
        text.placeholder = "Profile Name"
        text.textColor = .label
        text.tintColor = .systemGray3
        text.layer.cornerRadius = 5
        text.borderStyle = .roundedRect
        text.backgroundColor = .systemBackground
        let paddingView = UIView(frame: CGRectMake(0, 0, 10, text.frame.height))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.clipsToBounds = true
        text.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingChanged)
        return text
    }()
    var profileName: String?
    var profileImageURL : URL? = nil
    var firstImage: UIImage?
    var senderButton : Int = 0
    
    var iconList: [UIImage] = [UIImage(named: "profile-icon-1")!, UIImage(named: "profile-icon-2")!, UIImage(named: "profile-icon-3")!, UIImage(named: "profile-icon-4")!, UIImage(named: "profile-icon-5")!, UIImage(named: "profile-icon-6")!, UIImage(named: "profile-icon-7")!, UIImage(named: "profile-icon-8")!, UIImage(named: "profile-icon-9")!, UIImage(named: "profile-icon-10")!, UIImage(named: "profile-icon-11")!]
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }
    // MARK: - Setup UI
    func setupViews(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(cancelButton)
        
        stackView2.addArrangedSubview(profileLabel)
        
        stackView2.addArrangedSubview(saveButton)
        if let url = profileImageURL {
            imageView.kf.setImage(with: url)
            firstImage = imageView.image
        }else{
            imageView.image = iconList.randomElement()
        }
        stackView.addArrangedSubview(imageView)
        
        view.addSubview(editButton)
        
        if let name = profileName {
            nameText.text = name
        }
        stackView.addArrangedSubview(nameText)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.height.equalTo(218)
            make.width.equalToSuperview()
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        stackView2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(38)
        }
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        profileLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        saveButton.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        imageView.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        editButton.snp.makeConstraints { make in
            make.centerX.equalTo(imageView).multipliedBy(1.21)
            make.height.equalTo(35)
            make.width.equalTo(35)
            make.top.equalToSuperview().inset(128)
        }
        nameText.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }
    // MARK: - Actions
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if let name = profileName {
            if textField.text == name {
                saveButton.isEnabled = false
                saveButton.setTitleColor(.lightGray, for: .normal)
            } else{
                saveButton.isEnabled = true
                saveButton.setTitleColor(.label, for: .normal)
            }
        } else {
            if textField.text == "" {
                saveButton.isEnabled = false
                saveButton.setTitleColor(.lightGray, for: .normal)
            }else{
                saveButton.isEnabled = true
                saveButton.setTitleColor(.label, for: .normal)
            }
        }
        
    }
    
    @objc func saveButtonAction(){
        let profileNamee = nameText.text
        let profileImage = imageView.image
        if let userId = Auth.auth().currentUser?.uid {
            if let name = profileName {
                Task{
                    try await db.collection("Users").document(userId).collection("Profiles").document("profile\(count)").updateData(["profileName":profileNamee])
                    delegate?.didUpdateProfile()
                    dismiss(animated: true)
                }
            } else{
                Task {
                    var downloadURL = ""
                    let ref = storage.reference().child("Profiles/\(userId)/profile\(count+1).jpg")
                    var data = Data()
                    data = profileImage!.jpegData(compressionQuality: 0.2)!
                    try await ref.putData(data, metadata: nil)
                    downloadURL = try await ref.downloadURL().absoluteString
                    
                    try await db.collection("Users").document(userId).collection("Profiles").document("profile\(count+1)").setData(["profileName":profileNamee,"profileImageURL":downloadURL])
                    
                    delegate?.didUpdateProfile()
                    dismiss(animated: true)
                }
            }
        }
    }
    
    @objc func cancelButtonAction(){
        dismiss(animated: true)
    }
    
    @objc func IconAction(_ sender: UIButton) {
        let ivc = IconVC()
        ivc.delegate = self
        let nc = UINavigationController(rootViewController: ivc)
        present(nc, animated: true)
    }
}

