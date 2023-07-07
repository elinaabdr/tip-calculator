//
//  LogoView.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit
import SnapKit

class LogoView: UIView {
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icCalculatorBW")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let topMrLabel = UILabel(text: "Mr",
                                     font: ThemeFonts.demiBold(ofSize: 16),
                                     color: ThemeColor.text)
    
    private let topTIPLabel = UILabel(text: "TIP",
                                      font: ThemeFonts.bold(ofSize: 24),
                                      color: ThemeColor.text)
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: "Calculator",
                           font: ThemeFonts.demiBold(ofSize: 20),
                           textAlignment: .left)
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topMrLabel,
            topTIPLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return  stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topStackView,
            bottomLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = -4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return  stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoImageView,
            vStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return  stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(logoImageView.snp.width)
        }
    }
}
