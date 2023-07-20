//
//  CalculatorViewModel.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit
import Combine

class CalculatorViewModel {
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updatePublisherView: AnyPublisher<Result, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        let updateViewPulisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                
                let result = Result(amountPerPerson: amountPerPerson,
                                    totalBill: totalBill,
                                    totalTip: totalTip)
                
                return Just(result)
            }.eraseToAnyPublisher()
        
        
        
        return Output(updatePublisherView: updateViewPulisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(value: let value):
            return Double(value) 
        }
    }
}
