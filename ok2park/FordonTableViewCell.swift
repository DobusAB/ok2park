//
//  FordonTableViewCell.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-05-10.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit

class FordonTableViewCell: UITableViewCell {
    @IBOutlet weak var colorViewInCell: UIView!

    @IBOutlet weak var fordonLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colorViewInCell.layer.cornerRadius = colorViewInCell.frame.size.width/2
        self.colorViewInCell.layer.masksToBounds = false
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
