//
//  AvatarZoomView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 29.04.2022.
//

import UIKit

class AvatarZoomView: UIView {

    var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IMG_1"))
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 1.0
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func drawSelf() {
        self.addSubview(avatarImageView)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 1.0

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
