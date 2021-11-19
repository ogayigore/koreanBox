//
//  ProductDetailsView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 02.11.2021.
//

import UIKit

class ProductDetailsView: UIView {
    
    //MARK:- Private Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.backgroundStyle = .prominent
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var numberValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var descriptionValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var compositionLabel: UILabel = {
        let label = UILabel()
        label.text = "Состав:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var compositionValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bruttoLabel: UILabel = {
        let label = UILabel()
        label.text = "Брутто:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var bruttoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nettoLabel: UILabel = {
        let label = UILabel()
        label.text = "Нетто:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var nettoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK:- Initializers
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private Methods
    
    private func setup() {
        
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        addSubview(UIView(frame: .zero))
        addSubview(scrollView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(numberLabel)
        scrollView.addSubview(numberValueLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(descriptionValueLabel)
        scrollView.addSubview(compositionLabel)
        scrollView.addSubview(compositionValueLabel)
        scrollView.addSubview(bruttoLabel)
        scrollView.addSubview(bruttoValueLabel)
        scrollView.addSubview(nettoLabel)
        scrollView.addSubview(nettoValueLabel)
        scrollView.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8),
            nameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            numberLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            numberValueLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            numberValueLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 5),
            descriptionLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: numberLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            descriptionValueLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            descriptionValueLabel.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor),
            descriptionValueLabel.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor),
            descriptionValueLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            compositionLabel.topAnchor.constraint(equalTo: descriptionValueLabel.bottomAnchor, constant: 8),
            compositionLabel.leftAnchor.constraint(equalTo: descriptionValueLabel.leftAnchor),
            compositionLabel.rightAnchor.constraint(equalTo: descriptionValueLabel.rightAnchor),
            compositionValueLabel.topAnchor.constraint(equalTo: compositionLabel.bottomAnchor, constant: 2),
            compositionValueLabel.leftAnchor.constraint(equalTo: compositionLabel.leftAnchor),
            compositionValueLabel.rightAnchor.constraint(equalTo: compositionLabel.rightAnchor),
            compositionValueLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            bruttoLabel.topAnchor.constraint(equalTo: compositionValueLabel.bottomAnchor, constant: 8),
            bruttoLabel.leftAnchor.constraint(equalTo: compositionValueLabel.leftAnchor),
            bruttoValueLabel.centerYAnchor.constraint(equalTo: bruttoLabel.centerYAnchor),
            bruttoValueLabel.leftAnchor.constraint(equalTo: bruttoLabel.rightAnchor, constant: 5),
            nettoLabel.topAnchor.constraint(equalTo: bruttoLabel.bottomAnchor, constant: 8),
            nettoLabel.leftAnchor.constraint(equalTo: bruttoLabel.leftAnchor),
            nettoLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            nettoValueLabel.centerYAnchor.constraint(equalTo: nettoLabel.centerYAnchor),
            nettoValueLabel.leftAnchor.constraint(equalTo: nettoLabel.rightAnchor, constant: 5)
        ])
    }
}
