//
//  LoginSucceedView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct LoginSucceedView: View {
    
    @Binding var authenticationDidSucceed: Bool
    
    var body: some View {
        if authenticationDidSucceed {
            Text("Login succeeded!")
                .font(.headline)
                .frame(width: 250, height: 80)
                .background(Color.green)
                .cornerRadius(20)
                .foregroundColor(.white)
                .animation(Animation.default, value: 1)
        }
    }
}

struct LoginSucceedView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSucceedView(authenticationDidSucceed: .constant(true))
    }
}
