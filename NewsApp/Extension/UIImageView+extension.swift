//
//  UIImageView+extension.swift
//  NewsApp
//
//  Created by Mert Karahan on 29.06.2022.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(urlToImage: String) {
        let url = URL(string: urlToImage)
        self.kf.setImage(with: url)
    }
}


