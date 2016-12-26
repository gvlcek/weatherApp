//
//  BlueTrailTestTests.swift
//  BlueTrailTestTests
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import XCTest
@testable import BlueTrailTest

class BlueTrailTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMetric() {
        let e = expectation(description: "fetch weather")
        let ws: WeatherService = OpenWeatherMapService()
        ws.fetchWeather(city: "buenos aires", units: .metric) { result in
            e.fulfill()
            XCTAssert(result != nil)
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testImperial() {
        let e = expectation(description: "fetch weather imperial")
        let ws: WeatherService = OpenWeatherMapService()
        ws.fetchWeather(city: "buenos aires", units: .imperial) { result in
            e.fulfill()
            XCTAssert(result != nil)

        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    private func testEquality(_ a: Double, _ b: Double, _ epsilon: Double = DBL_EPSILON) -> Bool {
        return (a - b) <= epsilon
    }

    func testConversions() {
        XCTAssert(testEquality(32.0,0.0.convertToFahrenheit()))
        XCTAssert(testEquality(0.0, 32.0.convertToCelsius()))
        XCTAssert(testEquality(212.0, 100.0.convertToFahrenheit()))
        XCTAssert(testEquality(100.0, 212.0.convertToCelsius()))
    }
}
