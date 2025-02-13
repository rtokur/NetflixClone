//
//  MyProfileVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 11.02.2025.
//

import UIKit
import Kingfisher
import SnapKit
import FirebaseFirestore

class MyProfileVC: UIViewController {
    
    //MARK: Properties
    let db = Firestore.firestore()
    var profileImage : String = ""
    var profileName: String = ""
    var userId: String = ""
    var documentId: String = ""
    var favorites: [Favorite] = []
    
    // MARK: - UI Elements
    
    let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        return stackview
    }()
    
    let stackView2 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameButton: UIButton = {
        let label = UIButton()
        label.titleLabel?.font = .boldSystemFont(ofSize: 25)
        label.setTitleColor(.label, for: .normal)
        label.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        label.tintColor = .label
        label.isEnabled = true
        label.addTarget(self, action: #selector(profileAction), for: .touchUpInside)
        return label
    }()
    
    let stackView3: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        return stackview
    }()
    
    let listLabel : UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    let listButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show All", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(FavoriteAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .label
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    let listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButton))
        searchButton.tintColor = .label
        let moreButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(moreButton))
        moreButton.tintColor = .label
        navigationItem.rightBarButtonItems = [moreButton,searchButton]
        let label = UIBarButtonItem(title: "My Netflix", style: .done, target: nil, action: nil)
        label.tintColor = .label
        navigationItem.leftBarButtonItem = label
        navigationController?.navigationBar.isTranslucent = true
        activityIndicator.startAnimating()
        setupViews()
        setupConstraints()
        getFavorites()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup Methods
    func setupViews(){
        view.addSubview(activityIndicator)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        imageView.kf.setImage(with: URL(string: profileImage))
        stackView2.addArrangedSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileAction(_:)))
        stackView2.addGestureRecognizer(tap)
        
        nameButton.setTitle(profileName, for: .normal)
        stackView2.addArrangedSubview(nameButton)
        
        stackView.addArrangedSubview(stackView3)
        
        stackView3.addArrangedSubview(listLabel)
        
        stackView3.addArrangedSubview(listButton)
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "ListCollectionViewCell")
        stackView.addArrangedSubview(listCollectionView)
    }
    
    func setupConstraints(){
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        stackView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        stackView2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(105)
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        nameButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        stackView3.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalToSuperview()
        }
        listLabel.snp.makeConstraints { make in
            make.width.equalTo(270)
            make.height.equalToSuperview()
        }
        listButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        listCollectionView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
    }
    
    // MARK: - Get Favorites from firebase
    func getFavorites(){
        Task{
            favorites.removeAll()
            let favorite = try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").getDocuments()
            let count = favorite.documents.count
            guard count != 0 else { return }
            for favorite in favorite.documents {
                if let id = favorite.data()["movieId"] as? Int, let URL = favorite.data()["movieImageURL"] as? String, let name = favorite.data()["movieName"] as? String {
                    let fav = Favorite(id: id, URL: URL, name: name)
                    favorites.append(fav)
                }
            }
            listCollectionView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Actions
    @objc func moreButton(_ sender: UIBarButtonItem) {
        let mvc = MoreVC()
        mvc.userId = userId
        mvc.documentId = documentId
        mvc.modalPresentationStyle = .formSheet
        mvc.sheetPresentationController?.detents = [.custom(resolver: { context in
            106
        })]
        present(mvc, animated: true)
    }
    
    @objc func FavoriteAction(_ sender: UIButton) {
        let fvc = FavoriteVC()
        fvc.userId = userId
        fvc.documentId = documentId
        let nvc = UINavigationController(rootViewController: fvc)
        nvc.isModalInPresentation = true
        nvc.modalPresentationStyle = .fullScreen
        present(nvc, animated: true)
    }
    
    @objc func ProfileAction(_ sender: UITapGestureRecognizer) {
        let pmvc = ProfileManagementVC()
        pmvc.userId = userId
        pmvc.documentId = documentId
        pmvc.modalPresentationStyle = .formSheet
        pmvc.sheetPresentationController?.detents = [.custom(resolver: { context in
            184
        })]
        present(pmvc, animated: true)
    }
    
    @objc func profileAction(_ sender: UIButton) {
        let pmvc = ProfileManagementVC()
        pmvc.userId = userId
        pmvc.documentId = documentId
        pmvc.modalPresentationStyle = .formSheet
        pmvc.sheetPresentationController?.detents = [.custom(resolver: { context in
            184
        })]
        present(pmvc, animated: true)
    }
    
    @objc func searchButton(_ sender: UIBarButtonItem) {
        let svc = SearchVC()
        svc.modalPresentationStyle = .fullScreen
        svc.isModalInPresentation = true
        svc.count = 1
        present(svc, animated: true)
    }
}

// MARK: - CollectionView Delegate & DataSource Methods
extension MyProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
        let fav = favorites[indexPath.row]
        if let url = fav.URL{
            cell.imageView.kf.setImage(with: URL(string: url))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fvc = FavoriteVC()
        fvc.userId = userId
        fvc.documentId = documentId
        let nvc = UINavigationController(rootViewController: fvc)
        nvc.isModalInPresentation = true
        nvc.modalPresentationStyle = .fullScreen
        present(nvc, animated: true)
    }
    
}
