//
//  UIViewController+Extension.swift
//  Navigation
//
//  Created by Сергей Денисенко on 17.03.2022.
//

import UIKit

extension UIViewController {
    func addTapToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
