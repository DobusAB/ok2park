//
//  SignsCollectionViewCell.swift
//  ok2park
//
//  Created by Arbetskonto on 2017-04-17.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit

class SignsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var signsContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        signsContainerView.layer.shadowOpacity = 0.7
        signsContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        signsContainerView.layer.shadowRadius = 5.0
        signsContainerView.layer.shadowColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0).cgColor
        
    }

}
