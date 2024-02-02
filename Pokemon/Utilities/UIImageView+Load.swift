//
//  UIImageView+Load.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Kingfisher
import UIKit

extension UIImageView {
    func loadImage(withURL url: URL? = nil, urlString: String? = nil) {
        if let url {
            let resource = KF.ImageResource(downloadURL: url, cacheKey: "\(url.absoluteString)")
            KF.resource(resource).set(to: self)

        } else if let urlString {
            guard let url = URL(string: urlString) else {
                backgroundColor = .secondarySystemBackground
                return
            }
            let resource = KF.ImageResource(downloadURL: url, cacheKey: "\(url.absoluteString)")
            KF.resource(resource).set(to: self)

        } else {
            backgroundColor = .secondarySystemBackground
        }
    }
}
