//
//  SleeperDreamTestCase.swift
//  IntroUnitTestTests
//
//  Created by Matheus de Vasconcelos on 01/06/20.
//  Copyright © 2020 MDEV. All rights reserved.
//

import XCTest
@testable import IntroUnitTest

class SleeperDreamTestCase: XCTestCase {

    var sut: Sleeper!

    override func setUp() {
        super.setUp()
        sut = Sleeper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDream() {
        self.measure {
            sut.dream()
        }
    }

}
