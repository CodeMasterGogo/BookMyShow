//
//  ReviewTableViewCell.swift
//  BookMyShow
//
//  Created by Girish Rao on 27/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var revieLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCellData(obj: ReviewResult?){
        revieLabel.text = obj?.content 
    }
}
