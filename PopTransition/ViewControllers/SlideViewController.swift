//
//  SlideViewController.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 05/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let dismissTapped = #selector(SlideViewController.dismissTapped)
}

class SlideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.44
        view.layer.shadowRadius = 13.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: -6.0)
        setupLayout()
    }
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.6)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    func setupLayout() {
        
        let stackButtonContainer: UIStackView = Subviews.stackButtonContainer
        view.addSubview(stackButtonContainer)
        stackButtonContainer.activate([
            stackButtonContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            stackButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            stackButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            stackButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0)
        ])
        
        let titleLabel: UILabel = Subviews.titleLabel
        stackButtonContainer.addArrangedSubview(titleLabel)
        
        let imageView = Subviews.imageView
        imageView.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.66)
        ])
        
        stackButtonContainer.addArrangedSubview(imageView)
        
        let dismissButton: UIButton = Subviews.createButton(title: "-10pts for Goodie!")
        dismissButton.addTarget(self, action: .dismissTapped, for: .touchUpInside)
        stackButtonContainer.addArrangedSubview(dismissButton)
    }
    
    @objc func dismissTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

private enum Subviews {
    
    static var titleLabel: UILabel {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        titleLabel.text = "Slide me down"
        titleLabel.textAlignment = .center
        return titleLabel
    }
    
    static var imageView: UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "snape")
        return imageView
    }
    
    static var stackButtonContainer: UIStackView {
        let stackButtonContainer: UIStackView = UIStackView()
        stackButtonContainer.axis = .vertical
        stackButtonContainer.distribution = .equalSpacing
        stackButtonContainer.spacing = 10.0
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

