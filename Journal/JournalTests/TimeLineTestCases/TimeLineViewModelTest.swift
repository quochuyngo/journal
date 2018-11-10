//
//  TimeLineViewModelTest.swift
//  JournalTests
//
//  Created by Quoc Huy Ngo on 9/27/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import XCTest
@testable import Journal

class StubDBManager: BaseDBManager {
    static var `default`: BaseDBManager  = StubDBManager()
    
    var mockJournalList: [Journal]!
    
    func getListJournal() -> [Journal] {
        return mockJournalList
    }
    
    func add(_ journal: Journal) {
        mockJournalList.append(journal)
    }
    
    func delete(_ journal: Journal) {
        if let index = mockJournalList.firstIndex(of: journal) {
            mockJournalList.remove(at: index)
        }
    }
    
    func update(_ journal: Journal) {
        
    }
    
}
class TimeLineViewModelTest: XCTestCase {

    var journals: [Journal]!
    var dbManager: StubDBManager!
    var viewModel: TimelineViewModel!
    var journal: Journal!
    
    override func setUp() {
        dbManager = StubDBManager()
        journals = [Journal]()
        journal = Journal(content: "", location: nil, emotion: EmojiItem(.happy), tags: [""].toList(), photos: nil)
        journals.append(journal)
        dbManager.mockJournalList = journals
        viewModel =  TimelineViewModel(databaseManager: dbManager)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetListJournalSuccess() {
        XCTAssertEqual(journals.count, viewModel.journalList.count)
    }
    
    func testDeleteJournal() {
        viewModel.delete(journal)
        XCTAssertEqual(viewModel.journalList.count, 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
