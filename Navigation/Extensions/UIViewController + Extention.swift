//
//  UIViewController + Extention.swift
//  Navigation
//
//  Created by Сергей Денисенко on 22.03.2022.
//

import UIKit

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
