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

protocol ReloadData: AnyObject {
    func didUpdateProfile()
}

class EditProfileVC: UIViewController {
    
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
        imageview.image = UIImage(named: "profile-icon-1")
        imageview.contentMode = .scaleAspectFit
        imageview.layer.cornerRadius = 5
        imageview.isUserInteractionEnabled = true
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
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()

        
        // Do any additional setup after loading the view.
    }
    // MARK: - Setup UI
    func setupViews(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(cancelButton)
        
        stackView2.addArrangedSubview(profileLabel)
        
        stackView2.addArrangedSubview(saveButton)
        
        stackView.addArrangedSubview(imageView)
        
        view.addSubview(editButton)
        
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
        if textField.text == "" {
            saveButton.isEnabled = false
            saveButton.setTitleColor(.lightGray, for: .normal)
        }else{
            saveButton.isEnabled = true
            saveButton.setTitleColor(.label, for: .normal)
        }
    }
    
    @objc func saveButtonAction(){
        let profileName = nameText.text
        let profileImage = imageView.image
        
        if let userId = Auth.auth().currentUser?.uid {
            Task {
                var downloadURL = ""
                let ref = storage.reference().child("Profiles/\(userId)/profile\(count+1).jpg")
                var data = Data()
                data = profileImage!.jpegData(compressionQuality: 0.8)!
                try await ref.putData(data, metadata: nil)
                downloadURL = try await ref.downloadURL().absoluteString
                
                try await db.collection("Users").document(userId).collection("Profiles").document().setData(["profileName":profileName,"profileImageURL":downloadURL])
                
                delegate?.didUpdateProfile()
                
                dismiss(animated: true)
            }
        }
    }
    
    @objc func cancelButtonAction(){
        dismiss(animated: true)
    }
}
