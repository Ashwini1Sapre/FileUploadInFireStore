//
//  FBURLImage.swift
//  FileUploadInFireStore
//
//  Created by Knoxpo MacBook Pro on 12/01/21.
//

import SwiftUI





struct FBURLImage: View {
    @ObservedObject var imageurl : ImageLoader
    
    init(url: String)
    {
        imageurl = ImageLoader()
        imageurl.loadImage(url: url)
        
    }
    var body: some View {
       Image(uiImage:
        imageurl.data != nil ? UIImage(data: imageurl.data!)! : UIImage())
        
        .resizable()
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 5.0 ))
        .background(Color.gray)
        
        
    }
}


