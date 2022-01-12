//
//  What_we_eat_tonightApp.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-04.
//

import SwiftUI
import Firebase

@main
struct What_we_eat_tonightApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
