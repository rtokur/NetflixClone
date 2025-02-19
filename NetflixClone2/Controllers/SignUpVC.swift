//
//  SignUpVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 8.02.2025.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {
    
    // MARK: - Properties
    let db = Firestore.firestore()
    
    // MARK: - UI Elements
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        return stackview
    }()
    
    let labelBig: UILabel = {
        let label = UILabel()
        label.text = "Create a password to start your membership"
        label.font = .systemFont(ofSize: 38)
        label.tintColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    let emailText: UITextField = {
        let text = UITextField()
        text.placeholder = "E-post"
        text.textColor = .white
        text.textContentType = .emailAddress
        text.backgroundColor = .systemGray5
        text.layer.cornerRadius = 6
        let paddingView = UIView(frame: CGRectMake(0, 0, 20, text.frame.height))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.autocapitalizationType = .none
        return text
    }()
    
    let passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "Add a password"
        text.textColor = .white
        text.textContentType = .newPassword
        text.backgroundColor = .systemGray5
        text.layer.cornerRadius = 6
        let paddingView = UIView(frame: CGRectMake(0, 0, 20, text.frame.height))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.autocapitalizationType = .none
        return text
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(SignUpButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Setup Functions
    func setupViews(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(labelBig)
        
        stackView.addArrangedSubview(emailText)
        
        stackView.addArrangedSubview(passwordText)
        
        stackView.addArrangedSubview(signUpButton)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(340)
            make.width.equalToSuperview().inset(40)
        }
        labelBig.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        emailText.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        passwordText.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Actions
    @objc func SignUpButton(_ sender: UIButton){
        if emailText.text != "", let email = emailText.text {
            if passwordText.text != "", let password = passwordText.text {
                Task{
                    try await Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error as? NSError {
                            switch AuthErrorCode(rawValue: error.code) {
                            case .operationNotAllowed:
                                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                self.present(alert, animated: true)
                            case .emailAlreadyInUse:
                                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                self.present(alert, animated: true)
                            case .invalidEmail:
                                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                self.present(alert, animated: true)
                            case .weakPassword:
                                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                self.present(alert, animated: true)
                            default:
                                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                self.present(alert, animated: true)
                            }
                        }else {
                            Task{
                                print(authResult?.user.uid)
                                try await self.db.collection("Users").document(authResult?.user.uid ?? "").setData(["email": email])
                                print("User signed up")
                                let pvc = ProfileVC()
                                pvc.modalPresentationStyle = .fullScreen
                                pvc.isModalInPresentation = true
                                self.present(pvc, animated: true)
                            }
                        }
                    }
                }
            }else {
                let alert = UIAlertController(title: "Error", message: "Please enter a password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
            }
        }else {
            let alert = UIAlertController(title: "Error", message: "Please enter a email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
        
    }
}
