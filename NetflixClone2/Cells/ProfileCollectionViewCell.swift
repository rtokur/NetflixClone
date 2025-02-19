//
//  ProfileCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 13.02.2025.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Elements
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup Methods
    func setupViews(){
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        
        stackView.addArrangedSubview(label)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(13)
        }
    }
}
