//
//  LoginVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 8.02.2025.
//

import UIKit
import FirebaseAuth
import SnapKit
import FirebaseFirestore

class LoginVC: UIViewController {
    // MARK: - UI Elements
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let emailText: UITextField = {
        let text = UITextField()
        text.placeholder = "E-post or phone number"
        text.tintColor = .label
        text.textContentType = .emailAddress
        text.backgroundColor = .systemGray5
        text.layer.cornerRadius = 6
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, text.frame.height))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.autocapitalizationType = .none
        return text
    }()
    
    let passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.textContentType = .password
        text.tintColor = .label
        text.backgroundColor = .systemGray5
        text.layer.cornerRadius = 6
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, text.frame.height))
        text.leftView = paddingView
        text.leftViewMode = .always
        text.autocapitalizationType = .none
        return text
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(SignInAction), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    let forgotPasswordButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("I've forgotten my password", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(ForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    let SignUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Click to create a Netflix account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor .systemPink.cgColor
        button.addTarget(self, action: #selector(SignUpButtonAction), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
        navigationItem.titleView?.largeContentImage = UIImage(named: "netflix")
        navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    // MARK: - Setup UI
    func setupViews(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(emailText)
        
        stackView.addArrangedSubview(passwordText)
        
        stackView.addArrangedSubview(signInButton)
        
        stackView.addArrangedSubview(forgotPasswordButton)
        
        stackView.addArrangedSubview(SignUpButton)
    }
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(275)
            make.width.equalToSuperview().inset(50)
        }
        emailText.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        passwordText.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        SignUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    // MARK: - Actions
    @objc func SignInAction(_ sender: UIButton) {
        if emailText.text != "", let email = emailText.text{
            if passwordText.text != "", let password = passwordText.text{
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error as? NSError {
                        switch AuthErrorCode(rawValue: error.code) {
                        case .operationNotAllowed:
                            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                            self.present(alert, animated: true)
                        case .userDisabled:
                            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                            self.present(alert, animated: true)
                        case .wrongPassword:
                            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                            self.present(alert, animated: true)
                        case .invalidEmail:
                            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                            self.present(alert, animated: true)
                        default:
                            let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                            self.present(alert, animated: true)
                        }
                    }else {
                        let pvc = ProfileVC()
                        let user = Auth.auth().currentUser
                        let email = user?.email
                        pvc.modalPresentationStyle = .fullScreen
                        pvc.isModalInPresentation = true
                        self.present(pvc, animated: true)
                    }
                    
                }
            }else {
                let alert = UIAlertController(title: "Error", message: "Please enter a password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
        }else {
            let alert = UIAlertController(title: "Error", message: "Please enter a email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    @objc func ForgotPasswordButton(_ sender: UIButton) {
        if emailText.text != "", let email = emailText.text {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error as? NSError {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self.present(alert, animated: true)
                    case .invalidEmail:
                        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self.present(alert, animated: true)
                    case .userDisabled:
                        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self.present(alert, animated: true)
                    default:
                        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self.present(alert, animated: true)
                    }
                }else {
                    let alert = UIAlertController(title: "Success", message: "Sended to your email", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "Please enter a email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    @objc func SignUpButtonAction(_ sender: UIButton) {
        let svc = SignUpVC()
        svc.modalPresentationStyle = .fullScreen
        svc.isModalInPresentation = true
        present(svc, animated: true)
    }
}
