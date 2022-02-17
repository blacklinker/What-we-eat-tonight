//
//  AddButtonView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-16.
//

import SwiftUI

struct AddButtonView: View {
    @Binding var toggleVar: Bool
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    self.toggleVar.toggle()
                }){
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }.padding()
            }
            .padding(.bottom)
        }.zIndex(2)
    }
}
