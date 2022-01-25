//
//  ImageView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import SwiftUI

struct ImageView: View {
    
    var selectedImage: UIImage?
    
    var body: some View {
        if(selectedImage == nil){
            Image(systemName: "camera")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30, alignment: .center)
                .padding(10)
                .background(.white)
                .cornerRadius(15)
        }
        else{
            Image(uiImage: selectedImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .center)
                .background(.white)
                .cornerRadius(15)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
