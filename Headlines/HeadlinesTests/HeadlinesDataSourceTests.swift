//
//  HeadlinesDataSourceTests.swift
//  HeadlinesTests
//
//  Created by Pratik Bhaliya on 26/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import XCTest
@testable import Headlines

class HeadlinesDataSourceTests: XCTestCase {

    var dataSource: HeadlineListDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = HeadlineListDataSource()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataSource() {
        let restaurentList = HeadlinesViewController()
        restaurentList.dataSource = dataSource
        XCTAssertTrue(restaurentList.dataSource == dataSource)
    }
    
    func testTableViewSection() {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        let numberOfSection = tableView.numberOfSections
        XCTAssertEqual(1, numberOfSection)
    }

    func testValuesInDataSource() {
        
        // giving data value
        let article = [Article(author: "Alicia Newton", title: "NRL 2020: Canberra Raiders v South Sydney", articleDescription: "The Canberra Raiders have come from behind to beat South Sydney 18-12 in a gripping battle", url: "https://www.cnn.com/2020/07/25/health/us-coronavirus-saturday/index.html", urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/200725013337-coronavirus-patient-hospital-0702-super-tease.jpg", publishedAt: "2020-07-25T06:48:00Z", content: "(CNN)Coronavirus symptoms can stick around for weeks,")]
        dataSource.data.value = article
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 1, "Expected cell in table view")
    }

}
