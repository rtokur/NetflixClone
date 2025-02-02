//
//  PopularMovieCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import SnapKit

class PopularMovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let posterImageVieww : UIImageView = {
        let posterImageVieww = UIImageView()
        posterImageVieww.contentMode = .scaleAspectFill
        posterImageVieww.layer.cornerRadius = 8
        posterImageVieww.clipsToBounds = true
        return posterImageVieww
    }()
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(posterImageVieww)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        posterImageVieww.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.height)
        }
        
    }
}

