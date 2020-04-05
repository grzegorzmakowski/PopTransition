//
//  DialogViewController.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 05/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let leviosaTapped = #selector(DialogViewController.leviosaTapped)
    static let dismissTapped = #selector(DialogViewController.dismissTapped)
}

class DialogViewController: UIViewController {
    
    var imageView: UIImageView?
    var leviosaButton: UIButton?
    var dismissButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        let imageView = Subviews.imageView
        view.addSubview(imageView)
        imageView.activate([
//            view.widthAnchor.constraint(equalToConstant: 200), //you can uncomment to see if working, dialog will be smaller
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        self.imageView = imageView
        
        let stackButtonContainer: UIStackView = Subviews.stackButtonContainer
        view.addSubview(stackButtonContainer)
        stackButtonContainer.activate([
            stackButtonContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5.0),
            stackButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        let leviosaButton: UIButton = Subviews.createButton(title: "Leviooossaa")
        leviosaButton.addTarget(self, action: .leviosaTapped, for: .touchUpInside)
        stackButtonContainer.addArrangedSubview(leviosaButton)
        self.leviosaButton = leviosaButton
        
        let dismissButton: UIButton = Subviews.createButton(title: "Stop it Ron")
        dismissButton.isHidden = true
        dismissButton.addTarget(self, action: .dismissTapped, for: .touchUpInside)
        stackButtonContainer.addArrangedSubview(dismissButton)
        self.dismissButton = dismissButton
    }
    
    @objc func leviosaTapped(_ sender: UIButton) {
        imageView?.image = UIImage(named: "hermiona")
        leviosaButton?.isHidden = true
        dismissButton?.isHidden = false
        view.layoutIfNeeded()
    }

    @objc func dismissTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

private enum Subviews {
    
    static var imageView: UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "ron")
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
