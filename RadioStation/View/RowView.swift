//
//  RowView.swift
//  RadioStation
//
//  Created by Pantos, Thomas on 29/9/24.
//

import SwiftUI

struct RowView: View {
    let radio: RadioStationElement
    var body: some View {
      
            
            let url = URL(string: radio.logo)
            ImageView(url: url)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text("\(radio.title)")
                .padding()
                .font(.title)
            
        }
        
    }


