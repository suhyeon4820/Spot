//
//  Extension+UIButton.swift
//  Spot
//
//  Created by suhyeon on 2021/02/10.
//

import UIKit

extension UIButton {
    
    func applyButtonStyle(color: UIColor, textColor: UIColor, state: UIControl.State) {
        self.backgroundColor = color
        self.setTitle("검색", for: state)
        self.setTitleColor(textColor, for: state)
        self.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.layer.cornerRadius = 5
    }
}
