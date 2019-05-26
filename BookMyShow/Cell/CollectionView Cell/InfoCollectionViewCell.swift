//
//  InfoCollectionViewCell.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCellData(obj: CrewObj?){
        let imageUrl = "https://image.tmdb.org/t/p/w185" + (obj?.profileUrl ?? "")
        castImageView.sd_imageTransition = .fade
        castImageView.sd_setImage(with: URL.init(string: imageUrl), completed: nil)
        titleLabel.text = obj?.name
        subTitleLabel.text = obj?.job
    }
    
    func setUpCellData(obj: CastObj?){
        let imageUrl = "https://image.tmdb.org/t/p/w185" + (obj?.profileUrl ?? "")
        castImageView.sd_imageTransition = .fade
        castImageView.sd_setImage(with: URL.init(string: imageUrl), completed: nil)
        titleLabel.text = obj?.name
        subTitleLabel.text = obj?.character
    }
}
