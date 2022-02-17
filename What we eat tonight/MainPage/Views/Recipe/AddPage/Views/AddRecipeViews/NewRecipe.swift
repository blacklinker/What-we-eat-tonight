//
//  NewRecipe.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct NewRecipe: View {
    @StateObject var addRecipeVM: AddRecipeViewModel
    @State var ifAdd: Bool = false
    @State var addMaterial = false
    
    init(recipe: Recipe? = nil){
        if recipe != nil{
            self._addRecipeVM = StateObject(wrappedValue: AddRecipeViewModel(recipe!))
        } else {
            self._addRecipeVM = StateObject(wrappedValue: AddRecipeViewModel())
        }
    }
    
    var body: some View {
        ZStack {
            ZStack{
                VStack(alignment: .leading){
                    AddRecipeTop(ifAdd: $ifAdd).environmentObject(addRecipeVM)
                        .padding()
                    List{
                        Section(header: Text("Material")) {
                            ForEach(addRecipeVM.allMaterialList){ material in
                                NavigationLink(destination: AddRecipeMaterialView(material: material, qty: material.qty    ).environmentObject(addRecipeVM)) {
                                    HStack{
                                        Text(material.name)
                                        Spacer()
                                        if material.qty > 0{
                                            Text("\(material.qty)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }.zIndex(1)
                AddButtonView(toggleVar: $addMaterial)
            }
            .font(.system(size: 14))
            .zIndex(1)
            .background(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73).opacity(0.5))
            .disabled(addRecipeVM.state == .loading)
            .sheet(isPresented: $addMaterial, onDismiss: { self.addRecipeVM.getAllMaterial() }){
                NavigationView{
                    MaterialView()
                        .navigationBarTitle("")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    self.addMaterial = false
                                }
                            }
                        })
                }
                
            }
            
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
                                addRecipeVM.image = nil
                                addRecipeVM.recipe.name = ""
                            }
                        }
                    }
            }
            if ifAdd {
                AddNewToolbar(selectedImage: $addRecipeVM.image, ifAdd: $ifAdd)
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle("Recipe")
    }
}
