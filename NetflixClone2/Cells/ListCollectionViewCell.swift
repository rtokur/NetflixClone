//
//  ListCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 12.02.2025.
//

import UIKit
import SnapKit

class ListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var favorite: Favorite?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup Views
    func setupViews(){
        contentView.addSubview(imageView)
    }
    // MARK: - Setup Constraints
    func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
