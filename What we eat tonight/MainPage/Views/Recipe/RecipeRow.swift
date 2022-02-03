//
//  RecipeRow.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-31.
//

import SwiftUI

struct RecipeRow: View {
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
            Button(action: {}){
                Text("Eat Today")
                    .frame(height: 20)
                    .padding(.leading, 18)
                    .padding(.trailing, 18)
                    .padding(.top, 7)
                    .padding(.bottom, 7)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(15)
            }
        }.padding()
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow()
    }
}
