//
//  kidsZooApp.swift
//  kidsZoo
//
//  Created by hachemibtb on 26/7/2026.
//

import SwiftUI

@main
struct kidsZooApp: App {
    //property
    @AppStorage("Paging") var paging:Int = 0
    init(){
        paging = 3
    }
    
    //body
    var body: some Scene {
        WindowGroup {
            if paging == 0 {
                loginView()
            } else if paging == 1 {
                signupView()
            } else {
                mainView()
            }
        }
    }
}
