//
//  PrimaryButton.swift
//  LearnDevice
//
//  Created by Fulgencio Comendeiro, Eduardo on 15/10/25.
//

import UIKit

class PrimaryButton: UIButton {
    
    init(title: String, backgroundColor: UIColor = .systemBlue) {
        super.init(frame: .zero)
        setup(title: title, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(title: nil, backgroundColor: .systemBlue)
    }
    
    private func setup(title: String?, backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

