//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "Your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap {
            Just(Tip.tenPercent).eraseToAnyPublisher()
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap {
            Just(Tip.fifteenPercent).eraseToAnyPublisher()
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap {
            Just(Tip.twentyPercent).eraseToAnyPublisher()
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
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
        btn.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
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
    
    private var tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
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
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                customButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(string:"$\(value)",
                                                     attributes: [.font : ThemeFonts.bold(ofSize: 20)])
                text.addAttributes([.font : ThemeFonts.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                customButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    
    private func resetView() {
        [tenPercentButton,fifteenPercentButton,twentyPercentButton, customButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        
        let text = NSMutableAttributedString(string: "Custom tip",
                                             attributes: [.font : ThemeFonts.bold(ofSize: 20)])
        customButton.setAttributedTitle(text, for: .normal)
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
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(title: "Enter custom tip",
                                               message: nil,
                                               preferredStyle: .alert)
            controller.addTextField { tf in
                tf.placeholder = "Make it generous"
                tf.keyboardType = .numberPad
                tf.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .cancel)
            let okAction = UIAlertAction(title: "OK",
                                         style: .default) { [weak self] _ in
                guard let text = controller.textFields?.first?.text,
                      let value = Int(text) else { return }
                self?.tipSubject.send(.custom(value: value))
            }
            [okAction, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        
        parentViewController?.present(alertController, animated: true)
    }
}

