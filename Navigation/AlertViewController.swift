//
//  AlertViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 27.02.2022.
//

import UIKit

class AlertViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()

    }
    private func setupView(){
        self.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in self.isTrue()}))
        self.addAction(UIAlertAction(title: "Нет", style: .default, handler: { _ in self.isFalse()}))
    }

    private func isTrue(){
        print("Ты выбрал ДА")
    }
    private func isFalse(){
        print("Ты выбрал НЕТ")
    }

}
