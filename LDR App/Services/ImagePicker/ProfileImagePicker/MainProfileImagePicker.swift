import SwiftUI
   
   struct MainProfilePickerView: View {
       
       @State private var isShowingPhotoSelectionSheet = false

       @Binding var finalImage: UIImage?
       @State var inputImage: UIImage?
       
       var body: some View {
           
           VStack {
               
               if finalImage != nil {
                   Image(uiImage: finalImage!)
                       .resizable()
                       .frame(width: 100, height: 100)
                       .scaledToFill()
                       .aspectRatio(contentMode: .fit)
                       .clipShape(Circle())
                       .shadow(radius: 4)
               } else {
                   Image(systemName: "person.crop.circle.fill")
                       .resizable()
                       .scaledToFill()
                       .frame(width: 100, height: 100)
                       .aspectRatio(contentMode: .fit)
                       .foregroundColor(.gray)
               }
               Button (action: {
                   self.isShowingPhotoSelectionSheet = true
               }, label: {
                   Text("Change photo")
                       .foregroundColor(.red)
                       .font(.footnote)
               })
           }
           .background(.white)
           .statusBar(hidden: isShowingPhotoSelectionSheet)
           .fullScreenCover(isPresented: $isShowingPhotoSelectionSheet, onDismiss: loadImage) {
               ImageMoveAndScaleSheet(croppedImage: $finalImage)
           }
       }
       
       func loadImage() {
           guard let inputImage = inputImage else { return }
           finalImage = inputImage
       }
   }
   
   struct ContentView_Previews: PreviewProvider {
       static var previews: some View {
           @State var profilePic: UIImage? = nil
           MainProfilePickerView(finalImage: $profilePic)  
       }
   }
