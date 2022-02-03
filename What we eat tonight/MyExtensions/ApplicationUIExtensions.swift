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
    @Binding var myView: MyViews
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    BottomNav(myView: $myView)
                }
            }
    }
}

struct TopNavBarStyle: ViewModifier{
    var isSeleced: Bool
    func body(content: Content) -> some View {
        if isSeleced{
            content
                .padding(7)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(25)
        }else{
            content
                .padding(7)
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
            .background(configuration.isPressed ? buttonColor.opacity(1.2): buttonColor)
            .cornerRadius(15)
    }
    
    var buttonColor: Color {
        validated ? .green : .gray
    }
}

extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

struct TextModifier: ViewModifier{
    var backgroundColor: Color
    init(_ backgroundColor: Color){
        self.backgroundColor = backgroundColor
    }
    func body(content: Content) -> some View {
        content
            .frame(width: 64, height: 20)
            .padding(.leading, 13)
            .padding(.trailing, 13)
            .padding(.top, 7)
            .padding(.bottom, 7)
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(15)
    }
}
