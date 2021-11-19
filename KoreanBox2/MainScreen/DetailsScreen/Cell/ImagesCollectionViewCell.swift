//
//  ImagesCollectionViewCell.swift
//  KoreanBox
//
//  Created by Igor Ogai on 03.11.2021.
//

import UIKit
import SDWebImage

class ImagesCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Public Properties
    
    static let reuseIdentifier = "imageCollectionViewCell"
    var product: Product!
    var photo: Photo! {
        didSet {
            if let url = URL(string: self.photo.photoURL) {
                self.imageView.sd_imageTransition = .fade
                self.imageView.sd_imageTransition?.duration = 0.2
                self.imageView.sd_setImage(with: url)
            } else {
                print("URL didn't work \(self.photo.photoURL)!")
                self.photo.loadImage(product: self.product) { success in
                    self.photo.saveData(product: self.product) { success in
                        print("Image updated with URL \(self.photo.photoURL)")
                    }
                }
            }
        }
    }
    
    //MARK:-  Private Properties
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK:- Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private Methods
    
    private func setup() {
        backgroundColor = .white
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
