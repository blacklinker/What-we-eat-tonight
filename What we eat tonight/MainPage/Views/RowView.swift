//
//  RowView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI
import Firebase

struct RowView: View {
    var body: some View {
        HStack(alignment: .center){
            Image(uiImage: UIImage(named: "CantFindImage.jpg")!)
                .resizable()
                //.cornerRadius(20)
                .frame(width: 100, height: 100, alignment: .center).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
            Text("找不到菜谱")
            Spacer()
        }.padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}
