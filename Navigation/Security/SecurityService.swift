//
//  SecurityService.swift
//  Navigation
//
//  Created by Сергей Денисенко on 30.04.2022.
//

import UIKit

class SecurityService {

    func checkSecurityControl(_ login: UITextField, _ password: UITextField,
                              _ stack: UIStackView, _ warningLabel: UILabel,
                              _ viewController: LogInViewController) -> Bool {

        guard let loginString = login.text else { return false }
        guard let passwordString = password.text else { return false }

        let safeSecurityData = SecurityData()
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

        if !emailValidator(loginString, viewController) {
            return false
        }

        showAlert(alertTitle: "Invalid login or password", alertMessage: nil, viewController: viewController)
        return false
    }

    private func emailValidator(_ email: String, _ viewController: UIViewController) -> Bool {

        var index = 0
        var char: Character
        var state = 0
        var login: String?


        while index <= email.count && state != -1 {
            if index == email.count {
                char = "\0"
            } else {
                char = email[email.index(email.startIndex, offsetBy: index)]
                if char == "\0" {
                    showAlert(alertTitle: "Invalid login", alertMessage: "Invalid character entered in login", viewController: viewController)
                    return false
                }
            }
            switch state {
            case 0:
                if ((char >= "a" && char <= "z") ||
                    (char >= "A" && char <= "Z") ||
                    (char >= "0" && char <= "9") ||
                    char == "_" || char == "-" ||
                    char == "+") {
                    state = 1
                    break
                } else {
                    state = -1
                    break
                }
            case 1:
                if ((char >= "a" && char <= "z") ||
                    (char >= "A" && char <= "Z") ||
                    (char >= "0" && char <= "9") ||
                    char == "_" || char == "-" ||
                    char == "+") {
                    break
                } else if char == "." {
                    state = 2
                    break
                } else if char == "@" {
                    login = String(email[..<email.index(email.startIndex, offsetBy: index)])
                    state = 3
                    break
                } else {
                    state = -1
                    break
                }
            case 2:
                if ((char >= "a" && char <= "z") ||
                    (char >= "A" && char <= "Z") ||
                    (char >= "0" && char <= "9") ||
                    char == "_" || char == "-" ||
                    char == "+") {
                    state = 1
                    break
                } else {
                    state = -1
                    break
                }
            case 3:
                if ((char >= "a" && char <= "z") ||
                    (char >= "A" && char <= "Z") ||
                    (char >= "0" && char <= "9")) {
                    state = 4
                    break
                } else {
                    state = -1
                    break
                }
            case 4:
                if ((char >= "a" && char <= "z") ||
                    (char >= "A" && char <= "Z") ||
                    (char >= "0" && char <= "9")) {
                    break
                } else if char == "-" {
                    state = 5
                    break
                } else if char == "." {
                    state = 5
                    break
                } else if char == "\0" {
                    state = 6
                    break
                } else {
                    state = -1
                    break
                }
            case 5:
                if ((char >= "a" && char <= "z") ||
                    (char >= "A" && char <= "Z") ||
                    (char >= "0" && char <= "9")) {
                    state = 4
                    break
                } else if char == "-" {
                    break
                } else {
                    state = -1
                    break
                }
            case 6:
                break

            default:
                state = -1
                break
            }
            index += 1
        }

        if let newLogin = login {
            if state == 6 && email != SecurityData().standardLogin {
                showAlert(alertTitle: "User \(newLogin) is not registered", alertMessage: "Please contact technical support on the website", viewController: viewController)
                return false
            } else if state != 6 {
                showAlert(alertTitle: "Invalid email", alertMessage: nil, viewController: viewController)
                return false
            }
        } else {
            showAlert(alertTitle: "Invalid email", alertMessage: "Email must contain the @ symbol", viewController: viewController)
            return false
        }

        showAlert(alertTitle: "Invalid login or password", alertMessage: nil, viewController: viewController)
        return false
    }

    private func showAlert(alertTitle: String, alertMessage: String?, viewController: UIViewController) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
