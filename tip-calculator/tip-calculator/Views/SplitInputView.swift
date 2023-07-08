//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+", corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
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
    
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        observe()
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
    
    private func observe() {
        splitSubject.sink { [unowned self] quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellables)
    }
}
