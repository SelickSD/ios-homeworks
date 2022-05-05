//
//  FeedModel.swift
//  Navigation
//
//  Created by Сергей Денисенко on 05.05.2022.
//

import UIKit

struct FeedModel {
    let image: UIImage

    static func showGallery() -> [FeedModel] {
        let myGallery: [String] = ["feed1", "feed3", "feed4", "feed5",
                                   "feed7", "feed8", "feed10",
                                   "feed11", "feed13", "feed1", "feed16",
                                   "feed18", "feed20", "feed21",
                                   "feed23", "feed25",
                                   "feed27", "feed29", "feed30", "feed31",
                                   "feed32", "feed33", "feed34", "feed35", "feed36"]
        var arrayImage = [UIImage]()
        var gallery = [FeedModel]()

        myGallery.forEach { arrayImage.append(UIImage(named: $0) ?? UIImage()) }
        arrayImage.forEach { gallery.append(FeedModel(image: $0)) }

        return gallery
    }
}
