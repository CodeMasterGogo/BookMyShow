//
//  MovieTableViewCell.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBAction func bookBtnPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    let networkManger = MovieNetworkManger()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookBtn.layer.cornerRadius = 5
        bookBtn.layer.borderWidth = 1
        bookBtn.layer.borderColor = UIColor.lightGray.cgColor
//        movieImageView.layer.cornerRadius = 5
        
        movieImageView.layer.masksToBounds = false
        movieImageView.layer.cornerRadius = 5
        movieImageView.clipsToBounds = true
    }

    @IBOutlet weak var cardView: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellData(obj: MovieObject?){
        titleLabel.text = obj?.title
        releaseDateLabel.text = obj?.relaeseDate
        let imageUrl = "https://image.tmdb.org/t/p/w185" + (obj?.posterPath ?? "")
        movieImageView.sd_imageTransition = .fade
        movieImageView.sd_setImage(with: URL.init(string: imageUrl), completed: nil)
    }

}

extension UIView{
    
    func setCardView(){
        self.layer.cornerRadius = 3
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 3)
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1);
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
}
