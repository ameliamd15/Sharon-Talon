//
//  CircularImageView.swift
//  Sharon Talon
//
//  Created by Amelia Dasari on 12/11/20.
//

import UIKit

@IBDesignable
class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 130 / 2
        self.clipsToBounds = true
    }
}
