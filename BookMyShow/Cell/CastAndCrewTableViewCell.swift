//
//  CastAndCrewTableViewCell.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit

enum CellTypeEnum: Int{
    case castCell = 0, crewCell, similarMovieCell
}

class CastAndCrewTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var cellType: CellTypeEnum = .castCell
    var castArr: [CastObj]?
    var crewArr: [CrewObj]?
    var similarMovieArr: [SimilarMovies]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.register(UINib.init(nibName: "InfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InfoCollectionViewCellID")
        collectionView.register(UINib.init(nibName: "SimilarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarCollectionViewCellID")
    }
    
    func setupCastCellData(obj: [CastObj]?){
        collectionViewHeight.constant = 150
        cellType = .castCell
        castArr = obj
        collectionView.reloadData()
    }
    
    func setupCastCellData(obj: [CrewObj]?){
        collectionViewHeight.constant = 150
        cellType = .crewCell
        crewArr = obj
        collectionView.reloadData()
    }
    
    func setupCastCellData(obj: [SimilarMovies]?){
        collectionViewHeight.constant = 200
        cellType = .similarMovieCell
        similarMovieArr = obj
        collectionView.reloadData()
    }
}

extension CastAndCrewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellType {
        case .castCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCellID", for: indexPath) as? InfoCollectionViewCell
            if let obj = castArr?[indexPath.row]{
                cell?.setUpCellData(obj: obj)
            }
            return cell!
        case .similarMovieCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionViewCellID", for: indexPath) as? SimilarCollectionViewCell
            if let obj = similarMovieArr?[indexPath.row]{
                cell?.setupCellData(obj: obj)
            }
            return cell!
        case .crewCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCellID", for: indexPath) as? InfoCollectionViewCell
            if let obj = crewArr?[indexPath.row]{
                cell?.setUpCellData(obj: obj)
            }
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         switch cellType {
         case .castCell:
            return castArr?.count ?? 0
         case .similarMovieCell:
            return similarMovieArr?.count ?? 0
         case .crewCell:
            return crewArr?.count ?? 0
        }
    }
}

extension CastAndCrewTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case .castCell:
            return CGSize.init(width: 120.0, height: 140.0)
        case .similarMovieCell:
            return CGSize.init(width: 120.0, height: 190.0)
        case .crewCell:
            return CGSize.init(width: 120.0, height: 140.0)
        }
    }
}
