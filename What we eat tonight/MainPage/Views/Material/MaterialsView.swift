//
//  MaterialsView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-13.
//

import SwiftUI

struct MaterialsView: View {
    @EnvironmentObject var recipeVM : RecipeViewModel
    
    var body: some View {
        NavigationView{
            switch recipeVM.state{
            case .success:
                List{
                    ForEach(recipeVM.todayRecipeMaterial, id: \.self){ material in
                        Text(material)
                    }
                }.navigationBarTitle("Material Needed", displayMode: .inline)
                .background(.white)
            case .loading:
                ProgressView().padding()
            default:
                Text("Something went wrong.")
            }
        }
        .task{
            await recipeVM.getTodayRecipeMaterial()
        }
    }
}

struct MaterialsView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsView()
    }
}
