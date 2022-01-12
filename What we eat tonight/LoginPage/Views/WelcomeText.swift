//
//  WelcomeText.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct WelcomeText: View {
    var body: some View {
        Text("Welcome")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct WelcomeText_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeText()
    }
}
