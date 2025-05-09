//
//  CarouselView.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 5.02.2025.
//

import UIKit
import SnapKit

// MARK: - Protocols
protocol CarouselViewDelegate : AnyObject {
    func didSelectMovie(_ upcoming: Movie)
}
protocol MakeAlert2: AnyObject {
    func makeAlert2()
}

class CarouselView: UIView, UICollectionViewDelegate, MakeAlert {

    
    func makeAlert() {
        delegate2?.makeAlert2()
    }
    
    // MARK: - Properties
    weak var delegate2: MakeAlert2?
    weak var delegate: CarouselViewDelegate?
    private var upcomingData : [Movie] = []
    private var upcomingDetail: [Detail] = []
    private var currentPage = 0
    private var genres: [Genre] = []
    var documentId: String = ""
    var userId: String = ""
    
    // MARK: - UI Elements
    private lazy var upComingMovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        return pageControl
    }()
    
    // MARK: - Initializers
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupViews()
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        addSubview(upComingMovieCollectionView)
        addSubview(pageControl)
        upComingMovieCollectionView.register(UpComingMovieCollectionViewCell.self, forCellWithReuseIdentifier: "UpComingMovieCollectionViewCell")
        
        upComingMovieCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Scroll View Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
    
    // MARK: - Reload Data
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return}
            self.upComingMovieCollectionView.reloadData()
        }
    }
    
    // MARK: - Actions
    @objc func pageControlTapped(_ sender: UIPageControl){
        let pageIndex = IndexPath(item: sender.currentPage, section: 0)
        upComingMovieCollectionView.scrollToItem(at: pageIndex, at: .centeredHorizontally, animated: true)
    }
    
    
}

// MARK: - UICollectionViewDataSource
extension CarouselView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingMovieCollectionViewCell", for: indexPath) as! UpComingMovieCollectionViewCell
        
        let url = upcomingData[indexPath.row].posterURL
        cell.movie = upcomingData[indexPath.row]
        cell.detail = upcomingDetail[indexPath.row]
        var genreName: [String] = []
        if let data = upcomingData[indexPath.row].genreIds {
            for genreId in data {
                for genre in self.genres {
                    if genre.id == genreId {
                        genreName.append(genre.name ?? "")
                    }
                }
            }
        }
        cell.userId = userId
        cell.documentId = documentId
        cell.genreLabel.text = genreName.joined(separator: " • ")
        cell.configure(url: url)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let upcomingMovie = upcomingData[indexPath.row]
        delegate?.didSelectMovie(upcomingMovie)
    }
    
    // Hücre boyutunu CollectionView'ın boyutuna göre ayarla
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - Update Method
extension CarouselView {
    public func configureView(with data: [Movie], data2: [Genre], data3: [Detail]) {
        self.upcomingData = data
        self.genres = data2
        self.upcomingDetail = data3
        self.pageControl.numberOfPages = data.count
        upComingMovieCollectionView.reloadData()
    }
}
