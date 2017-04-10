//
//  extensions.swift
//  ok2park
//
//  Created by Arbetskonto on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit

class extensions: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIButton {
    func roundedButton(){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight , .bottomLeft],cornerRadii:CGSize(width:24.0, height:24.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}
