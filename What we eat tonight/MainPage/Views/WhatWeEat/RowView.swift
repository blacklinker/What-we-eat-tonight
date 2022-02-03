//
//  RowView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI
import Firebase

struct RowView: View {
    let name: String
    let imageUrl : String
    
    init(name: String = "Can't find recipe", imageUrl: String = "wrong"){
        self.name = name
        self.imageUrl = imageUrl
    }
    
    var body: some View {
        HStack(alignment: .center){
            AsyncImage(url: URL(string: imageUrl),
                       transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .transition(.scale(scale: 0.1, anchor: .center))
                case .failure:
                    Image(uiImage: UIImage(named: "CantFindImage.jpg")!)
                @unknown default:
                    EmptyView()
                }
            }.cornerRadius(20)
            .frame(width: 100, height: 100, alignment: .center).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
            Text(self.name)
            Spacer()
        }.padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}
