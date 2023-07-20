//
//  Label + Extension.swift
//  test_effectiveMobile
//
//  Created by Элина Абдрахманова on 08.07.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, color: UIColor) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }
}
