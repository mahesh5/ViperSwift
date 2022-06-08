// 
//  HomeConfigurator.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import UIKit

public class HomeConfigurator {
    public static var shared =  HomeConfigurator()
    public func createHomeModule() -> UIViewController {
        let view: UIViewController & HomePresenterToView = HomeView()
        let presenter: HomeViewToPresenter & HomeInteractorToPresenter = HomePresenter()
        let interactor: HomePresenterToInteractor = HomeInteractor()
        let router: HomePresenterToRouter = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
