//
//  ProfilePictureView.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-16.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilePictureView: View {
    @State var url: String?
    var width: CGFloat?
    var height: CGFloat?

    var body: some View {
        VStack {
            WebImage(url: URL(string: url ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"), options: [], context: [.imageThumbnailPixelSize : CGSize.zero])
                .placeholder {ProgressView()}
                .resizable()
                .frame(width: width ?? 50, height: height ?? 50)
                .clipShape(Circle())
        }
    }
}

struct ProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureView()
    }
}
