//
//  ProfileVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 8.02.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore

class ProfileVC: UIViewController {
    let db = Firestore.firestore()
    var documentId: String = ""
    
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
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor .lightGray.cgColor
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(EditProfileButton), for: .touchUpInside)
        return button
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
    
    let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor .lightGray.cgColor
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(EditProfileButton), for: .touchUpInside)
        return button
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
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
    
    let button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor .lightGray.cgColor
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(EditProfileButton), for: .touchUpInside)
        return button
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let stackView7: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let button4: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor .lightGray.cgColor
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(EditProfileButton), for: .touchUpInside)
        return button
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.text = "Add Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    // MARK: - Firebase Methods
    func getProfileData(){
//        let ref = db.collection("Users").document(documentId).collection("Profiles").getDocuments()
    }
    
    // MARK: - Setup Methods
    func setupViews(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(stackView4)
        
        stackView4.addArrangedSubview(button)
        
        stackView4.addArrangedSubview(label1)
        
        stackView2.addArrangedSubview(stackView5)
        
        stackView5.addArrangedSubview(button2)
        
        stackView5.addArrangedSubview(label2)
        
        stackView.addArrangedSubview(stackView3)
        
        stackView3.addArrangedSubview(stackView6)
        
        stackView6.addArrangedSubview(button3)
        
        stackView6.addArrangedSubview(label3)
        
        stackView3.addArrangedSubview(stackView7)
        
        stackView7.addArrangedSubview(button4)
        
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
        button.snp.makeConstraints { make in
            make.height.equalTo(110)
        }
        label1.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        stackView5.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalToSuperview()
        }
        button2.snp.makeConstraints { make in
            make.height.equalTo(110)
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
        button3.snp.makeConstraints { make in
            make.height.equalTo(110)
        }
        label3.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        stackView7.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalToSuperview()
        }
        button4.snp.makeConstraints { make in
            make.height.equalTo(110)
        }
        label4.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
    }
    // MARK: - Actions
    @objc func EditProfileButton(_ sender: UIButton) {
        let evc = EditProfileVC()
        evc.documentId = documentId
        present(evc, animated: true)
    }
}
