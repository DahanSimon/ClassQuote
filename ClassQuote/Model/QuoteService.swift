//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Simon Dahan on 14/09/2020.
//  Copyright © 2020 Simon Dahan. All rights reserved.
//

import Foundation

class QuoteService {
    private static let quoteUrl = URL(string: "https://api.forismatic.com/api/1.0/")!
    
    static func getQuote() {
        var request = URLRequest(url: quoteUrl)
        request.httpMethod = "POST"
        
        let body = "method=getQuote&format=json&lang=en"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil{
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data){
                        let text = responseJSON["quoteText"]
                        let author = responseJSON["quoteAuthor"]
                        print(text,author)
                    }
                }
            }
        }
        task.resume()
    }
}
