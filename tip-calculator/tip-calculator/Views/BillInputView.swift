//
//  BillInputView.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Enter", bottomText: "your bill")
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(text: "$", font: ThemeFonts.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = ThemeFonts.demiBold(ofSize: 28)
        tf.keyboardType = .decimalPad
        tf.setContentHuggingPriority(.defaultLow, for: .horizontal)
        tf.tintColor = ThemeColor.text
        tf.textColor = ThemeColor.text
        //add ToolBar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle  = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        tf.inputAccessoryView = toolBar
        return tf
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
            make.height.equalTo(24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)
        
        currencyDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
    
    @objc private  func doneButtonTapped() {
        textField.endEditing(true)
    }
}

extension BillInputView {
    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            billSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellables)
    }
}
