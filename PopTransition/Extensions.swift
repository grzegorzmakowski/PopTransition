//
//  Extensions.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 05/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

extension UIView {
    static var blurView: UIView {
        if UIAccessibility.isReduceTransparencyEnabled {
            let view = UIView()
            view.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha: 0.65)
            return view
        } else {
            return UIVisualEffectView(effect: UIBlurEffect(style: .light))
        }
    }
}


extension UIView {
    func activate(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach { $0.isActive = true }
    }
    
    func constraintAllEdges(to view: UIView, with insets: UIEdgeInsets) {
        activate(
            [
                topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
                leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
                rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
            ]
        )
    }
}


extension NSLayoutConstraint {
    func with(priority value: UILayoutPriority) -> NSLayoutConstraint {
        priority = value
        return self
    }
}

