//
//  Model.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

class Feed {
    var items = [FeedItem]()
    
    init(json: [[String : Any]]) {
        
        for itemJson in json {
            var feedItem = FeedItem(json: itemJson)
            
            switch feedItem.type {
            case .joke:
                feedItem = Joke(json: itemJson)
            case .pun:
                feedItem = Pun(json: itemJson)
            case .joker:
                feedItem = Joker(json: itemJson)
            default:
                print("unhandled item type")
            }
            
            self.items.append(feedItem)
        }
    }
}

enum FeedItemType: String {
    case joker = "joker"
    case joke = "joke"
    case pun = "pun"
}

class FeedItem{
    var type: FeedItemType!
    
    init(json: [String : Any]) {
        guard let type = json["type"] as? String else {
            return
        }
        self.type = FeedItemType(rawValue: type)
    }
}

class Joker: FeedItem {
    
    var name: String!
    var liked: Bool = false
    var puns = [Pun]()
    var jokes = [Joke]()
    
    override init(json: [String : Any]) {
        super.init(json: json)

        guard let name = json["name"] as? String else {
            return
        }
        
        if let jokeDicts = json["jokes"] as? [[String : Any]] {
            for jokeDict in jokeDicts {
                self.jokes.append(Joke(json: jokeDict))
            }
        }
        
        if let punDicts = json["puns"] as? [[String : Any]] {
            for punDict in punDicts {
                self.puns.append(Pun(json: punDict))
            }
        }
        
        self.name = name
    }
    
    func performThank(complete:@escaping ((_ success: Bool)-> Void)) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            complete(true)
        }

    }
}

class Joke: FeedItem {
   
    var content: String!
    
    override init(json: [String : Any]) {
        super.init(json: json)
        
        guard let content = json["content"] as? String else {
            return
        }
        
        self.content = content
    }
    
}

class Pun: FeedItem {
    
    var content: String!
    
    override init(json: [String : Any]) {
        super.init(json: json)
        
        guard let content = json["content"] as? String else {
            return
        }
        
        self.content = content
    }
}
