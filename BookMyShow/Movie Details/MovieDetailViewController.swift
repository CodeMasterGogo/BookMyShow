//
//  MovieDetailViewController.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit

enum DetailViewSection: Int {
    case movieDetailInfo = 0, review, cast, crew, similarMovie
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: MovieDetailPresenter?
    var movieID: Int = 0
    var movieTitle: String = ""
    var cellType: DetailViewSection = .movieDetailInfo
    var movieDetailObj: MovieDetailData?
    var castArr: [CastObj]?
    var crewArr: [CrewObj]?
    var similarMovieArr: [SimilarMovies]?
    var reviewArr: [ReviewResult]?
    var castNcrewObj: CastnCrewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieDetailPresenter(delegate: self)
        presenter?.downloadDetails(movieId: movieID)
        tableView.register(UINib.init(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailTableViewCellID")
        tableView.register(UINib.init(nibName: "CastAndCrewTableViewCell", bundle: nil), forCellReuseIdentifier: "CastAndCrewTableViewCellID")
        tableView.register(UINib.init(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCellID")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = movieTitle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case DetailViewSection.movieDetailInfo.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCellID") as? MovieDetailTableViewCell
            cell?.setUpCellData(obj: movieDetailObj)
            return cell!
        case DetailViewSection.cast.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastAndCrewTableViewCellID") as? CastAndCrewTableViewCell
            cell?.setupCastCellData(obj: castArr)
            return cell!
        case DetailViewSection.crew.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastAndCrewTableViewCellID") as? CastAndCrewTableViewCell
            cell?.setupCastCellData(obj: crewArr)
            return cell!
        case DetailViewSection.review.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCellID") as? ReviewTableViewCell
            if (reviewArr?.count ?? 0) > 0{
                cell?.setUpCellData(obj: reviewArr?[0])
            }
            return cell!
        case DetailViewSection.similarMovie.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastAndCrewTableViewCellID") as? CastAndCrewTableViewCell
            cell?.setupCastCellData(obj: similarMovieArr)
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case DetailViewSection.movieDetailInfo.rawValue:
            return ""
        case DetailViewSection.cast.rawValue:
             return "Cast"
        case DetailViewSection.crew.rawValue:
            return "Crew"
        case DetailViewSection.review.rawValue:
            return String(reviewArr?.count ?? 0) + " Reviews"
        case DetailViewSection.similarMovie.rawValue:
            return "Similar Movies"
        default:
            return ""
        }
    }
}

extension MovieDetailViewController: MovieDetailDelegate{
    func getCastNCrewData(obj: CastnCrewData?) {
        self.castArr = obj?.cast
        self.crewArr = obj?.crew
    }
    
    func getSimilarMovieData(obj: SimilarMovieData?) {
        self.similarMovieArr = obj?.results
    }
    
    func getMovieReviewData(obj: ReviewData?) {
        self.reviewArr = obj?.results
    }
    
    func getMovieData(obj: MovieDetailData?) {
        self.movieDetailObj = obj
    }
    
    func showProgress() {
        DispatchQueue.main.async {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            self.tableView.isHidden = true
        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }

    func failedtogetMovieData(message: String) {
        
    }
    
    
}
