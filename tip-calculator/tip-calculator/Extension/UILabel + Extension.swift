//
//  UILabel + Extension.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 07.07.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, color: UIColor) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
