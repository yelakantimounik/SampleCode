//
//  ImageDetailView.swift
//  SampleCode
//
//  Created by Mounik Yelakanti on 2/19/24.
//

import SwiftUI

struct ImageDetailView: View {
    let image: FlickrImage

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image.media.m)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            Text(image.title)
                .font(.largeTitle)
            HtmlView(htmlString: image.description)
                .font(.body)
            Text("Author: \(image.author)")
                .font(.body)
            Text("Published Date: \(image.published)")
                .font(.body)
        }
        .padding()
        .navigationTitle(image.title)
    }
}
