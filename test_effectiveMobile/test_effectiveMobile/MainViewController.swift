//
//  ViewController.swift
//  test_effectiveMobile
//
//  Created by Элина Абдрахманова on 08.07.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let navView = NavigationView()
    
    private let menuCollectionView = MenuCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(navView)
        view.addSubview(menuCollectionView)
        
    }
    
    private func setConstraints() {
        navView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(view.snp.topMargin).offset(-20)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(15)
            make.top.equalTo(navView.snp.bottomMargin).offset(30)
        }
    }
}


