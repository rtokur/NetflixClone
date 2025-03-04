//
//  DetailVC.swift
//  Netflix Clone
//
//  Created by Rumeysa Tokur on 30.01.2025.
//

import UIKit
import SnapKit
import Kingfisher
import FirebaseFirestore
import FirebaseAuth

class DetailVC: UIViewController {
    // MARK: - Properties
    let connection = Connection()
    let db = Firestore.firestore()
    var userId: String = ""
    var documentId: String = ""
    
    // MARK: - UI Elements
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    let stackView2 : UIStackView = {
        let stackView2 = UIStackView()
        stackView2.axis = .horizontal
        stackView2.distribution = .fill
        stackView2.spacing = 1
        stackView2.alignment = .fill
        return stackView2
    }()
    
    let dateLabel : UILabel = {
        let dateLabel = UILabel()
        dateLabel.numberOfLines = 1
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textAlignment = .left
        return dateLabel
    }()
    
    let playButton2 : UIButton = {
        let playButton2 = UIButton()
        playButton2.backgroundColor = .white
        playButton2.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
        playButton2.tintColor = .systemBackground
        playButton2.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        playButton2.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        playButton2.setTitle("Play", for: .normal)
        playButton2.setTitleColor(.systemBackground, for: UIControl.State.normal)
        playButton2.layer.cornerRadius = 3
        return playButton2
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9, weight: .bold)
        button.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: -40)
        button.titleEdgeInsets = UIEdgeInsets(top: 38, left: -20, bottom: 0, right: 0)
        button.tintColor = .white
        return button
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let descriptionLabel : UILabel = {
        let descriptionLabel  = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        return descriptionLabel
    }()
    
    let genresLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    let runtimeLabel : UILabel = {
        let runtimeLabel = UILabel()
        runtimeLabel.numberOfLines = 1
        runtimeLabel.font = .systemFont(ofSize: 14)
        runtimeLabel.textAlignment = .left
        return runtimeLabel
    }()
    
    let seasonButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray3
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    let episodeLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let episodeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 360, height: 160)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
        
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let View: UIView = {
        let view = UIView()
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(BackButton), for: .touchUpInside)
        return button
    }()
    // MARK: - Empty Objects
    var movie : Movie?
    var serie : Serie?
    var detail : Detail?
    var genres : [Genre]? = []
    var episode : [Episode]? = []
    var menuChildren : [UIMenuElement] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        activityIndicator.startAnimating()
        setupViews()
        setupConstraints()
        getData()
        registerCells()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Update CollectionView size
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.episodeCollectionView.snp.updateConstraints { make in
            make.height.equalTo(episodeCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }
    
    // MARK: - Make call for movie or serie detail from API
    func getData(){
        if let movieId = movie?.id {
            Task {
                detail = try await connection.getMovieDetail(movieId: movieId)
                let runtime = detail?.runtime ?? 0
                let hours = runtime / 60
                let minutes = runtime / 60 % 60
                runtimeLabel.text = "\(hours) hours \(minutes) minutes"
                // ImageView's image setting
                if let posterPath = detail?.backdropPath {
                    if let url = detail?.posterURL {
                        self.imageView.kf.setImage(with: url)
                    }
                }
                if let genres2 = detail?.genres {
                    genres = genres2
                    var genresName : [String] = []
                    for i in 0..<(genres?.count ?? 0) {
                        genresName.append(genres?[i].name ?? "")
                    }
                    genresLabel.text = "\(genresName.joined(separator: " • "))"
                }
                seasonButton.backgroundColor = .clear
                activityIndicator.stopAnimating()
            }
        }
        else if let serieId = serie?.id {
            Task {
                detail = try await connection.getSerieDetail(serieId: serieId)
                episode = try await connection.getEpisodeDetail(serieId: serieId, seasonNumber: 1)
                
                if let numberOfSeasons = detail?.numberOfSeasons, numberOfSeasons != 1 {
                    runtimeLabel.text = "\(numberOfSeasons) Seasons"
                    if let posterPath = detail?.backdropPath  {
                        print(posterPath)
                        if let url = detail?.posterURL {
                            self.imageView.kf.setImage(with: url)
                        }
                    }
                    if let genres2 = detail?.genres {
                        genres = genres2
                        var genresName : [String] = []
                        for i in 0..<(genres?.count ?? 0) {
                            genresName.append(genres?[i].name ?? "")
                        }
                        genresLabel.text = "\(genresName.joined(separator: " • "))"
                    }
                    menuChildren.removeAll(keepingCapacity: true)
                    for season in 1..<(numberOfSeasons+1) {
                        menuChildren.append(UIAction(title: "\(season). Season", handler: { _ in
                            Task {
                                self.episode = try await self.connection.getEpisodeDetail(serieId: serieId, seasonNumber: season)
                                self.episodeCollectionView.reloadData()
                            }
                        }))
                    }
                    seasonButton.isHidden = false
                    seasonButton.menu = UIMenu(options: .displayInline, children: menuChildren)
                    seasonButton.menu?.displayPreferences = .none
                    episodeLabel.isHidden = true
                    episodeCollectionView.reloadData()
                    activityIndicator.stopAnimating()
                    
                } else if let numberOfEpisodes = detail?.numberOfEpisodes {
                    runtimeLabel.text = "\(numberOfEpisodes) Episodes"
                    if let posterPath = detail?.backdropPath  {
                        print(posterPath)
                        if let url = detail?.posterURL {
                            self.imageView.kf.setImage(with: url)
                        }
                    }
                    if let genres2 = detail?.genres {
                        genres = genres2
                        var genresName : [String] = []
                        for i in 0..<(genres?.count ?? 0) {
                            genresName.append(genres?[i].name ?? "")
                        }
                        genresLabel.text = "\(genresName.joined(separator: " • "))"
                    }
                    episodeLabel.text = "Episodes"
                    episodeCollectionView.reloadData()
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    //MARK: -Register Cell for loading
    private func registerCells() {
        episodeCollectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "EpisodesCollectionViewCell")
    }
    
    // MARK: - Setup Views
    func setupViews(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        view.addSubview(View)
        View.addSubview(backButton)
        // Title Label text setting
        if let title = movie?.title {
            titleLabel.text = title
        } else if let name = serie?.name {
            titleLabel.text = name
        }
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(genresLabel)
        
        stackView.addArrangedSubview(stackView2)
        
        //      Setting datelabel text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let releaseDate = movie?.releaseDate , let release = dateFormatter.date(from: releaseDate){
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: release)
            dateLabel.text = year
        }else if let firstAirDate = serie?.firstAirDate, let firstAir = dateFormatter.date(from: firstAirDate){
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: firstAir)
            dateLabel.text = year
        }
        stackView2.addArrangedSubview(dateLabel)
        
        stackView2.addArrangedSubview(runtimeLabel)
        
        stackView.addArrangedSubview(playButton2)
        
        if let overview = movie?.overview  {
            descriptionLabel.text = overview
        } else if let overview = serie?.overview {
            descriptionLabel.text = overview
        }
        stackView.addArrangedSubview(descriptionLabel)
        
        if userId != "" {
            Task{
                if documentId != "" {
                    if let movieId = movie?.id {
                        let movie = try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(movieId)").getDocument()
                        
                        let isExisted = movie.exists
                        
                        if isExisted {
                            favoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                        } else{
                            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
                        }
                    } else if let serieId = serie?.id {
                        let serie = try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(serieId)").getDocument()
                        
                        let isExisted = serie.exists
                        
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
        stackView.addArrangedSubview(favoriteButton)
        
        stackView.addArrangedSubview(episodeLabel)
        
        seasonButton.showsMenuAsPrimaryAction = true
        seasonButton.changesSelectionAsPrimaryAction = true
        seasonButton.isHidden = true
        stackView.addArrangedSubview(seasonButton)
        
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        stackView.addArrangedSubview(episodeCollectionView)
        
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Add to Favorites or Delete from Favorites
    @objc func favoriteButtonAction(_ sender: UIButton) {
        if favoriteButton.currentImage == UIImage(systemName: "plus") {
            if userId != "" {
                Task {
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("isEnabled", isEqualTo: true).getDocuments()
                    let count = profile.documents.count
                    guard count != 0 else { return }
                    if let documentId = profile.documents[0].documentID as? String {
                        if let movieId = movie?.id, let movieImage = movie?.posterURL, let movieBackImage = detail?.posterURL{
                            try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(movieId)").setData(["movieId":movieId, "movieName": movie?.title, "movieImageURL": "\(movieImage)", "movieBackImage": "\(movieBackImage)"])
                            favoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                        }else if let serieId = serie?.id, let serieImage = serie?.posterURL, let serieBackImage = detail?.posterURL {
                            try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(serieId)").setData(["serieId":serieId, "serieName": serie?.name, "serieImageURL": "\(serieImage)", "serieBackImage": "\(serieBackImage)"])
                            favoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                        }
                    }
                }
            }else{
                let alert = UIAlertController(title: "Error", message: "Please, login to add favorite", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
            }
            
        } else {
            if userId != "" {
                Task {
                    let profile = try await db.collection("Users").document(userId).collection("Profiles").whereField("isEnabled", isEqualTo: true).getDocuments()
                    let count = profile.documents.count
                    guard count != 0 else { return }
                    if let documentId = profile.documents[0].documentID as? String {
                        if let movieId = movie?.id {
                            try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(movieId)").delete()
                            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
                        }else if let serieId = serie?.id {
                            try await db.collection("Users").document(userId).collection("Profiles").document(documentId).collection("Favorites").document("\(serieId)").delete()
                            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
                        }
                    }
                }
            }
        }
    }
    // MARK: - Setup Constraints
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.leading.trailing.equalTo(scrollView.frameLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(230)
        }
        View.snp.makeConstraints { make in
            make.top.equalTo(imageView).inset(5)
            make.trailing.equalTo(imageView).inset(5)
            make.height.width.equalTo(25)
        }
        backButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        genresLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        stackView2.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        runtimeLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        playButton2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        favoriteButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(stackView).dividedBy(5.6)
        }
        episodeLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        seasonButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(stackView).dividedBy(3.4)
        }
        episodeCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    //MARK: Actions
    @objc func BackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - CollectionViewDelegate and DataSource Methods
extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episode?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCollectionViewCell", for: indexPath) as! EpisodesCollectionViewCell
        let episod = episode?[indexPath.row]
        
        if let url = episod?.stillURL {
            cell.imageVieww.kf.setImage(with: url)
            print(url)
        }
        
        let name = episod?.name
        let runtime = episod?.runtime
        let overview = episod?.overview
        
        cell.episodeLabel.text = "\(indexPath.row + 1). \(name ?? "")"
        cell.runtimeLabel.text = "\(runtime ?? 0) min."
        cell.overview.text = "\(overview ?? "")"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(episode?[indexPath.row].name,"bölüm")
    }
}
