//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 07.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeaderView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = self.view.bounds
    }
}
