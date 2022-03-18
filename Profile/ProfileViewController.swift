//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 07.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray

        self.addTapGestureToHideKeyboard()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(profileHeaderView)

        let topViewConstraint = profileHeaderView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingViewConstraint = profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingViewConstraint = profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomViewConstraint = profileHeaderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        NSLayoutConstraint.activate([
            topViewConstraint, leadingViewConstraint, trailingViewConstraint, bottomViewConstraint
        ])
    }
}

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
