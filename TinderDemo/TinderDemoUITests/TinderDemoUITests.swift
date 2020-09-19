//
//  TinderDemoUITests.swift
//  TinderDemoUITests
//
//  Created by macOS on 9/16/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import XCTest

class TinderDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["loadMoreButtonTop"].exists)
        XCTAssertTrue(app.buttons["favButton"].exists)
        XCTAssertTrue(app.otherElements["viewContainer"].exists)
        XCTAssertTrue(app.images["avatar"].waitForExistence(timeout: 90))
        XCTAssertTrue(app.staticTexts["myNameIs"].exists)
        XCTAssertTrue(app.staticTexts["fullName"].exists)
        
        let tabBarsQuery = app.otherElements["viewContainer"].children(matching: .other).element.children(matching: .other).element(boundBy: 2).tabBars
        XCTAssertTrue(tabBarsQuery.children(matching: .button).element(boundBy: 0).exists)
        XCTAssertTrue(tabBarsQuery.children(matching: .button).element(boundBy: 1).exists)
        XCTAssertTrue(tabBarsQuery.children(matching: .button).element(boundBy: 2).exists)
        XCTAssertTrue(tabBarsQuery.children(matching: .button).element(boundBy: 3).exists)
        XCTAssertTrue(tabBarsQuery.children(matching: .button).element(boundBy: 4).exists)
    }
    
    func testCalendarScreen() throws {
        let app = XCUIApplication()
        app.launch()
        let tabBarsQuery = app.otherElements["viewContainer"].children(matching: .other).element.children(matching: .other).element(boundBy: 2).tabBars
        let _ = app.images["avatar"].waitForExistence(timeout: 90)
        tabBarsQuery.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts["myBirthdayIs"].exists)
        XCTAssertTrue(app.otherElements["myCalendar"].exists)
    }
    
    func testMapScreen() throws {
        let app = XCUIApplication()
        app.launch()
        let tabBarsQuery = app.otherElements["viewContainer"].children(matching: .other).element.children(matching: .other).element(boundBy: 2).tabBars
        let _ = app.images["avatar"].waitForExistence(timeout: 90)
        tabBarsQuery.buttons.element(boundBy: 2).tap()
        XCTAssertTrue(app.otherElements["myMapView"].waitForExistence(timeout: 90))
    }
    
    func testPhoneScreen() throws {
        let app = XCUIApplication()
        app.launch()
        let tabBarsQuery = app.otherElements["viewContainer"].children(matching: .other).element.children(matching: .other).element(boundBy: 2).tabBars
        let _ = app.images["avatar"].waitForExistence(timeout: 90)
        tabBarsQuery.buttons.element(boundBy: 3).tap()
        
        XCTAssertTrue(app.staticTexts["myPhoneIs"].exists)
        XCTAssertTrue(app.buttons["phoneButton"].exists)
    }
    
    func testLockScreen() throws {
        let app = XCUIApplication()
        app.launch()
        let tabBarsQuery = app.otherElements["viewContainer"].children(matching: .other).element.children(matching: .other).element(boundBy: 2).tabBars
        let _ = app.images["avatar"].waitForExistence(timeout: 90)
        tabBarsQuery.buttons.element(boundBy: 4).tap()
        
        XCTAssertTrue(app.staticTexts["myCellPhoneIs"].exists)
        XCTAssertTrue(app.buttons["cellPhoneButton"].exists)
    }
    
    func testSwipeRight() throws {
        let app = XCUIApplication()
        app.launch()
        
        let viewContainer = app.otherElements["viewContainer"]
        XCTAssertTrue(app.staticTexts["fullName"].waitForExistence(timeout: 90))
        let fullNameQuery = app.staticTexts.matching(identifier: "fullName")
        let topName = fullNameQuery.element(boundBy: 2).label
        viewContainer.swipeRight()
        let secondName = fullNameQuery.element(boundBy: 2).label
        XCTAssertTrue(topName != secondName)
    }
    
    func testSwipeLeft() throws {
        let app = XCUIApplication()
        app.launch()
        
        let viewContainer = app.otherElements["viewContainer"]
        XCTAssertTrue(app.staticTexts["fullName"].waitForExistence(timeout: 90))
        let fullNameQuery = app.staticTexts.matching(identifier: "fullName")
        let topName = fullNameQuery.element(boundBy: 2).label
        viewContainer.swipeLeft()
        let secondName = fullNameQuery.element(boundBy: 2).label
        XCTAssertTrue(topName != secondName)
    }
    
    func testLoadMore() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.staticTexts["fullName"].waitForExistence(timeout: 90))
        let fullNameQuery = app.staticTexts.matching(identifier: "fullName")
        let topName = fullNameQuery.element(boundBy: 2).label
        app.buttons["loadMoreButtonTop"].firstMatch.tap()
        sleep(2)
        XCTAssertTrue(app.staticTexts["fullName"].waitForExistence(timeout: 90))
        let secondName = fullNameQuery.element(boundBy: 2).label
        XCTAssertTrue(topName != secondName)
    }
    
    func testFavorite() throws {
        let app = XCUIApplication()
        app.launch()
        let viewContainer = app.otherElements["viewContainer"]
        app.buttons["favButton"].firstMatch.tap()
        if app.alerts.element.staticTexts["You don't have favorited data now"].exists {
            app.alerts.buttons["OK"].tap()
        } else {
            while(app.staticTexts["fullName"].exists) {
                viewContainer.swipeLeft()
                sleep(1)
            }
        }
        
        app.buttons["loadMoreButtonTop"].firstMatch.tap()
        sleep(2)
        XCTAssertTrue(app.staticTexts["fullName"].waitForExistence(timeout: 90))
        viewContainer.swipeRight()
        sleep(1)
        viewContainer.swipeRight()
        sleep(1)
        viewContainer.swipeRight()
        XCTAssertTrue(app.staticTexts["fullName"].waitForExistence(timeout: 90))
        XCTAssertEqual(app.staticTexts.matching(identifier: "fullName").count, 3)
        let fullNameQuery = app.staticTexts.matching(identifier: "fullName")
        let topName = fullNameQuery.element(boundBy: 2).label
        app.buttons["favButton"].firstMatch.tap()
        sleep(2)
        XCTAssertTrue(app.staticTexts["fullName"].waitForExistence(timeout: 90))
        let secondName = fullNameQuery.element(boundBy: 2).label
        XCTAssertTrue(topName != secondName)
        app.buttons["favButton"].firstMatch.tap()
        while(app.staticTexts["fullName"].exists) {
            viewContainer.swipeLeft()
            sleep(1)
        }
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
