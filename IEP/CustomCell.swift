//
//  CustomCell.swift
//  IEP
//
//  Created by Miguel Asipavicins on 09/04/16.
//  Copyright © 2016 Miguel Asipavicins. All rights reserved.
//

import UIKit
import SDWebImage

class CustomCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var eventPicture: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
