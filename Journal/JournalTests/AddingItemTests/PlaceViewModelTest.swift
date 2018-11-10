//
//  PlaceViewModelTest.swift
//  JournalTests
//
//  Created by Quoc Huy Ngo on 9/28/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import XCTest
@testable import Journal
import RxSwift
class PlaceViewModelTest: XCTestCase {

    var viewModel: PlaceViewModel!
    
    override func setUp() {
        let stubPlaceService = StubGooglePlaceService()
        viewModel = PlaceViewModel(googlePlaceService: stubPlaceService)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCurrentPlacesSuccess() {
        let input = PlaceViewModel.Input(searchQuery: Observable.just(""))
        let output = viewModel.transform(input: input)
        output.searchResult.subscribe(onNext: {
          places in
            XCTAssertNotNil(places, "This is not null")
        }).disposed(by: DisposeBag())
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class StubGooglePlaceService: GooglePlaceServiceProtocol {
    lazy var places = [Place]()
    init() {
        places.append(Place(title: "Title Testing 1", address: "111 Truong Sa"))
        places.append(Place(title: "Title Testing 2", address: "111 Truong Sa"))
        places.append(Place(title: "Title Testing 3", address: "111 Truong Sa"))
        places.append(Place(title: "Title Testing 4", address: "111 Truong Sa"))
    }
    func getCurrentPlaces() -> Observable<[Place]> {
        return Observable.just(places)
    }
    
    func getPlaces(with query: String) -> Observable<[Place]> {
        return Observable.just(places)
    }
}
