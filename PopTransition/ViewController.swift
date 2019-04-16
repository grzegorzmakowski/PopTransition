//
//  ViewController.swift
//  PopTransition
//
//  Created by X349471 on 16/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let dismissTapped = #selector(SecondViewController.dismissTapped)
}

class ViewController: UIViewController {
    
    let popTransition: PopTransitionAnimator = PopTransitionAnimator(direction: .show)
    let hideTransition: PopTransitionAnimator = PopTransitionAnimator(direction: .hide)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showCustom(_ sender: Any) {
        let second = SecondViewController()
        second.transitioningDelegate = self
        second.modalPresentationStyle = .custom
        
        present(second, animated: true, completion: nil)
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return popTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return hideTransition
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PopPresentationController(presentedViewController: presented, presenting: source)
        return presentationController
    }
}

class SecondViewController: UIViewController {
    
    let button: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("dissmiss", for: .normal)
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        button.addTarget(self, action: .dismissTapped, for: .touchUpInside)
    }
    
    
    @objc func dismissTapped() {
        dismiss(animated: true, completion: nil)
    }
}

