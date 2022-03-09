//
//  NewRecipe.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct NewRecipe: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var addRecipeVM: AddRecipeViewModel
    @State var ifAdd: Bool = false
    @State var addMaterial = false
    let navigationTitle: String
    
    init(recipe: Recipe? = nil){
        if recipe != nil{
            self._addRecipeVM = StateObject(wrappedValue: AddRecipeViewModel(recipe!))
            self.navigationTitle = "Edit Recipe"
        } else {
            self._addRecipeVM = StateObject(wrappedValue: AddRecipeViewModel())
            self.navigationTitle = "Add Recipe"
        }
    }
    
    var body: some View {
        ZStack {
            ZStack{
                VStack(alignment: .leading){
                    AddRecipeTop(ifAdd: $ifAdd).environmentObject(addRecipeVM)
                    List{
                        Section(header: Text("Material")) {
                            ForEach(addRecipeVM.allMaterialList){ material in
                                NavigationLink(destination: AddRecipeMaterialView(material: material).environmentObject(addRecipeVM)) {
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
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
            if ifAdd {
                AddNewToolbar(selectedImage: $addRecipeVM.image, ifAdd: $ifAdd)
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
            }
        }.navigationTitle(self.navigationTitle)
    }
}

struct NewRecipe_Preview: PreviewProvider{
    static var previews: some View{
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            NewRecipe().environmentObject(AddRecipeViewModel())
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
