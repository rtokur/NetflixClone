//
//  TopRatedMovieCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit

import SnapKit
class TopRatedMovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let posterImageView2 : UIImageView = {
        let posterImageView2 = UIImageView()
        posterImageView2.contentMode = .scaleAspectFill
        posterImageView2.layer.cornerRadius = 8
        posterImageView2.clipsToBounds = true
        return posterImageView2
    }()
    
    let voteLabel : UILabel = {
        let voteLabel = UILabel()
        voteLabel.textColor = .label
        voteLabel.font = .italicSystemFont(ofSize: 15)
        voteLabel.textAlignment = .center
        return voteLabel
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(voteLabel)
        
        contentView.addSubview(posterImageView2)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        posterImageView2.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.height)
        }
        voteLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView2.snp.bottom)
        }
        
    }
}
