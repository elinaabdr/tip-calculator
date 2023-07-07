//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit

class SplitInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
    }()
    
    private lazy var incrementButton: UIButton = {
        buildButton(text: "+", corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
    }()
    
    private let quantityLabel: UILabel = {
        LabelFactory.build(text: "1", font: ThemeFonts.bold(ofSize: 20), backgroundColor: .white)
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
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
        [headerView, hStackView].forEach(addSubview(_:))
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(hStackView.snp.centerY)
            make.trailing.equalTo(hStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = ThemeFonts.bold(ofSize: 20)
        btn.titleLabel?.textColor = .white
        btn.backgroundColor = ThemeColor.primary
        btn.addRoundedCorners(corners: corners, radius: 8)
        return btn
    }
}
