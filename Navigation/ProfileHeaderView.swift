//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 26.02.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView {

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf(){
    self.addSubview(self.statusButton)
    }

    @objc private func didTapStatusButton() {

    }

}



