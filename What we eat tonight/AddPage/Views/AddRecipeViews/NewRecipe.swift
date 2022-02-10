//
//  NewRecipe.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct NewRecipe: View {
    @StateObject var addRecipeVM: AddRecipeViewModel = AddRecipeViewModel()
    @State private var selectedImage: UIImage?
    @State var ifAdd: Bool = false
    @State var name = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                AddRecipeTop(name: $name, selectedImage: selectedImage, ifAdd: $ifAdd).environmentObject(addRecipeVM)
                    .padding()
                List{
                    Section(header: Text("Material")) {
                        ForEach(addRecipeVM.allMaterialList){ material in
                            NavigationLink(destination:  AddRecipeMaterialView(material: material, qty: material.qty    ).environmentObject(addRecipeVM)) {
                                HStack{
                                    Text(material.name)
                                    Spacer()
                                    if material.qty > 0{
                                        Text("\(material.qty)")
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.green)
                                            .shadow(radius: 1)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .font(.system(size: 14))
            .zIndex(1)
            .background(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73).opacity(0.5))
            .disabled(addRecipeVM.state == .loading)
            
            if addRecipeVM.state == .loading{
                ProgressView().zIndex(3)
            }
            if addRecipeVM.state == .saved{
                Text("Saved!").foregroundColor(.green)
                    .zIndex(3)
                    .transition(.move(edge: .top))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation{
                                addRecipeVM.state = .na
                                self.selectedImage = nil
                                self.name = ""
                            }
                        }
                    }
            }
            if ifAdd {
                AddNewToolbar(selectedImage: $selectedImage, ifAdd: $ifAdd)
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle("Recipe")
    }
}

struct NewRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            NewRecipe()
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
            //                .previewDevice("iPhone 11")
            //                .previewDevice("iPhone 12")
                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
