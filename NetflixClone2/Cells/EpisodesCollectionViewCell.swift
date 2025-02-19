//
//  EpisodesCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 3.02.2025.
//

import UIKit
import SnapKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Elements
    let imageVieww : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let runtimeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    let episodeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        return stackview
    }()
    
    let view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let playButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black.withAlphaComponent(0.8)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    let stackView2: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        return stackview
    }()
    
    let stackView3: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        return stackview
    }()
    
    let overview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    // MARK: - Initializer
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup Views
    func setupViews() {
        contentView.addSubview(stackView3)
        
        stackView3.addArrangedSubview(stackView)
        
        stackView.addArrangedSubview(imageVieww)
        
        contentView.addSubview(view)
        
        view.addSubview(playButton)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(episodeLabel)
        
        stackView2.addArrangedSubview(runtimeLabel)
        
        stackView3.addArrangedSubview(overview)
    }
    // MARK: - Setup Constraints
    func setupConstraints() {
        stackView3.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.width.equalToSuperview()
        }
        imageVieww.snp.makeConstraints { make in
            make.width.equalTo(132)
            make.centerY.equalTo(stackView)
        }
        view.snp.makeConstraints { make in
            make.center.equalTo(imageVieww)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        playButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView2.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        episodeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().inset(5)
        }
        runtimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.leading.equalToSuperview().inset(5)
        }
        overview.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
}
