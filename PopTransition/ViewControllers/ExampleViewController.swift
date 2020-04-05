//
//  ExampleViewController.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 05/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let zoomTapped = #selector(ExampleViewController.zoomTapped)
    static let bounceBottomTapped = #selector(ExampleViewController.bounceBottomTapped)
    static let bounceTopTapped = #selector(ExampleViewController.bounceTopTapped)
    static let slideTapped = #selector(ExampleViewController.slideTapped)
}

class ExampleViewController: UIViewController {
    
    private let popZoomTransitionManager = PopDialogTransitionManager(transitionType: .zoom)
    private let bounceBottomTransitionManager = PopDialogTransitionManager(transitionType: .bounce(.down))
    private let bounceTopTransitionManager = PopDialogTransitionManager(transitionType: .bounce(.up))
    private let interactiveSlideTransitionManager = SlideTransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupLayout()
    }
    
    func setupLayout() {
        let imageView = Subviews.imageView
        view.addSubview(imageView)
        imageView.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        let stackButtonContainer: UIStackView = Subviews.stackButtonContainer
        view.addSubview(stackButtonContainer)
        stackButtonContainer.activate([
            stackButtonContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50.0),
            stackButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            stackButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            stackButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0)
        ])
        
        let popupButton: UIButton = Subviews.createButton(title: "Pop-up zoom dialog")
        popupButton.addTarget(self, action: .zoomTapped, for: .touchUpInside)
        stackButtonContainer.addArrangedSubview(popupButton)
        
        let bounceFromBottomButton: UIButton = Subviews.createButton(title: "Pop-up bounce from bottom dialog")
        bounceFromBottomButton.addTarget(self, action: .bounceBottomTapped, for: .touchUpInside)
        stackButtonContainer.addArrangedSubview(bounceFromBottomButton)
        
        let bounceFromTopButton: UIButton = Subviews.createButton(title: "Pop-up bounce from top dialog")
        bounceFromTopButton.addTarget(self, action: .bounceTopTapped, for: .touchUpInside)
        stackButtonContainer.addArrangedSubview(bounceFromTopButton)
        
        let slideButton: UIButton = Subviews.createButton(title: "Slide interactive controller")
        slideButton.addTarget(self, action: .slideTapped, for: .touchUpInside)
        stackButtonContainer.addArrangedSubview(slideButton)
    }
    
    
    @objc func zoomTapped(_ sender: UIButton) {
        let dialog = DialogViewController()
        dialog.transitioningDelegate = popZoomTransitionManager
        dialog.modalPresentationStyle = .custom
        
        present(dialog, animated: true, completion: nil)
    }
    
    @objc func bounceBottomTapped(_ sender: UIButton) {
        let dialog = DialogViewController()
        dialog.transitioningDelegate = bounceBottomTransitionManager
        dialog.modalPresentationStyle = .custom
        
        present(dialog, animated: true, completion: nil)
    }
    
    @objc func bounceTopTapped(_ sender: UIButton) {
        let dialog = DialogViewController()
        dialog.transitioningDelegate = bounceTopTransitionManager
        dialog.modalPresentationStyle = .custom
        
        present(dialog, animated: true, completion: nil)
    }
    
    @objc func slideTapped(_ sender: UIButton) {
        let second = SlideViewController()
        second.transitioningDelegate = interactiveSlideTransitionManager
        second.modalPresentationStyle = .custom
        
        present(second, animated: true, completion: nil)
    }

}

private enum Subviews {
    
    static var imageView: UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "harry")
        return imageView
    }
    
    static var stackButtonContainer: UIStackView {
        let stackButtonContainer: UIStackView = UIStackView()
        stackButtonContainer.axis = .vertical
        stackButtonContainer.distribution = .equalSpacing
        return stackButtonContainer
    }
    
    static func createButton(title: String) -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemGreen
        button.activate([
            button.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        button.layer.cornerRadius = 10.0
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        return button
    }
}
