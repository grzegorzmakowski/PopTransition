//
//  PopPresentationController.swift
//  PopTransition
//
//  Created by X349471 on 16/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import Foundation
import UIKit

final internal class PopPresentationController: UIPresentationController {
    
    private lazy var overlay: UIView = {
        let overlay = UIView(frame: .zero)
        overlay.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha: 0.2)
        return overlay
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
    
//    override func containerViewWillLayoutSubviews() {
//
//        guard let presentedView = presentedView else { return }
//
//        //        presentedView.frame = frameOfPresentedViewInContainerView
//        overlay.blurView.refresh()
//    }
    
}

