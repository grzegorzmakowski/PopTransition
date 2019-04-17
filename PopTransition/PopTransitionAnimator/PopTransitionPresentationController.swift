//
//  PopPresentationController.swift
//  PopTransition
//
//  Created by X349471 on 16/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import Foundation
import UIKit

final class PopTransitionPresentationController: UIPresentationController {
    
    private let overlay: UIView = UIView.blurView
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        overlay.frame = containerView.bounds
        containerView.insertSubview(overlay, at: 0)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
                self?.overlay.alpha = 1.0
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
                self?.overlay.alpha = 0.0
            }, completion: nil)
    }
}

extension UIView {
    
    static var blurView: UIView {
        if UIAccessibility.isReduceTransparencyEnabled {
            let view = UIView()
            view.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha: 0.5)
            return view
        } else {
            return UIVisualEffectView(effect: UIBlurEffect(style: .light))
        }
    }
}

