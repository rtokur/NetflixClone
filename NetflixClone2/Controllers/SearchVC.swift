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
        button.tintColor = .label
        button.addTarget(self, action: #selector(BackButton), for: .touchUpInside)
        return button
    }()
    
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search movie or serie"
        bar.tintColor = .label
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
        
        stackView.addArrangedSubview(collectionView)
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
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
    }
    
    //MARK: Actions
    @objc func BackButton(_ sender:UIButton){
        dismiss(animated: true)
    }
}
