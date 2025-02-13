//
//  IconVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 10.02.2025.
//

import UIKit
import SnapKit

// MARK: - ReloadImage Protocol
protocol ReLoadImage: AnyObject {
    func ReloadImage(image:UIImage)
}

class IconVC: UIViewController {
    // MARK: - Properties
    var delegate: ReLoadImage?
    
    // MARK: - UI Elements
    var iconList: [UIImage] = [UIImage(named: "profile-icon-1")!, UIImage(named: "profile-icon-2")!, UIImage(named: "profile-icon-3")!, UIImage(named: "profile-icon-4")!, UIImage(named: "profile-icon-5")!, UIImage(named: "profile-icon-6")!, UIImage(named: "profile-icon-7")!, UIImage(named: "profile-icon-8")!, UIImage(named: "profile-icon-9")!, UIImage(named: "profile-icon-10")!, UIImage(named: "profile-icon-11")!]
    
    let selectLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Icon"
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .label
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.isScrollEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        return stackview
    }()
    
    let classicLabel: UILabel = {
        let label = UILabel()
        label.text = "Classics"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .label
        return label
    }()
    
    let iconCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerCells()
        setupViews()
        setupConstraints()
        navigationItem.titleView = selectLabel
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(BackButton))
        backButton.tintColor = .label
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Setup Methods
    func registerCells(){
        iconCollectionView.register(IconCollectionViewCell.self, forCellWithReuseIdentifier: "IconCollectionViewCell")
    }
    
    func setupViews(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(classicLabel)
        
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
        stackView.addArrangedSubview(iconCollectionView)
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        classicLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
        }
        iconCollectionView.snp.makeConstraints { make in
            make.height.equalTo(500)
        }
    }
    // MARK: - Actions
    @objc func BackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension IconVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCollectionViewCell", for: indexPath) as! IconCollectionViewCell
        cell.imageView.image = iconList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = iconList[indexPath.row]
        delegate?.ReloadImage(image: image)
        dismiss(animated: true)
    }
    
}
