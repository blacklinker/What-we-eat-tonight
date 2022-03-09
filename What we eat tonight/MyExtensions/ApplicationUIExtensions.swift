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
            .padding(.leading, 7)
            .padding(.trailing, 7)
            .padding(.top, 4)
            .padding(.bottom, 4)
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

struct TextFieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .font(.system(size: 15))
            .frame(height: 30)
            .padding(.leading, 10)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73), lineWidth: 2)
            )
    }
}

struct LoginTextFieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct swipeActionModifier: ViewModifier{
    @Binding var activeView: SubViews
    @Binding var viewState: CGSize
    func body(content: Content) -> some View {
        content
            .gesture(
            (self.activeView == SubViews.eat) ?
            DragGesture().onChanged{ value in
                self.viewState = value.translation
            }.onEnded{ value in
                if value.predictedEndTranslation.width > screenWidth / 2 {
                    self.activeView = SubViews.recipe
                    self.viewState = .zero
                }else if value.predictedEndTranslation.width < -screenWidth / 2 {
                    self.activeView = SubViews.material
                    self.viewState = .zero
                }else {
                    self.viewState = .zero
                }
            }
            :DragGesture().onChanged{ value in
                switch self.activeView{
                case .recipe:
                    guard value.translation.width < 1 else { return }
                    self.viewState = value.translation
                case .material:
                    guard value.translation.width > 1 else { return }
                    self.viewState = value.translation
                case .eat :
                    self.viewState = value.translation
                }
            }.onEnded{ value in
                switch self.activeView{
                case .recipe:
                    if value.translation.width < -screenWidth / 2 {
                        self.activeView = .eat
                        self.viewState = .zero
                    } else {
                        self.viewState = .zero
                    }
                case .material:
                    if value.translation.width > screenWidth / 2 {
                        self.activeView = .eat
                        self.viewState = .zero
                    } else {
                        self.viewState = .zero
                    }
                case .eat :
                    self.viewState = .zero
                }
            }
        )
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
