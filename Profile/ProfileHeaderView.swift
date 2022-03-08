//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 07.03.2022.
//

import UIKit


@IBDesignable
class ProfileHeaderView: UIView {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileStatus: UILabel!
    @IBOutlet weak var statusButton: UIButton!

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

        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)

        }

    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "ProfileView", bundle: bundle)
        return xib.instantiate(withOwner: self, options: nil).first! as! UIView
    }

}
