//
//  FlickrImage.swift
//  SampleCode
//
//  Created by Mounik Yelakanti on 2/19/24.
//

import Foundation

//struct FlickrResponse: Decodable {
//    let items: [FlickrImage]
//}

struct FlickrResponse: Decodable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrImage]
}

struct FlickrImage: Decodable, Identifiable {
    let id = UUID().uuidString
    let title: String
    let link: String
    let media: FlickrMedia
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let author_id: String
    let tags: String

    struct FlickrMedia: Decodable {
        let m: String
    }
}
