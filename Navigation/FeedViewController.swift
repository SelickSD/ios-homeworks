//
//  FeedViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 25.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

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

        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.customButton)

    }

    private func setupButton(){
        self.customButton.layer.cornerRadius = 12
        self.customButton.clipsToBounds = true
        self.customButton.backgroundColor = .systemBlue
        self.customButton.setTitleColor(.white, for: .normal)
        self.customButton.setTitle("Кнопка", for: .normal)
        self.customButton.frame = CGRect(x:  UIScreen.main.bounds.size.width - 310, y: UIScreen.main.bounds.size.height - 150, width: 200, height: 50)
        self.customButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)


    }

    @objc private func didTapButton(){
        print(UIScreen.main.bounds.size.width)
        print(UIScreen.main.bounds.size.height)


    }
}
