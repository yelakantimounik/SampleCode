//
//  ContentView.swift
//  SampleCode
//
//  Created by Mounik Yelakanti on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FlickrViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.images) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        ImageRowView(image: image)
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                viewModel.searchImages(with: newValue)
            }
            .navigationTitle("Flickr Search")
            .refreshable {
                viewModel.searchImages(with: searchText)
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black.opacity(0.4))
                            .edgesIgnoringSafeArea(.all)
                    }
                }, alignment: .center
            )
        }
    }
}

#Preview {
    ContentView()
}
