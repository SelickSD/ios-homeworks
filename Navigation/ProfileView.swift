//
//  ProfileView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 05.02.2022.
//

import UIKit

@IBDesignable
class ProfileView: UIView {

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileDateLabel: UILabel!
    @IBOutlet weak var profileCityLabel: UILabel!
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var profileFotoImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()

        self.profileNameLabel.text = "Лори"
        self.profileDateLabel.text = "Август 2018"
        self.profileCityLabel.text = "Краснодар"
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
