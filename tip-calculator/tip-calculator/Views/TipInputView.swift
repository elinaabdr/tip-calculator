//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit

class TipInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "Your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        return buildTipButton(tip: .tenPercent)
    }()
    
    private lazy var fifteenPercentButton: UIButton = {
        return buildTipButton(tip: .fifteenPercent)
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        return buildTipButton(tip: .twentyPercent)
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentButton,
            fifteenPercentButton,
            twentyPercentButton
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var customButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Custom tip", for: .normal)
        btn.titleLabel?.font = ThemeFonts.bold(ofSize: 18)
        btn.backgroundColor = ThemeColor.primary
        btn.tintColor = .white
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customButton
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(buttonHStackView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
        }
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
       
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        let text = NSMutableAttributedString(string: tip.stringValue,
                                             attributes: [.font : ThemeFonts.bold(ofSize: 20)])
        text.addAttributes([.font: ThemeFonts.demiBold(ofSize: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}

