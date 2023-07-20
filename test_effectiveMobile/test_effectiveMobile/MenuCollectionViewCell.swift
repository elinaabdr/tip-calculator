//
//  MenuCollectionViewCell.swift
//  test_effectiveMobile
//
//  Created by Элина Абдрахманова on 08.07.2023.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let idCell = "menuCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "example")
        iv.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews() 
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
