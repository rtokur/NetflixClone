//
//  ViewController.swift
//  NetflixClone2
//


import UIKit
import SnapKit
import Kingfisher

class HomeVC: UIViewController, CarouselViewDelegate{
    // MARK: - Protocol from CarouselView
    func didSelectMovie(_ upcoming: Movie) {
        let dVC = DetailVC()
        dVC.movie = upcoming
        dVC.userId = userId
        dVC.documentId = documentId
        let nvc = UINavigationController(rootViewController: dVC)
        nvc.modalPresentationStyle = .fullScreen
        nvc.isModalInPresentation = true
        present(nvc, animated: true)
    }
    
    // MARK: - Properties
    let connection = Connection()
    private lazy var popularMovies: [Movie] = []
    private lazy var topRated: [Movie] = []
    lazy var upComing: [Movie] = []
    lazy var genres: [Genre] = []
    private lazy var popularSeries: [Serie] = []
    var userId: String = ""
    var upComingView = CarouselView()
    var documentId: String = ""
    var profileName: String = ""
    
    //MARK: UI Elements
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var popularMovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 105, height: 175)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var topRatedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 210, height: 175)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var popularSerieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 105, height: 175)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let popularTitleLabel : UILabel = {
        let popularTitleLabel = UILabel()
        popularTitleLabel.textColor = .label
        popularTitleLabel.numberOfLines = 1
        popularTitleLabel.textAlignment = .left
        popularTitleLabel.font = .boldSystemFont(ofSize: 17)
        popularTitleLabel.text = "Popular Movies"
        return popularTitleLabel
    }()
    
    private let activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let topRatedTitleLabel : UILabel = {
        let topRatedTitleLabel = UILabel()
        topRatedTitleLabel.textColor = .label
        topRatedTitleLabel.numberOfLines = 1
        topRatedTitleLabel.textAlignment = .left
        topRatedTitleLabel.font = .boldSystemFont(ofSize: 17)
        topRatedTitleLabel.text = "Top Rated Movies"
        return topRatedTitleLabel
    }()
    
    private let popularSerieTitleLabel : UILabel = {
        let popularSerieTitleLabel = UILabel()
        popularSerieTitleLabel.textColor = .label
        popularSerieTitleLabel.numberOfLines = 1
        popularSerieTitleLabel.textAlignment = .left
        popularSerieTitleLabel.font = .boldSystemFont(ofSize: 17)
        popularSerieTitleLabel.text = "Popular Series"
        return popularSerieTitleLabel
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if userId != "" {
            let label = UIBarButtonItem(title: "For \(profileName)", style: .done, target: nil, action: nil)
            label.tintColor = .label
            navigationItem.leftBarButtonItem = label
        }
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButton))
        searchButton.tintColor = .label
        navigationItem.rightBarButtonItems = [searchButton]
        navigationController?.navigationBar.isTranslucent = true
        activityIndicator.startAnimating()
        setupViews()
        setupConstraints()
        getData()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upComingView.reloadData()
    }
    
    //MARK: -Register Cells for loading
    private func registerCells() {
        popularMovieCollectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: "PopularMovieCollectionViewCell")
        topRatedCollectionView.register(TopRatedMovieCollectionViewCell.self, forCellWithReuseIdentifier: "TopRatedMovieCollectionViewCell")
        popularSerieCollectionView.register(PopularSerieCollectionViewCell.self, forCellWithReuseIdentifier: "PopularSerieCollectionViewCell")
    }
    
    //MARK: -Make call for movies and series from API
    private func getData() {
        Task {
            popularMovies = try await connection.getPopularMovies()
            popularSeries = try await connection.getPopularSeries()
            upComing = try await connection.getUpComingMovies()
            topRated = try await connection.getTopRatedMovies()
            genres = try await connection.getGenresMovie()
            upComingView.configureView(with: upComing, data2: genres)
            popularMovieCollectionView.reloadData()
            popularSerieCollectionView.reloadData()
            topRatedCollectionView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Setup Views
    private func setupViews()  {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        upComingView.delegate = self
        upComingView.documentId = documentId
        upComingView.userId = userId
        stackView.addArrangedSubview(upComingView)
        
        stackView.addArrangedSubview(popularTitleLabel)
        
        //Delegate and data source operations
        popularMovieCollectionView.delegate = self
        popularMovieCollectionView.dataSource = self
        stackView.addArrangedSubview(popularMovieCollectionView)
        
        stackView.addArrangedSubview(topRatedTitleLabel)
        
        //Delegate and data source operations
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
        stackView.addArrangedSubview(topRatedCollectionView)
        
        stackView.addArrangedSubview(popularSerieTitleLabel)
        
        //Delegate and data source operations
        popularSerieCollectionView.delegate = self
        popularSerieCollectionView.dataSource = self
        stackView.addArrangedSubview(popularSerieCollectionView)
        
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        upComingView.snp.makeConstraints { make in
            make.height.equalTo(650)
        }
        popularTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
        popularMovieCollectionView.snp.makeConstraints { make in
            make.height.equalTo(175)
        }
        topRatedTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
        topRatedCollectionView.snp.makeConstraints { make in
            make.height.equalTo(175)
        }
        popularSerieTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
        popularSerieCollectionView.snp.makeConstraints { make in
            make.height.equalTo(175)
        }
        
    }
    
    //    MARK: Actions
    @objc func searchButton(_ sender: UIBarButtonItem) {
        let svc = SearchVC()
        svc.modalPresentationStyle = .fullScreen
        svc.isModalInPresentation = true
        svc.count = 1
        present(svc, animated: true)
    }
}


// MARK: - UICollectionView Delegate & DataSource
extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topRatedCollectionView {
            return topRated.count
        } else if collectionView == popularSerieCollectionView {
            return popularSeries.count
        }
        return popularMovies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topRatedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieCollectionViewCell", for: indexPath) as! TopRatedMovieCollectionViewCell
            let movie = topRated[indexPath.row]
            cell.numberLabel.text = "\(indexPath.row + 1)"
            if let url = movie.posterURL {
                cell.posterImageView2.kf.setImage(with: url)
            }
            return cell
        }else if collectionView == popularSerieCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularSerieCollectionViewCell", for: indexPath) as! PopularSerieCollectionViewCell
            let serie = popularSeries[indexPath.row]
            if let url = serie.posterURL {
                cell.posterImageVieww.kf.setImage(with: url)
                
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieCollectionViewCell", for: indexPath) as! PopularMovieCollectionViewCell
        let movie = popularMovies[indexPath.row]
        
        if let url = movie.posterURL {
            cell.posterImageVieww.kf.setImage(with: url)
        }
        return cell
    }
    
    // MARK: - DetailVC passes
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let dVC = DetailVC()
        if collectionView == popularSerieCollectionView {
            dVC.serie = popularSeries[indexPath.row]
            dVC.userId = userId
            dVC.documentId = documentId
            self.present(dVC, animated: true, completion: nil)
        }else{
            if collectionView == topRatedCollectionView {
                dVC.movie = topRated[indexPath.row]
                dVC.userId = userId
                dVC.documentId = documentId
            }
            else {
                dVC.movie = popularMovies[indexPath.row]
                dVC.userId = userId
                dVC.documentId = documentId
            }
            self.present(dVC, animated: true, completion: nil)
        }
    }
    
}


