//
//  NavigationView.swift
//  test_effectiveMobile
//
//  Created by Элина Абдрахманова on 08.07.2023.
//

import UIKit
import SnapKit

class NavigationView: UIView {
    
    private let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Location")
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let cityLabel = UILabel(text: "Caнкт-Петербург",
                                    font: .systemFont(ofSize: 18),
                                    color: .black)
    
    private let dateLabel = UILabel(text: "12 Августа, 2023",
                                    font: .systemFont(ofSize: 14),
                                    color: ThemeColor.specialGray)
    
    private lazy var cityDateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cityLabel, dateLabel])
        sv.axis = .vertical
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "location")
        iv.layer.cornerRadius = 20
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cityDateStackView, profileImageView])
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [locationImageView, stackView].forEach(addSubview(_:))
    }
}

extension NavigationView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            locationImageView.heightAnchor.constraint(equalToConstant: 24),
            locationImageView.widthAnchor.constraint(equalToConstant: 21),
            locationImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 4),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 10),
            
            profileImageView.centerYAnchor.constraint(equalTo: cityDateStackView.centerYAnchor)
        ])
    }
}
