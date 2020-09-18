//
//  SleeperPrepareTestCase.swift
//  IntroUnitTestTests
//
//  Created by Matheus de Vasconcelos on 01/06/20.
//  Copyright © 2020 MDEV. All rights reserved.
//

import XCTest
@testable import IntroUnitTest

class SleeperPrepareTestCase: XCTestCase {

    var sut: Sleeper!

    override func setUp() {
        super.setUp()
        sut = Sleeper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testPrepareBeforeNight() {
        sut.time = 5

        XCTAssertFalse(sut.prepare())
    }

    func testPrepareAfterNight() {
        sut.time = 23

        XCTAssertTrue(sut.prepare())
    }

}

