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
    
    private lazy var overlay: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .light))
    }()
    
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

