//
//  ViewController.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK : IBOutlet
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    
    // MARK : Variables
    let apiKey = "f6290311bc8744c23f0c450481125a0c"
    let width = UIScreen.main.bounds.width
    var searchBar:UISearchBar = UISearchBar()
    var presenter: MoviePresenter?
    var movieArr: [MovieObject]?
    var searchedMovieArr: [MovieObject]?
    var totalPages: Int = 0
    var currentPage: Int = 0
    var movieCountPerPage: Int = 20
    var isPagination: Bool = false
    var isSearching: Bool = false
    var movieID: Int = 0
    var movieTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCellID")
        self.presenter = MoviePresenter(delegate: self)
        presenter?.getMoviewData(apikey: apiKey, page: 1)
        setUpSearchBar()
        setUpKeyBoardNotification()
    }
    
    func setUpSearchBar(){
        searchBar.placeholder = "Search Movie"
        searchBar.sizeToFit()
        searchBar.tintColor = UIColor.black
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func setUpKeyBoardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        let userInfo:NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let keyboardHeight = (userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey)! as AnyObject).cgRectValue.size.height
        tableViewBottom.constant = keyboardHeight - 58
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableViewBottom.constant = 8
        self.view.layoutIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC : MovieDetailViewController = segue.destination as? MovieDetailViewController{
            destVC.movieID = movieID
            destVC.movieTitle = movieTitle
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row >= movieCountPerPage - 3 && currentPage <= totalPages && !isSearching{
            movieCountPerPage = movieCountPerPage + 20
            isPagination = true
            presenter?.getMoviewData(apikey: apiKey, page: currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchedMovieArr?.count ?? 0
        }
        return movieArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCellID") as? MovieTableViewCell
        var obj: MovieObject?
        if isSearching{
            obj = searchedMovieArr?[indexPath.row]
        }
        else{
            obj = movieArr?[indexPath.row]
        }
        cell?.setupCellData(obj: obj)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var obj: MovieObject?
        if isSearching{
            obj = searchedMovieArr?[indexPath.row]
        }
        else{
            obj = movieArr?[indexPath.row]
        }
        movieID = obj?.id ?? 0
        movieTitle = obj?.title ?? ""
        performSegue(withIdentifier: "MovieDetailViewSegueID", sender: self)
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        self.view.endEditing(true)
        isSearching = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getSearchString(searchText: searchText)
    }
    
    func getSearchString(searchText: String){
        searchedMovieArr = self.movieArr?.filter({ (obj) -> Bool in
             let titleArr = obj.title.split(separator: " ")
            for value in titleArr{
                if value.count >= searchText.count{
                    let endIndex = value.index(value.startIndex, offsetBy: searchText.count)
                    let subValue = value[value.startIndex ..< endIndex]
                    if subValue.lowercased() == searchText.lowercased(){
                        return true
                    }
                }
                else{
                    let searchStrEndIndex = searchText.index(searchText.startIndex, offsetBy: value.count)
                    let subSearchValue = searchText[searchText.startIndex ..< searchStrEndIndex]
                    if subSearchValue.lowercased() == value.lowercased(){
                        return true
                    }
                }
            }
            return false
        })
        isSearching = true
        tableView.reloadData()
    }
}

extension ViewController: MovieDelegate{
    func showProgress() {
        DispatchQueue.main.async {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
        }
    }
    
    func getMovieData(movieArr: [MovieObject], totalPage: Int, currentPage: Int) {
        if isPagination{
           self.movieArr?.append(contentsOf: movieArr)
        }
        else{
            self.movieArr?.removeAll()
            self.movieArr = movieArr
        }
        self.totalPages = totalPage
        self.currentPage = currentPage + 1
        self.movieCountPerPage = self.movieArr?.count ?? 0
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failedtogetMovieData(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Retry", style: .default, handler: { (action) in
            self.presenter?.getMoviewData(apikey: self.apiKey, page: 1)
        }))
        self.present(alert, animated: true)
    }
}
