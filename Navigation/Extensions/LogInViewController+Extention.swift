//
//  LogInViewController+Extention.swift
//  Navigation
//
//  Created by Сергей Денисенко on 30.04.2022.
//
import UIKit

extension LogInViewController {

    func checkSecurityControl(_ login: UITextField, _ password: UITextField, _ stack: UIStackView, _ warningLabel: UILabel) -> Bool {

        guard let loginString = login.text else { return false }
        guard let passwordString = password.text else { return false }

        let safeSecurityData = SecurityService()
        guard loginString != safeSecurityData.standardLogin || passwordString != safeSecurityData.standardPassword else { return true }


        if loginString.isEmpty && passwordString.isEmpty {
            login.backgroundColor = UIColor(hex: "#f2d7d5")
            password.backgroundColor = UIColor(hex: "#f2d7d5")
            stack.shake()
            return false
        } else if loginString.isEmpty {
            login.backgroundColor = UIColor(hex: "#f2d7d5")
            stack.shake()
            return false
        } else if passwordString.isEmpty {
            password.backgroundColor = UIColor(hex: "#f2d7d5")
            stack.shake()
            return false
        }

        if passwordString.count < 5 {
            warningLabel.isHidden = false
            warningLabel.text = "Password must contain at least 5 characters"
            return false
        } else {
            warningLabel.isHidden = true
            warningLabel.text = ""
        }
        
        let alert = UIAlertController(title: "Invalid login or password", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        return false
    }
    
    func returnNormalOptions(_ views: [UIView]) {
        views.forEach { if $0.backgroundColor == UIColor(hex: "#f2d7d5") {
            $0.backgroundColor = .systemGray6 }
        }
    }
}
