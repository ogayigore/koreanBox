//
//  AddPhotoView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 03.11.2021.
//

import UIKit

class AddPhotoView: UIView {
    
    //MARK:- Private Properties
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        backgroundColor = .white
        
        addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
