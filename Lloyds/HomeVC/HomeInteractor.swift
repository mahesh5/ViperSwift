// 
//  HomeInteractor.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import Foundation

class HomeInteractor: HomePresenterToInteractor {
    weak var presenter: HomeInteractorToPresenter?

    func getNewsData() {
        if let path = APIRouter.getArticles.path {
            APINetworkLayer.requestApi(url: path) {[weak self] (result: Result<NewsList, Error>) in
                switch result {
                case .success(let response):
                    self?.presenter?.processNewsData(response: response)
                case .failure(let error):
                    self?.presenter?.processErrorData(error: error)
                }
                
            }
        }
        
    }
}
