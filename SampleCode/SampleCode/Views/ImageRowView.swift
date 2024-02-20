//
//  ImageRowView.swift
//  SampleCode
//
//  Created by Mounik Yelakanti on 2/19/24.
//

import SwiftUI

struct ImageRowView: View {
    let image: FlickrImage

    var body: some View {
        HStack {
//            AsyncImage(
//                url: URL(string: image.media.m),
//                 content: { image in
//                       image.resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 100, height: 100)
//                 },
//                 placeholder: {
//                        ProgressView()
//                        .frame(width: 100, height: 100)
//            })
//            .fixedSize()
            AsyncImage(url: URL(string: image.media.m)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                case .failure:
                    Text("Failed to load image" + image.media.m)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width:  100, height:  100)
            VStack(alignment: .leading) {
                Text(image.title)
                    .font(.headline)
               // Text(image.description)
                    .font(.subheadline)
            }
        }
    }
}
