//
//  SourcesDataSourceTests.swift
//  HeadlinesTests
//
//  Created by Pratik Bhaliya on 26/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import XCTest
@testable import Headlines

class SourcesDataSourceTests: XCTestCase {

    var dataSource: SourceListDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = SourceListDataSource()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataSource() {
        let restaurentList = SourcesViewController()
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
        let source = [Source(id: "abc-news-au", name: "ABC News (AU)", sourceDescription: "Australia's most trusted source of local,", url: "http://www.abc.net.au/news", category: .general, language: .en, country: "au")]

        dataSource.data.value = source
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 1, "Expected cell in table view")
    }

}
