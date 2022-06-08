//
//  LloydsTests.swift
//  LloydsTests
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import XCTest
@testable import Lloyds

class LloydsTests: XCTestCase {

    var presenter: HomePresenter!
    var interactor: HomeInteractor!
    var homeVC: HomeView!
    var article: NewsList?
    var router: HomeRouter!
    var vm: [NewsVM] = [NewsVM]()
    func testTableView() {
        let tableCell = Bundle(for: HomeTableViewCell.self).loadNibNamed("HomeTableViewCell", owner: nil)?.first as! HomeTableViewCell
           XCTAssertNotNil(tableCell)
    }
    
    func testTableViewCellHasReuseIdentifier() {
       let tableCell = Bundle(for: HomeTableViewCell.self).loadNibNamed("HomeTableViewCell", owner: nil)?.first as! HomeTableViewCell
       let actualReuseIdentifer = tableCell.reuseIdentifier
        let expectedReuseIdentifier = "HomeTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

   
    
    func testInteractor() {
        interactor = HomeInteractor()
        XCTAssertNotNil(interactor.getNewsData(), "Method Called")
        XCTAssertNotNil(interactor, "Method Called")
        let articlesExpectation = expectation(description: "articles")
        
        APINetworkLayer.requestApi(url: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=d38fda9ee4b94470856e427ee7d15caa") { (result: Result<NewsList, Error>) in
            switch result {
            case .success(let article):
                articlesExpectation.fulfill()
                XCTAssert((article.articles?.count != 0), "Fetched data from API")
            case .failure( _ ):
                let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to load data"])
                let err = XCTestError(XCTestError.Code(rawValue: error.code)!)
                XCTAssert(((err.errorCode) != 0), "Error while fetching the data")
            }
        }
        wait(for: [articlesExpectation], timeout: 30.0)

    }

    func testPresenter() {
        presenter = HomePresenter()
        XCTAssertNotNil(presenter.loadNews(), "Api loaded from presenter to interactor")
        guard let article = article else {
            XCTAssertNil(article, "Data not found")
            return
        }
        let date = Date()
        let vm = NewsVM(source: "Test", title: "Test", subTitle: "Test", date: "2021-11-22T23:35:00Z", sourceURL: "Test", sortDate: date)
        XCTAssertNotNil(presenter.sortByDate(data: [vm]), "Data has been sorted")

        let str = "El Salvador plans to build the world's first <a href="+"https://www.reuters.com/markets/rates-bonds/el-salvador-plans-first-bitcoin-city-backed-by-bitcoin-bonds-2021"
        XCTAssertNotNil(presenter.processHTMLString(value: str), "Html strings validated")
        XCTAssertNotNil(presenter.processNewsData(response:article), "View model method called")
    }
}

