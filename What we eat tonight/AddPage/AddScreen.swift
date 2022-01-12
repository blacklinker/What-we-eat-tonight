//
//  AddNewView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct AddScreen: View {
    
    //@Binding var hideBotNav: Bool
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(destination: NewRecipe()){
                    HStack{
                        Text("菜谱").font(.system(size: 15))
                    }.padding()
                }
                NavigationLink(destination:  NewMaterial()){
                    HStack{
                        Text("材料").font(.system(size: 15))
                    }.padding()
                }
            }
           .navigationBarTitle("添加", displayMode: .inline)
        }
    }
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddScreen()
    }
}
