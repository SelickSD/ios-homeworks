//
//  InfoViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 27.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var customButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupButton()
    }

    private func setupView(){
        self.view.backgroundColor = .systemGray
    }

    private func setupButton(){
        self.view.addSubview(self.customButton)
        self.customButton.layer.cornerRadius = 12
        self.customButton.clipsToBounds = true
        self.customButton.backgroundColor = .systemBlue
        self.customButton.setTitleColor(.white, for: .normal)
        self.customButton.setTitle("Внимание", for: .normal)
        self.customButton.frame = CGRect(x:  UIScreen.main.bounds.size.width - 310, y: UIScreen.main.bounds.size.height - 150, width: 200, height: 50)
        self.customButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc private func didTapButton(){
        let alertAction = AlertViewController(title: "Внимание", message: "Была нажата кнопка тревоги", preferredStyle: .alert)
        self.present(alertAction, animated: true, completion: nil)
    }
}
