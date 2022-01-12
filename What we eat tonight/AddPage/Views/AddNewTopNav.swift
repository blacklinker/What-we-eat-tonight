//
//  AddNewTopNav.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct AddNewTopNav: View {
    var body: some View {
        HStack{
            Text("")
            Spacer()
            Button(action: { print("save") }){
                Text("保存")
            }.font(.system(size: 12))
                .frame(height: 20)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 5)
                .padding(.bottom, 5)
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(15)
        }.padding()
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct AddNewTopNav_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTopNav()
    }
}
