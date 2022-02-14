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
        GeometryReader{ bounds in
            NavigationView{
                List{
                    ForEach(mainRecipeVM.mainRecipeMaterial, id: \.id){ material in
                        MaterialRowView(material: material)
                    }
                }.navigationBarTitle("Material Needed", displayMode: .inline)
                    .background(.white)
            }
            .frame(width: bounds.size.width, height: bounds.size.height, alignment: .center)
        }
    }
}
