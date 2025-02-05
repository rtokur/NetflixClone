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
        posterImageView2.backgroundColor = .purple
        posterImageView2.clipsToBounds = true
        return posterImageView2
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let view : UIView = {
        let view = UIView()
        return view
    }()
    
    let numberLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 90)
        return label
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
        contentView.addSubview(view)
        view.addSubview(posterImageView2)
        view.addSubview(numberLabel)
        
        
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        view.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.leading.equalToSuperview().inset(25)
        }
        posterImageView2.snp.makeConstraints { make in
            make.bottom.top.trailing.equalToSuperview()
            make.width.equalTo(105)
        }
    }
}
