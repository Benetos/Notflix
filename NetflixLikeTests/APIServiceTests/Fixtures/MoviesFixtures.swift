//
//  MoviesFixtures.swift
//  NetflixLikeTests
//
//  Created by Quentin Eude on 18/02/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import XCTest

@testable import NetflixLike
extension NetflixLikeTests {
    func anyMovie() -> Movie {
        var movies: [Movie] = []

        let publisher = APIClient().send(GetTopRatedMovies())

        XCTAssertNotNil(publisher)

        let expectationFinished = XCTestExpectation(description: "finished")
        let expectationReceive = XCTestExpectation(description: "receiveValue")
        let expectationFailure = XCTestExpectation(description: "failure")
        expectationFailure.isInverted = true

        let cancellable = publisher.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            XCTAssertGreaterThan(response.results.count, 0)
            movies = response.results
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)

        return movies.first!
    }
}