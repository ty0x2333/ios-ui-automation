//
//  UITestUtils.swift
//  UIAutomationDemo
//
//  Created by ty0x2333 on 2018/12/21.
//  Copyright © 2018 ty0x2333. All rights reserved.
//

import Foundation

class UITestUtils {
    static var isTesting: Bool {
        #if DEBUG
        return UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT")
        #else
        return false
        #endif
    }
}
