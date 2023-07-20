//
//  ResultView.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit
import SnapKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total p/person", font: ThemeFonts.demiBold(ofSize: 18))
    }()
    
    private let perPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0",
                                             attributes: [.font : ThemeFonts.bold(ofSize: 48)])
        text.addAttributes([.font : ThemeFonts.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private let totalBillView: AmountView = {
        let view = AmountView(title: "Total bill", textAlignment: .left)
        return view
    }()
    
    private let totalTipView: AmountView = {
        let view = AmountView(title: "Total tip", textAlignment: .right)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            perPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(string: String(result.amountPerPerson.currencyFormatted),
                                             attributes: [.font : ThemeFonts.bold(ofSize: 48)])
        text.addAttributes([.font : ThemeFonts.bold(ofSize: 48)], range: NSMakeRange(0, 1 ))
        perPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
    private func setupViews() {
        backgroundColor = .white
        addShadow()
        self.layer.cornerRadius = 12
        
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}


