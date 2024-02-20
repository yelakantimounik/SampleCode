//
//  HtmlView.swift
//  SampleCode
//
//  Created by Mounik Yelakanti on 2/19/24.
//

import Foundation
import UIKit
import WebKit
import SwiftUI

struct HtmlView: UIViewRepresentable {
    
    let htmlString:String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
    
}
