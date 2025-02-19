//
//  SearchCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 15.02.2025.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {

    //MARK: UI Elements
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    let imageView : UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.layer.cornerRadius = 8
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup Methods
    func setupViews(){
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        
        stackView.addArrangedSubview(label)
        
        stackView.addArrangedSubview(button)
    }
    
    func setupConstraints(){
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.width.equalTo(132)
        }
        label.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.width.equalTo(75)
        }
    }
    

}
