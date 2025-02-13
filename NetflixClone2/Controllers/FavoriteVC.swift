//
//  FavoriteVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import SnapKit
import Kingfisher
import FirebaseFirestore

class FavoriteVC: UIViewController,UpdateCollectionView {
    // MARK: Methods
    func update() {
        getFavorites()
    }
    
    // MARK: - Properties
    var count: Int = 0
    var userId: String = ""
    var documentId: String = ""
    let db = Firestore.firestore()
    var favorites: [Favorite] = []
    
    // MARK: - UI Elements
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let FavoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 368, height: 75)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Series and Movies"
        label.textAlignment = .left
        return label
    }()
    
    let navLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .label
        return label
    }()
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        setupViews()
        setupConstraints()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(BackButton))
        backButton.tintColor = .label
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = navLabel
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonAction))
        editButton.tintColor = .label
        navigationItem.rightBarButtonItem = editButton
        navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Get Favorites from Firebase
    func getFavorites(){
        if userId != "" {
            if documentId != "" {
                favorites.removeAll()
                Task{
                    let favoritess = try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").getDocuments()
                    
                    let count = favoritess.documents.count
                    
                    guard count != 0 else { return }
                    
                    for favorite in favoritess.documents {
                        if let name = favorite.data()["movieName"] as? String, let movieImage = favorite.data()["movieImageURL"] as? String, let movieId = favorite.data()["movieId"] as? Int {
                            let favoritee = Favorite(id: movieId, URL: movieImage, name: name)
                            favorites.append(favoritee)
                            
                        } else if let name = favorite.data()["serieName"] as? String, let serieImage = favorite.data()["serieImageURL"] as? String, let serieId = favorite.data()["serieId"] as? Int {
                            let favoritee = Favorite(id: serieId, URL: serieImage, name: name)
                            favorites.append(favoritee)
                        }
                    }
                    FavoriteCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(label)
        
        FavoriteCollectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        FavoriteCollectionView.delegate = self
        FavoriteCollectionView.dataSource = self
        stackView.addArrangedSubview(FavoriteCollectionView)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        FavoriteCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc func editButtonAction(_ sender: UIButton) {
        count += 1
        if count % 2 == 1 {
            navigationItem.rightBarButtonItem?.title = "Okey"
        } else {
            navigationItem.rightBarButtonItem?.title = "Edit"
        }
        FavoriteCollectionView.reloadData()
    }
    
    @objc func BackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension FavoriteVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        let fav = favorites[indexPath.row]
        if let url = fav.URL {
            cell.imageView.kf.setImage(with: URL(string: url))
        }
        cell.count = count
        if count % 2 == 1 {
            cell.playButton.setImage(UIImage(systemName: "trash"), for: .normal)
            cell.playButton.tintColor = .red
        } else {
            cell.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            cell.playButton.tintColor = .label
        }
        cell.movieId = fav.id!
        cell.documentId = documentId
        cell.userId = userId
        cell.titleLabel.text = fav.name
        cell.delegate = self
        return cell
    }
    
}
