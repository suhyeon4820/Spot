//
//  nilTableViewCell.swift
//  Spot
//
//  Created by suhyeon on 2021/02/15.
//

import UIKit

class nilValueTableViewCell: UITableViewCell {

    static let identifier = "nilValueTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "nilValueTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
