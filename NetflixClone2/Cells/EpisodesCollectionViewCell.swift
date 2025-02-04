//
//  EpisodesCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 3.02.2025.
//

import UIKit
import SnapKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    let imageVieww : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
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
        stackview.spacing = 4
        stackview.alignment = .fill
        stackview.distribution = .fill
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
        stackview.alignment = .fill
        stackview.distribution = .fill
        return stackview
    }()
    
    let stackView3: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 2
        stackview.alignment = .fill
        stackview.distribution = .fill
        return stackview
    }()
    
    let overview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = .max
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
            make.height.equalTo(196)
        }
        stackView.snp.makeConstraints { make in
            make.height.equalTo(97)
        }
        stackView2.snp.makeConstraints { make in
            make.height.equalTo(97)
        }
        imageVieww.snp.makeConstraints { make in
            make.width.equalTo(172.5)
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
        episodeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(stackView).multipliedBy(0.75)
        }
        runtimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(stackView).multipliedBy(1.25)
        }
        overview.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
}
