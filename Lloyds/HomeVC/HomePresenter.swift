//
//  HomePresenter.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import Foundation

class HomePresenter: HomeViewToPresenter {
 
    
    weak var view: HomePresenterToView?
    var interactor: HomePresenterToInteractor?
    var router: HomePresenterToRouter?
    
    func loadNews() {
        interactor?.getNewsData()
    }
    
}

extension HomePresenter: HomeInteractorToPresenter {
    func processNewsData(response: NewsList) {
        let news = response.articles?.compactMap { article -> NewsVM in
            let formattedDate = DateUtils.formatDate(date: article.publishedAt ?? "")
            let formattedContent = processHTMLString(value: article.description ?? "")
            let date = DateUtils.sortByDate(date: article.publishedAt ?? "")
            let viewModel = NewsVM(source: article.source?.name, title: article.title, subTitle: formattedContent, date: formattedDate, sourceURL: article.url, sortDate: date)
            return viewModel
        }
        guard let newsData = news else { return }
        view?.displayNews(response: sortByDate(data: newsData))
    }
    
    func processErrorData(error: Error) {
        view?.displayError(error: error)
    }
    
    func processHTMLString(value: String)-> String {
        guard let data = value.data(using: .utf8) else {
            return  K.noData
        }
        do {
            let attrStr = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return attrStr.string
        } catch {
            print(error)
            return K.noData

        }
    }
    
}


extension HomePresenter {
    func sortByDate(data: [NewsVM]) -> [NewsVM] {
        return  data.sorted(by: {
            $0.sortDate?.compare($1.sortDate ?? Date()) == .orderedDescending
        })
    }
}
