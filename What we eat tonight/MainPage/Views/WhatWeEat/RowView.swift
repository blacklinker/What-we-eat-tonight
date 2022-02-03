//
//  RowView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI
import Firebase

struct RowView: View {
    @EnvironmentObject var recipeVM: RecipeViewModel
    let recipe: Recipe
    @State var showMaterial: Bool = false
    
    init(recipe: Recipe){
        self.recipe = recipe
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .center){
                HStack{
                    AsyncImage(url: URL(string: recipe.imageUrl),
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
                    Text(recipe.name)
                    Spacer()
                }.onTapGesture {
                    withAnimation {
                        self.showMaterial.toggle()
                    }
                }
                Button(action: {
                    Task {
                        await recipeVM.removeEatToday(recipeId: recipe.id ?? "")
                    }
                }){
                    Text("Remove")
                        .modifier(TextModifier(.red))
                }
            }
            if showMaterial{
                VStack(alignment: .leading){
                    ForEach(recipe.material){ material in
                        Text(material.name)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
            }
        }.padding()
    }
}

struct RowViewPreview: PreviewProvider{
    static var previews: some View{
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            RowView(recipe: Recipe(id: "", name: "Test a super long long long name",
                                   imageUrl: "sdfd", material: [ RecipeMaterial(id: "", name: "material1"),
                                                             RecipeMaterial(id: "", name: "material2"),
                                                             RecipeMaterial(id: "", name: "maerial3")]))
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
            //                .previewDevice("iPhone 11")
                .previewDevice("iPhone 12")
            //                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
