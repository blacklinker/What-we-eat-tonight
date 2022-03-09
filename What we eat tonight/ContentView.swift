//
//  ContentView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-04.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("Username") var email: String = AuthenticationService.shared.useremail
    @State var myView: MyViews = .main

    var body: some View {
        MainScreen(email, $myView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
