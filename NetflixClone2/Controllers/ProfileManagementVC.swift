//
//  ProfileManagementVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 12.02.2025.
//

import UIKit
import SnapKit
class ProfileManagementVC: UIViewController {
    // MARK: - UI Elements
    let label : UILabel = {
        let label = UILabel()
        label.text = "Change Profile"
        label.textColor = .label
        label.font = .systemFont(ofSize: 19)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup Methods
    func setupViews(){
        view.addSubview(label)
    }
    
    func setupConstraints(){
        label.snp.makeConstraints { make in
            make.height.equalTo(19)
        }
    }
}
