//
//  PopAnimatorTransitioning.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 05/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

internal enum PopAnimationDirection {
    case show
    case hide
}

protocol PopAnimatorTransitioning: UIViewControllerAnimatedTransitioning {
    var to: UIViewController? { get set }
    var from: UIViewController? { get set }
    var popContainer: UIView { get set }
    var direction: PopAnimationDirection { get set }
    var transitionDuration: Double { get }
    func prepareTransition(using transitionContext: UIViewControllerContextTransitioning)
    func addPopContainer(to: UIViewController, transitionContext: UIViewControllerContextTransitioning)
}
