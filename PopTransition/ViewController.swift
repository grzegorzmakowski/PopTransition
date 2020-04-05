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

    let popManager: SlideTransitionManager = SlideTransitionManager()

    @IBAction func showCustom(_ sender: Any) {
        let second = SecondViewController()
        second.transitioningDelegate = popManager
        second.modalPresentationStyle = .custom
        
        present(second, animated: true, completion: nil)
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return popManager.animationController(forPresented: presented, presenting: presenting, source: source)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return popManager.animationController(forDismissed: dismissed)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return popManager.presentationController(forPresented: presented, presenting: presenting, source: source)
    }
}

class SecondViewController: UIViewController {
    
    let button: UIButton = UIButton()
    
    let secondButton: UIButton = UIButton()
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.44
        view.layer.shadowRadius = 13.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: -6.0)

        button.addTarget(self, action: .dismissTapped, for: .touchUpInside)
        secondButton.addTarget(self, action: .dismissTapped, for: .touchUpInside)
        addFirst()
    }

    func addFirst() {
        view.addSubview(button)
        
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("dissmiss", for: .normal)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func addButton() {
        view.addSubview(secondButton)
        
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.backgroundColor = .blue
        secondButton.setTitle("duzy button", for: .normal)
        secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        secondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secondButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        secondButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        secondButton.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    
    @objc func dismissTapped(_ sender: UIButton) {
        if sender == secondButton {
            secondButton.removeFromSuperview()
            addFirst()
        } else {
//            button.removeFromSuperview()
//            addButton()
            dismiss(animated: true, completion: nil)
        }
    }
}

