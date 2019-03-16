//
//  AdventureTableViewCell.swift
//  group16_assignment6
//
//  Created by Thomas Mendez on 3/15/19.
//  Copyright © 2019 group16. All rights reserved.
//

import UIKit

class AdventureTableViewCell: UITableViewCell {

    @IBOutlet weak var AdventurerImage:UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelLevel: UILabel!
    
    @IBOutlet weak var labelClass: UILabel!
    
    @IBOutlet weak var labelAttackModifier: UILabel!
    
    @IBOutlet weak var labelHP: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
