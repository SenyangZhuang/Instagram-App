//
//  TableViewCell.swift
//  Instagram
//
//  Created by Senyang Zhuang on 1/27/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    

    @IBOutlet weak var contentImage: UIImageView!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
