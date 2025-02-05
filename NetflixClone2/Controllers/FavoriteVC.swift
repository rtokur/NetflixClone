//
//  FavoriteVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import RealmSwift
import SnapKit
import Kingfisher
class FavoriteVC: UIViewController {
    // MARK: - Properties
    lazy var realm = try! Realm()

    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let collectionView: UICollectionView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(label)
        
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        stackView.addArrangedSubview(collectionView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    // MARK: - Realm Database Methods
    func delete() {
        realm.beginWrite()
        realm.delete(realm.objects(RealmMovie.self))
        try! realm.commitWrite()
    }
}
// MARK: - UICollectionView Delegate & DataSource
extension FavoriteVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let movies = realm.objects(RealmMovie.self)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        let movies = realm.objects(RealmMovie.self)
        cell.titleLabel.text = movies[indexPath.row].movieName
        if let posterPath = movies[indexPath.row].moviePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
}
