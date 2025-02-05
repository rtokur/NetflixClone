//
//  FavoriteCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 6.02.2025.
//

import UIKit
import SnapKit
class FavoriteCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return button
    }()
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
    }
    // MARK: - Button Action
    @objc func playButtonAction() {
        print("playbuttontapped")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup Methods
    func setupViews() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(playButton)
        
    }
    
    func setupConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(150)
            make.leading.top.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        playButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(75)
        }
    }
}
