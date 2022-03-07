//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 07.03.2022.
//

import UIKit


@IBDesignable
class ProfileHeaderView: UIView {

    let imageView = UIImageView(
        image: UIImage(named: "image_01")// исходная картинка
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {



        self.setupProfileImage()






        }
    private func setupProfileImage() {
        self.addSubview(imageView)
        imageView.frame.size = CGSize(width: 100, height: 100) //размеры новой картинки
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.magenta.cgColor // цвет рамки
        imageView.layer.borderWidth = 10 // толщина рамки

    }

}
