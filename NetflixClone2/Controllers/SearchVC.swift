//
//  SearchVC.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 8.02.2025.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate {

    
    //MARK: Properties
    var count : Int = 0
    let connection = Connection()
    var searchMovie: [Movie] = []
    var searchSerie: [Serie] = []
    var search: [Any] = []
    var userId: String = ""
    var documentId: String = ""
    
    //MARK: UI Elements
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
    
    
    let stackView2: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        return stackview
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(BackButton), for: .touchUpInside)
        return button
    }()
    
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search movie or serie"
        bar.searchTextField.addTarget(self, action: #selector(searchBarTextDidBeginEditing), for: .editingChanged)
        bar.tintColor = .white
        return bar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 368, height: 75)
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.showsVerticalScrollIndicator = false
        return collectionview
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        return activity
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Setup Methods
    func setupViews(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(backButton)
        
        searchBar.delegate = self
        stackView2.addArrangedSubview(searchBar)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        stackView.addArrangedSubview(collectionView)
        
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        stackView2.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(25)
        }
        if count == 0 {
            backButton.isHidden = true
            backButton.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
        }
        searchBar.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(collectionView)
        }
    }
    
    //MARK: Actions
    @objc func BackButton(_ sender:UIButton){
        dismiss(animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let text = searchBar.text!
        if text.count >= 3 {
            activityIndicator.startAnimating()
            Task {
                searchMovie = try await connection.getSearchMovie(value: text)
                searchSerie = try await connection.getSearchSerie(value: text)
                search = searchMovie + searchSerie
                collectionView.reloadData()
                activityIndicator.stopAnimating()
            }
        }
        else {
            searchSerie = []
            searchMovie = []
            search = []
            collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Delegate & DataSource Methods
extension SearchVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return search.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        let searchh = search[indexPath.row]
        if let movie = searchh as? Movie {
            cell.imageView.kf.setImage(with: movie.posterBackURL)
            cell.label.text = movie.title
        }else if let serie = searchh as? Serie {
            cell.imageView.kf.setImage(with: serie.posterBackURL)
            cell.label.text = serie.name
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dvc = DetailVC()
        let searchh = search[indexPath.row]
        if let movie = searchh as? Movie {
            dvc.movie = movie
        }else if let serie = searchh as? Serie {
            dvc.serie = serie
        }
        dvc.userId = userId
        dvc.documentId = documentId
        dvc.modalPresentationStyle = .fullScreen
        dvc.isModalInPresentation = true
        present(dvc, animated: true)
    }
}
