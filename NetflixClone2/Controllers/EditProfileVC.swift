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
import Kingfisher
// MARK: - ReloadData Protocol
protocol ReloadData: AnyObject {
    func didUpdateProfile()
}

class EditProfileVC: UIViewController,ReLoadImage {
    // MARK: - Methods
    func ReloadImage(image: UIImage) {
        imageView.image = image
        checkForChanges()
    }
    
    // MARK: - Properties
    var delegate: ReloadData?
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var userId : String = ""
    var documentId: String = ""
    var profileName: String = ""
    var profileImageURL : String = ""
    var firstImage: UIImage?
    var iconList: [UIImage] = [UIImage(named: "profile-icon-1")!, UIImage(named: "profile-icon-2")!, UIImage(named: "profile-icon-3")!, UIImage(named: "profile-icon-4")!, UIImage(named: "profile-icon-5")!, UIImage(named: "profile-icon-6")!, UIImage(named: "profile-icon-7")!, UIImage(named: "profile-icon-8")!, UIImage(named: "profile-icon-9")!, UIImage(named: "profile-icon-10")!, UIImage(named: "profile-icon-11")!]
    
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
    
    let deleteButton : UIButton = {
        let button = UIButton()
        button.setTitle("Delete Profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        checkForChanges()
    }
    
    // MARK: - Save Button enabled setting
    func checkForChanges(){
        if firstImage == imageView.image {
            saveButton.isEnabled = false
            saveButton.setTitleColor(.lightGray, for: .normal)
        } else{
            saveButton.isEnabled = true
            saveButton.setTitleColor(.label, for: .normal)
        }
    }
    
    // MARK: - Setup UI
    func setupViews(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(cancelButton)
        
        stackView2.addArrangedSubview(profileLabel)
        
        stackView2.addArrangedSubview(saveButton)
        if profileImageURL != "" {
            imageView.kf.setImage(with: URL(string: profileImageURL))
            firstImage = imageView.image
        }else{
            imageView.image = iconList.randomElement()
        }
        stackView.addArrangedSubview(imageView)
        
        view.addSubview(editButton)
        
        if profileName != "" {
            nameText.text = profileName
        }
        stackView.addArrangedSubview(nameText)
        
        stackView.addArrangedSubview(deleteButton)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.height.equalTo(278)
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
        deleteButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(nameText).dividedBy(2)
        }
    }
    // MARK: - Actions
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if profileName != "" {
            if textField.text == profileName {
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
        guard let profileNamee = nameText.text else { return }
        guard let profileImage = imageView.image, let data = profileImage.jpegData(compressionQuality: 0.1) else { return }
        Task {
                var downloadURL = ""
                let imageName = documentId.isEmpty ? UUID().uuidString : documentId
                let ref = storage.reference().child("Profiles/\(userId)/\(imageName).jpg")

                do {
                    try await ref.putDataAsync(data, metadata: nil)
                    downloadURL = try await ref.downloadURL().absoluteString
                    
                    let profileRef = db.collection("Users").document(userId).collection("Profiles").document(imageName)

                    if documentId.isEmpty {
                        try await profileRef.setData([
                            "profileName": profileNamee,
                            "profileImageURL": downloadURL,
                            "isEnabled": false
                        ])
                    } else {
                        try await profileRef.updateData([
                            "profileName": profileNamee,
                            "profileImageURL": downloadURL
                        ])
                    }

                    delegate?.didUpdateProfile()
                    dismiss(animated: true)
                } catch {
                    print(error.localizedDescription)
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
    
    @objc func deleteButton(_ sender: UIButton){
        let alert = UIAlertController(title: "Should the profile named \(profileName) be deleted?", message: "All recommendations, watch history, My List, settings and much more will be permanently deleted.", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Cancel", style: .cancel)
        let action2 = UIAlertAction(title: "Delete", style: .default) { [self] action in
            Task{
                try await db.collection("Users").document(userId).collection("Profiles").document(documentId).delete()
                delegate?.didUpdateProfile()
                dismiss(animated: true)
            }
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
}

