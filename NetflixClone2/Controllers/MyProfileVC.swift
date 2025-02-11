//
//  MyProfileVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 11.02.2025.
//

import UIKit

class MyProfileVC: UIViewController {
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "My Netflix"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        return stackview
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.text = "profilename"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = true
        setupViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }

    func setupViews(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileAction(_:)))
        nameLabel.addGestureRecognizer(tap)
        stackView.addArrangedSubview(nameLabel)
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        stackView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }

    @objc func ProfileAction(_ sender: UITapGestureRecognizer) {
        print("yazzzııı")
    }
}
