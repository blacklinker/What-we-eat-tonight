//
//  ApplicationUIExtensions.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import Foundation
import UIKit
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct AppendNavBar: ViewModifier {
    //@Binding var hideBotNav: Bool
    @Binding var myView: MyViews
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .bottomBar){
//                    if(hideBotNav){
//
//                    }else{
                        BottomNav(myView: $myView)
                    //}
                    
                }
            }
    }
}

struct MyButtonStyle: ButtonStyle{
    let validated: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12))
                .frame(height: 20)
                .padding(10)
                .foregroundColor(.white)
                .background(buttonColor)
                .cornerRadius(15)
                .disabled(!validated)
    }
    
    var buttonColor: Color {
        validated ? .green : .gray
    }
}
