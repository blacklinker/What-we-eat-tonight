//
//  AddNewView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct AddScreen: View {
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(destination: NewRecipe()){
                    HStack{
                        Text("Recipes").font(.system(size: 15))
                    }.padding()
                }
                NavigationLink(destination:  NewMaterial()){
                    HStack{
                        Text("Material").font(.system(size: 15))
                    }.padding()
                }
            }
           .navigationBarTitle("Add", displayMode: .inline)
        }
    }
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            AddScreen()
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
            //                .previewDevice("iPhone 11")
            //                .previewDevice("iPhone 12")
            //                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
