//
//  ContentView.swift
//  FileUploadInFireStore
//
//  Created by Knoxpo MacBook Pro on 12/01/21.
//

import SwiftUI
import FirebaseStorage
import MobileCoreServices

struct ContentView: View {
    
    @State var isShown = false

    @State var showsAlert = false
    @State public var errorDesption: String?
     @State var bgImage: UIImageView?
    @State var image : UIImage?
    
    var imgeurl : String
    var alertTitle: String
    {
        
        errorDesption != nil ? "photo upload error" : "photo upload successfully"
        
    }
    
    var alertMessage: String
    {
        if let error = errorDesption
        {
            return error
            
        }
        return "Photo uploaded"
    }
    
    var body: some View {
        
        
        VStack {
       
            
          //  downloadIMAGE()
            FBURLImage(url: imgeurl)
            
           
        Button(action: { self.isShown.toggle()
            self.showsAlert = true
          // uploasdVedio()
          //  Image(uiImage: UIImage(named: I)!)  
        })
            {
            
            Text("Upload Image")
            
            
            
                /*.alert(isPresented: $showsAlert){
                    Alert (title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Dismiss")))
                    
                    
                }*/
        }
        
        .sheet(isPresented: $isShown){
            ImagePickerView(isShow: self.$isShown)
                
        }
//        .alert(isPresented: $showsAlert){
//            Alert (title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Dismiss")))
            
        }
        //}
    }
    
    
    
    func uploasdVedio()
    {
        
        
        let localFile = URL(string: "https://www.youtube.com/watch?v=zWh3CShX_do")!
        let storref = Storage.storage().reference().child("video")
        
        storref.putFile(from: localFile, metadata: nil){ metadata,error in
            
            if let error = error{
                //handel error
               print(" errror is,\(error.localizedDescription)")
                
            }
            
            
            
            
        }
        
    }
    
    
   
        func upladimageOnCloude()
        {
           var storageref = Storage.storage().reference()
           
           
         if  let image = UIImage(named: "VID-20200807-WA0004.mp4"){
               
           let data = image.pngData()
           print("data \(String(describing: data)))")
           
           
           let metadata = StorageMetadata()
           
           metadata.contentType = "images/png"
           storageref = storageref.child("images/1.png")
           let uploadTask = storageref.putData(data!, metadata: metadata)
           
           //let urrl = metadata?.downloadURL()?.absoluteString!
           
           
           
           //get downloadurl of image which upload in firebase
           storageref.downloadURL(completion: { (url, error) in
                                           let uploadedImageURL = url?.absoluteString
               print(uploadedImageURL!)
               
               
               
               
               
           })
                                   
                                   // Get the image url and assign to photoUrl for the current user and update
           
           
           
           
          
           
           uploadTask.observe(.resume) { snapshot in
           }
           uploadTask.observe(.pause) { snapshot in
               
               
           }
           uploadTask.observe(.progress) { snapshot in
               let  precentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
               
               print("uplad percentage = \(precentComplete)")
               
               uploadTask.observe(.success) { snapshot in
                   
                   print("image upladed sucessfully")
             
                   
                   
                   
               }
               uploadTask.observe(.failure) { snapshot in
                   
                   
                   if  let  error = snapshot.error as NSError? {
                       
                       switch(StorageErrorCode(rawValue: error.code))
                       {
                       
                       case .unauthorized:
                           break
                       
                       case .invalidArgument:
                           break
                           
                       case .unknown:
                           break
                       
                       case .cancelled:
                           break
                           
                       default:
                           break
                           
                       
                       
                       }
                       
                       
                       
                       
                       
                   }
                   
                   
                   
                   
                   
                   
                   
               }
               
               
               
               
               
           }
           
               
               
               
               
               
           }
           
           
           
           
           
           
           }
           
           
        
        
    }
    
    
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imgeurl: "nbbj")
    }
}


struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isShow: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController{
        
        
        let imageview = UIImagePickerController()
        imageview.delegate = context.coordinator
        imageview.sourceType = .photoLibrary
        imageview.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]

        return imageview
        
        
    }
  
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
    
    func makeCoordinator() -> Coordinator
    {
        return Coordinator(imagePicker: self)
    }
    
    
}

extension ImagePickerView
{
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate
    {
        var imagePicker: ImagePickerView
        init(imagePicker: ImagePickerView){
            
            self.imagePicker = imagePicker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePicker.isShow.toggle()
            
        }
        
       
    
        
       
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage,

                  let data = image.jpegData(compressionQuality: 0.4)  else { return }

            let storage = Storage.storage()

            storage.reference().child("temp")
                .putData(data, metadata: nil) { (_, error) in

                    if error != nil
                    {
                        print(error?.localizedDescription)

                        DispatchQueue.main.async {


                        }
                        return

                    }

                    print("upload successfully")
                  }
                }
              
        
        

            
            
                
                
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    

