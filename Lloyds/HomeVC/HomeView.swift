//
//  HomeView.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import UIKit
import SafariServices

class HomeView: UIViewController, HomePresenterToView {
   
    
    @IBOutlet weak var tableViewHome: UITableView!
    var presenter: HomeViewToPresenter?
    var newsViewModel: [NewsVM] = [NewsVM]()
    let errorAlert: ErrorAlert = ErrorAlert()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    init() {
        super.init(nibName: String(describing: HomeView.self), bundle: Bundle(for: HomeView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = K.title
        self.tableViewHome.alpha = 0
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableViewHome.register(UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        presenter?.loadNews()
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self), for: indexPath) as! HomeTableViewCell
        let articalData = newsViewModel[indexPath.row]
        cell.updateTableViewCell(data: articalData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articalData = newsViewModel[indexPath.row]
        self.showDetails(articalData.sourceURL ?? "")
        
    }
    
}

extension HomeView {
    func displayNews(response: [NewsVM]) {
        newsViewModel = response
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableViewHome.alpha = 1
            self.tableViewHome.reloadData()
        }
    }
    
    func displayError(error: Error) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableViewHome.alpha = 0
            self.errorAlert.showMessage(message: error.localizedDescription, controller: self)
        }
    }
}

extension HomeView {
    func showDetails(_ url: String) {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

