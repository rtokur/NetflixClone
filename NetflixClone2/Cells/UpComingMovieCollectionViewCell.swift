//
//  UpComingMovieCollectionViewCell.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import SnapKit
import Kingfisher
import FirebaseFirestore
protocol MakeAlert: AnyObject {
    func makeAlert()
}
class UpComingMovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    weak var delegate: MakeAlert?
    var movie: Movie?
    var userId: String = ""
    var documentId: String = ""
    let db = Firestore.firestore()
    
    // MARK: - UI Elements
    let view : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let gradiantLayer: CAGradientLayer = {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradiantLayer.locations = [0.0, 0.3]
        gradiantLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradiantLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradiantLayer
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let playButton : UIButton = {
        let playButton = UIButton()
        playButton.backgroundColor = .white
        playButton.setImage(UIImage(systemName: "play.fill"),for: UIControl.State.normal)
        playButton.setTitle("Play", for: UIControl.State.normal)
        playButton.tintColor = .black
        playButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        playButton.setTitleColor(.black, for: UIControl.State.normal)
        playButton.layer.cornerRadius = 3
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        playButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        playButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return playButton
    }()
    
    let favoriteButton : UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.backgroundColor = .darkGray
        favoriteButton.setTitle("My List", for: UIControl.State.normal)
        favoriteButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        favoriteButton.tintColor = .white
        favoriteButton.layer.cornerRadius = 3
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        favoriteButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return favoriteButton
    }()
    
    let stackView3 : UIStackView = {
        let stackView3 = UIStackView()
        stackView3.axis = .horizontal
        stackView3.spacing = 13
        stackView3.alignment = .fill
        stackView3.distribution = .fillEqually
        return stackView3
    }()
    
    var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    let stackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 5
        return stackview
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradiantLayer.frame = view.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(imageView)
        
        contentView.addSubview(view)
        
        view.layer.insertSublayer(gradiantLayer, at: 0)
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(genreLabel)
        
        stackView.addArrangedSubview(stackView3)
        
        // MARK: - Play Button
        stackView3.addArrangedSubview(playButton)
        
        
        stackView3.addArrangedSubview(favoriteButton)
    }
    
    
    // MARK: - Favorite Button Action method
    @objc func favoriteButtonAction(_ sender: UIButton!) {
        if userId != "" {
            if favoriteButton.currentImage == UIImage(systemName: "plus") {
                Task{
                    if userId != "" {
                        if documentId != "" {
                            if let movieId = movie?.id, let movieImage = movie?.posterURL {
                                try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(movieId)").setData(["movieId":movie?.id,"movieName":movie?.title,"movieImageURL":"\(movieImage)"])
                                favoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                            }
                            
                        }
                    }
                }
            } else if favoriteButton.currentImage == UIImage(systemName: "checkmark"){
                Task{
                    if userId != "" {
                        if documentId != "" {
                            if let movieId = movie?.id {
                                try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(movieId)").delete()
                                favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
                            }
                        }
                        
                    }
                }
                
            }
        } else {
            delegate?.makeAlert()
        }
    }
    // MARK: - Play Button Action method
    @objc func playButtonAction(sender: UIButton!) {
        print("playbuttontapped")
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.centerX.equalTo(imageView.snp.centerX)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(13)
        }
        genreLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().inset(17)
        }
        stackView3.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalToSuperview()
        }
        playButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        favoriteButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
    }
    
    // MARK: - Configure ImageView
    func configure(url: URL?) {
        imageView.kf.setImage(with: url)
        // MARK: - Favorite Button
        if userId != "" {
            if documentId != "" {
                if let movieId = movie?.id {
                    Task{
                        let movie = try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(movieId)").getDocument()
                        
                        let isExisted = movie.exists
                        
                        if isExisted {
                            favoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                        } else{
                            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
                        }
                    }
                }
            }
        } else {
            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
        }
    }
}


