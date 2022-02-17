//
//  ImageView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import SwiftUI

struct ImageView: View {
    var selectedImage: UIImage?
    var imageUrl: String
    
    init(selectedImage: UIImage? = nil, imageUrl: String = ""){
        self.selectedImage = selectedImage
        self.imageUrl = imageUrl
    }
    
    var body: some View {
        if imageUrl.isEmpty{
            if(selectedImage == nil){
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
            } else {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120, alignment: .center)
                    .background(.white)
                    .cornerRadius(15)
            }
        } else {
            AsyncImage(url: URL(string: imageUrl),
                       transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120, alignment: .center)
                        .background(.white)
                        .cornerRadius(15)
                case .failure:
                    Image(uiImage: UIImage(named: "CantFindImage.jpg")!)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
