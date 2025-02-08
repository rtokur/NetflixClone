//
//  FavoriteVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import UIKit
import SnapKit
import Kingfisher
class FavoriteVC: UIViewController {
    // MARK: - Properties
    var count: Int = 0
    
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
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

        navigationItem.titleView = navLabel
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonAction))
        editButton.tintColor = .label
        navigationItem.rightBarButtonItem = editButton
        navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
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

    override func viewWillAppear(_ animated: Bool) {
        FavoriteCollectionView.reloadData()
    }
    // MARK: - Edit Button Action method
    @objc func editButtonAction(_ sender: UIButton) {
        count += 1
        FavoriteCollectionView.reloadData()
    }
}
// MARK: - UICollectionView Delegate & DataSource
extension FavoriteVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        return cell
    }
    
}
