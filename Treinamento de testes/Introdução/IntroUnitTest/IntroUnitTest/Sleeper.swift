//
//  Sleeper.swift
//  IntroUnitTest
//
//  Created by Matheus de Vasconcelos on 01/06/20.
//  Copyright © 2020 MDEV. All rights reserved.
//

import Foundation

class Sleeper {

    var time = 22

    func prepare() -> Bool {
        return time > 21
    }

    func dream() {
        sleep(2)
    }

}
