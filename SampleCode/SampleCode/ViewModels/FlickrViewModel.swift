//
//  FlickrViewModel.swift
//  SampleCode
//
//  Created by Mounik Yelakanti on 2/19/24.
//

import Combine
import Foundation

class FlickrViewModel: ObservableObject {
    @Published var images = [FlickrImage]()
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()

    func searchImages(with tag: String) {
        isLoading = true
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tag)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: FlickrResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    print("Error decoding JSON: \(error)")
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] flickrResponse in
                self?.images = flickrResponse.items
            })
            .store(in: &cancellables)
    }
}

