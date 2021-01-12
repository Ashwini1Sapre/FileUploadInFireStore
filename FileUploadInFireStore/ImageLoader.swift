//
//  ImageLoader.swift
//  FileUploadInFireStore
//
//  Created by Knoxpo MacBook Pro on 12/01/21.
//

import SwiftUI
import Firebase
import FirebaseStorage


class ImageLoader: ObservableObject {
    
    @Published var data : Data?
    
    func loadImage(url: String)
    {
        let storeref = Storage.storage().reference(forURL: url)
        
         storeref.getData(maxSize: 5 * 1024 * 1024 ) { data, error in
            
           if let error = error
           {
            print("\(error)")
            
           }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.data = data
            }
            
            
            
        }
        
        
        
        
    }
    
    
    
}



