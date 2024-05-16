//
//  SportSpotTests.swift
//  SportSpotTests
//
//  Created by Aser Eid on 27/04/2024.
//

import XCTest
@testable import SportSpot

class NetworkServiceTests: XCTestCase {

    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testFetchData() {

        let sportType: SportType = .football
        let methodName: MethodName = .Leagues
        let id: Int? = nil
        
        let expectation = XCTestExpectation(description: "Fetch Data From API")

        networkService.fetchData(sportType: sportType, methodName: methodName) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchCountries() {
        let methodName: MethodName = .Countries
        
        let expectation = XCTestExpectation(description: "Fetch Countries From API")

        networkService.fetchData(sportType: .football, methodName: methodName) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")

            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchLeagues() {
        let methodName: MethodName = .Leagues
        
        let expectation = XCTestExpectation(description: "Fetch Leagues From API")

        networkService.fetchData(sportType: .football, methodName: methodName) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")

            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchFixtures() {
        let methodName: MethodName = .Fixtures
        let fromDate = "2021-05-18"
        let toDate = "2021-05-18"
        
        let expectation = XCTestExpectation(description: "Fetch Fixtures From API")

        networkService.fetchData(sportType: .football, methodName: methodName, fromDate: fromDate, toDate: toDate) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")

            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
