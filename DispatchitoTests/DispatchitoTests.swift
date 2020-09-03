//
//  DispatchitoTests.swift
//  DispatchitoTests
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

import XCTest
@testable import Dispatchito

class DispatchitoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDispatcherEnqueue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dispatcher = SerialDispatcher()
        dispatcher.enqueue(item: MockDispatchable())
        dispatcher.enqueue(item: MockDispatchable())
        dispatcher.enqueue(item: MockDispatchable())
        dispatcher.enqueue(item: MockDispatchable())
        XCTAssert(dispatcher.count() == 4)
        
        dispatcher.clear()
        XCTAssert(dispatcher.count() == 0)
    }

    func testDispatcherCount() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dispatcher = SerialDispatcher()
        XCTAssert(dispatcher.count() == 0)
        dispatcher.enqueue(item: MockDispatchable())
        XCTAssert(dispatcher.count() == 1)
        dispatcher.enqueue(item: MockDispatchable())
        XCTAssert(dispatcher.count() == 2)
        dispatcher.enqueue(item: MockDispatchable())
        XCTAssert(dispatcher.count() == 3)
        dispatcher.clear()
        XCTAssert(dispatcher.count() == 0)
    }
    

}
