//
//  kidsZooApp.swift
//  kidsZoo
//
//  Created by hachemibtb on 26/7/2026.
//

import SwiftUI

@main
struct kidsZooApp: App {
    init() {
        #if DEBUG
        Bundle(
            path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"
        )?.load()
        #endif
    }
    //body
    var body: some Scene {
        WindowGroup {
           mainView()
        }
    }
}
