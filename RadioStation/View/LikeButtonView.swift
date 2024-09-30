//
//  LikeButtonView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 29/9/24.
//

import SwiftUI

//struct LikeButtonView: View {
//    let radio: RadioStationElement  // The radio station associated with the button
//    @State private var isLiked: Bool  // Local state for button appearance
//
//    @State private var tapCount = UserDefaults.standard.object(forKey: "")
//
////    init(favourites: Favourites, radio: RadioStationElement) {
////        self.favourites = favourites
////        self.radio = radio
////        self._isLiked = State(initialValue: favourites.contains(radio))  // Initialize the liked state based on Favourites
////    }
//
//    var body: some View {
//        Button(action: {
//            isLiked.toggle()
//            if radio.isLiked {
//                
//                
//            
//                
//            } else {
//            }
//        }) {
//            Image(systemName: isLiked ? "heart.fill" : "heart")
//                .resizable()
//                .frame(width: 24, height: 24)
//                .foregroundColor(isLiked ? .red : .primary)  // Red if liked, primary color if not
//        }
//        .padding(20)
//    }
//}
//
//
