//
//  UIResponder + Extension.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 08.07.2023.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController 
    }
}
