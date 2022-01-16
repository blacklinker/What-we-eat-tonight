//
//  ContentView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-04.
//

import SwiftUI

struct ContentView: View {
    @State var myView: MyViews = .main

    var body: some View {
        MainScreen(myView: $myView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
