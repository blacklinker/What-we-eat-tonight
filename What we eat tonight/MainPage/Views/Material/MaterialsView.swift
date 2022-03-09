//
//  MaterialsView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-13.
//

import SwiftUI

struct MaterialsView: View {
    @EnvironmentObject var mainRecipeVM : MainRecipeViewModel
    
    var body: some View {
        NavigationView{
            List{
                ForEach(mainRecipeVM.mainRecipeMaterial, id: \.id){ material in
                    MaterialRowView(material: material)
                }
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) { // <3>
                        VStack {
                            Text("Material Needed").font(.headline)
                            Text("Material quantity will be removed ").font(.system(size: 12)).foregroundColor(.red)
                            Text("at next day 4:00 am").font(.system(size: 12)).foregroundColor(.red)
                            HStack{
                                Text("*").foregroundColor(.red).font(.system(size: 20))
                                Text("Quantity not enought in stock").font(.system(size: 12))
                            }
                            
                        }
                    }
                }
        }
        
    }
}
