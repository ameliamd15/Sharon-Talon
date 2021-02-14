//
//  RoundedButton.swift
//

import UIKit

class RoundedRectButton: UIButton {

    var selectedState: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2 / UIScreen.main.nativeScale
        layer.borderColor = UIColor.white.cgColor
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    func rgbaToUIColor(r: Int, g: Int, b: Int, a: Float) -> UIColor {
        let floatRed = CGFloat(r) / 255.0
        let floatGreen = CGFloat(g) / 255.0
        let floatBlue = CGFloat(b) / 255.0
        return UIColor(red: floatRed, green: floatGreen, blue: floatBlue, alpha: 1.0)
    }
    override func layoutSubviews(){
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        backgroundColor = rgbaToUIColor(r: 235, g: 174, b: 33, a: 1);
        self.titleLabel?.textColor = rgbaToUIColor(r: 165, g: 48, b: 45, a: 1);
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedState = !selectedState
        self.layoutSubviews()
    }
}
