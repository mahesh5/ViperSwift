// 
//  HomeProtocols.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import UIKit

// MARK: View -
protocol HomePresenterToView: AnyObject {
    var presenter: HomeViewToPresenter? { get set }
    func displayNews(response: [NewsVM])
    func displayError(error: Error)
}

// MARK: Interactor -
protocol HomePresenterToInteractor: AnyObject {
    var presenter: HomeInteractorToPresenter? { get set }
    func getNewsData()
}

// MARK: Router -
protocol HomePresenterToRouter: AnyObject {
}

// MARK: Presenter -
protocol HomeViewToPresenter: AnyObject {
    var view: HomePresenterToView? { get set }
    var interactor: HomePresenterToInteractor? { get set }
    var router: HomePresenterToRouter? { get set }
    func loadNews()
}

protocol HomeInteractorToPresenter: AnyObject {
    func processNewsData(response: NewsList)
    func processErrorData(error: Error)
}
