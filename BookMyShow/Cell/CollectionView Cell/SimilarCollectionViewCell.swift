//
//  SimilarCollectionViewCell.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func setupCellData(obj: SimilarMovies?){
        let imageUrl = "https://image.tmdb.org/t/p/w185" + (obj?.posterUrl ?? "")
        posterImageView.sd_imageTransition = .fade
        posterImageView.sd_setImage(with: URL.init(string: imageUrl), completed: nil)
        titleLabel.text = " " + (obj?.title ?? "")
        subTitleLabel.text = " " + (obj?.releaseDate ?? "")
    }
}
