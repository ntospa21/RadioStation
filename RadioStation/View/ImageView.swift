//
//  ImageView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 28/9/24.
//

import SwiftUI

struct ImageView: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .fill(Color.gray)
                .frame(width: 50, height: 50)
        }
    }
}


struct ImageView2: View {
    @State var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
                .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
