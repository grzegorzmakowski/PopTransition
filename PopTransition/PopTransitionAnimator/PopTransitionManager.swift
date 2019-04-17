//
//  PopTransitionManager.swift
//  PopTransition
//
//  Created by X349471 on 17/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import UIKit

enum PopTransitionType {
    case zoom
}

final class PopTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    let transitionType: PopTransitionType
    
    init(transitionType: PopTransitionType) {
        self.transitionType = transitionType
        super.init()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch transitionType {
        case .zoom:
            return ZoomPopTransitionAnimator(direction: .show)
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch transitionType {
        case .zoom:
            return ZoomPopTransitionAnimator(direction: .hide)
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PopTransitionPresentationController(presentedViewController: presented, presenting: source)
        return presentationController
    }
}
