//
//  MovieDetailTableViewCell.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var dateInfoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.masksToBounds = false
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCellData(obj: MovieDetailData?){
        titleLabel.text = obj?.title
        let imageUrl = "https://image.tmdb.org/t/p/w185" + (obj?.posterUrl ?? "")
        posterImageView.sd_imageTransition = .fade
        posterImageView.sd_setImage(with: URL.init(string: imageUrl), completed: nil)
        dateInfoLabel.text = (obj?.movieType ?? "") + " | " + (obj?.releaseDate ?? "")
        durationLabel.text = String(obj?.runtime ?? 0)
        var launguages = ""
        if let languageArr = obj?.languages{
            for (index, value) in languageArr.enumerated(){
                if index == languageArr.count - 1{
                    launguages += value.language
                }
                else{
                    launguages += value.language + ", "
                }
            }
        }
        languageLabel.text = launguages
        votesLabel.text = String(obj?.voteCount ?? 0) + " Votes"
//        likeLabel.text = (obj?.popularity ?? "") + " % popularity"
        movieDescriptionLabel.text = obj?.overview
    }
}
