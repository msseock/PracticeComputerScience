//
//  ListRowView.swift
//  Apple
//
//  Created by 석민솔 on 9/13/25.
//

import SwiftUI

struct ListRowView: View {
    let user: User

    var body: some View {
        HStack {
            if let imgData = user.imageData,
               let uiImage = UIImage(data: imgData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 40)
            } else {
                Image("brainstop")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 40)
            }
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                
                Text("\(user.age)살")
                    .font(.caption)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    ListRowView(user: .init(id: 0, name: "홍길동", age: 30, img: nil))
}
