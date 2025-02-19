//
//  FavoriteCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 6.02.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore

protocol UpdateCollectionView: AnyObject {
    func update()
}

class FavoriteCollectionViewCell: UICollectionViewCell{
    
    
    // MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .white
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
    
    var playButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return button
    }()
    
    // MARK: - Properties
    var delegate: UpdateCollectionView?
    var count: Int = 0
    let db = Firestore.firestore()
    var userId: String = ""
    var documentId: String = ""
    var movieId: Int = 0
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
    }
    // MARK: - Button Action
    @objc func playButtonAction(_ sender: UIButton) {
        if playButton.tintColor == .red {
            if userId != "" {
                if documentId != "" {
                    if movieId != 0 {
                        print("movie siliniyor")
                        Task {
                            try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(movieId)").delete()
                            delegate?.update()
                        }
                    }
                }
            }
        }
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
    // MARK: - Setup Constraints
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
