//
//  NewsArticle.swift
//  NewsTrack
//
//  Created by Vladislav Smetanin on 05.02.2022.
//

import Foundation


struct NewsArticle : Codable{
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var sourceName: String
    var viewsCounter: Int
    init(dictionary: Dictionary<String, Any>){
        author = dictionary["author"] as? String ?? "" // если будет nil то запишем пустоту (объединение с nil - 'nil coalscing')
        title = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        sourceName = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""]) as? String ?? ""
        viewsCounter = 0
    }
    
    mutating func changeViewsCounter(){ // изменяющий метод
        self.viewsCounter += 1
        print(self.viewsCounter)
    }
    
    mutating func showViewsCounter() -> Int{
        return self.viewsCounter
    }
    
}
