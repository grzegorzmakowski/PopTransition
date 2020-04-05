//
//  SlideDismissInteractiveTransition.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 05/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let handleGestureInPopContainer = #selector(SlideDismissInteractiveTransition.handleGestureInPopContainer)
}

final class SlideDismissInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress: Bool = false
    private var shouldCompleteTransition = false
    private weak var presenting: UIViewController?
    
    init(presenting: UIViewController?, popContainer: UIView?) {
        super.init()
        self.presenting = presenting
        self.prepareGestureRecognizers(for: popContainer)
    }
    
    private func prepareGestureRecognizers(for popContainer: UIView?) {
        guard let view = popContainer else { return }
        let panDown = UIPanGestureRecognizer(target: self, action: .handleGestureInPopContainer)
        view.addGestureRecognizer(panDown)
    }
    
    @objc fileprivate func handleGestureInPopContainer(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else { return }
        let percentThreshold: CGFloat = 0.5

        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        let velocityY = sender.velocity(in: view).y
        let finishAnimationIfQuickVelocity = velocityY > (view.bounds.height)/2 && progress > 0.35

        switch sender.state {
        case .began:
            shouldCompleteTransition = false
            interactionInProgress = true
            presenting?.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > percentThreshold
            update(progress)
        case .cancelled:
            interactionInProgress = false
            shouldCompleteTransition = false
            cancel()
        case .ended:
            interactionInProgress = false
            shouldCompleteTransition = shouldCompleteTransition || finishAnimationIfQuickVelocity
            completionSpeed = finishAnimationIfQuickVelocity ? 0.4 : completionSpeed
            shouldCompleteTransition
                ? finish()
                : cancel()
            shouldCompleteTransition = false
        default:
            break
        }
    }
}
