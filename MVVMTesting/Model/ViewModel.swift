//
//  ViewModel.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit


// MARK: Profile
enum ProfileSegmentNotation: Int {
    case jokes
    case puns
}

struct ProfileSegmentViewModel {
    let segmentNotation: ProfileSegmentNotation
    
    var text: String {
        switch segmentNotation {
        case .jokes: return "Jokes"
        case .puns: return "Puns"
        }
    }
}

enum ProfileSectionsViewModelType: Int {
    case profileHeader
    case profileFeed
    case count
}

class ProfileFeedViewModel: NSObject {
    var jokerProfile: Joker!
    var jokerViewModel: JokerCardViewModel!
    var jokersJokes = [JokeCardViewModel]()
    var jokerPuns = [PunCardViewModel]()
    var profileSegmentDataArray = [[FeedCardViewModel]]()
    var selectedSegmentIndex: Int = 0

    func heightForHeader(section: Int) -> CGFloat {
        if let sectionType = ProfileSectionsViewModelType(rawValue: section) {
            if sectionType == ProfileSectionsViewModelType.profileFeed {
                return 50
            }
        }
        return 0

    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        if let sectionType = ProfileSectionsViewModelType(rawValue: section) {
            switch sectionType {
                
            case .profileHeader:
                return 1
                
            case .profileFeed:
                let selectedArray = self.profileSegmentDataArray[self.selectedSegmentIndex]
                return selectedArray.count
                
            default:
                return 0
            }
        }
        return 0
    }
    
    func cellViewModelForIndexPath(indexPath: IndexPath) -> FeedCardViewModel? {
        var cellViewModel: FeedCardViewModel?

        if let sectionType = ProfileSectionsViewModelType(rawValue: indexPath.section) {
            switch sectionType {
                
            case .profileHeader:
                cellViewModel = self.jokerViewModel
                
            case .profileFeed:
                let selectedArray = self.profileSegmentDataArray[self.selectedSegmentIndex]
                cellViewModel = selectedArray[indexPath.row]
                
            default:
                ()
            }
        }
        return cellViewModel
        
    }
    
    override init() {
        super.init()
        self.jokerProfile = Joker(json: profileFeedData)
        self.jokerViewModel = JokerCardViewModel(joker:self.jokerProfile)
       
        for joke in self.jokerProfile.jokes {
            self.jokersJokes.append(JokeCardViewModel(content: joke.content))
        }
       
        for pun in self.jokerProfile.puns {
            self.jokerPuns.append(PunCardViewModel(content: pun.content))
        }
        
        self.profileSegmentDataArray.append(jokersJokes)
        self.profileSegmentDataArray.append(jokerPuns)
    }
}

// MARK: News Feed
class NewsFeedViewModel: NSObject {
    
    var numberOfItems : Int {
        return self.items.count
    }
    
    var items = [FeedCardViewModel]()
    
    override init() {
        super.init()
        let feed = Feed(json: newsFeedData)
        
        for feedItem in feed.items {
            switch feedItem.type {
            case .joker:
                let joker = feedItem as! Joker
                self.items.append(JokerCardViewModel(joker: joker))
            case .pun:
                let pun = feedItem as! Pun
                self.items.append(PunCardViewModel(content: pun.content))
            case .joke:
                let joke = feedItem as! Joke
                self.items.append(JokeCardViewModel(content: joke.content))
            default:
                print("unhandled case")
            }
        }
    }
}

// MARK: Cards
enum FeedViewModelCardType {
    case joke
    case pun
    case joker
}

protocol FeedCardViewModel {
    var type: FeedViewModelCardType { get }
    var cellID: String { get }
}

enum ThankedState {
    case stateKnown
    case stateChangeInProgress
}

class JokerCardViewModel : FeedCardViewModel {

    var joker: Joker
    var thankedState: ThankedState = .stateKnown
    var thanked: Bool = false
    var type: FeedViewModelCardType {
        return .joker
    }
    var cellID: String {
        return "jokerCell"
    }
    var name: String!

    init(joker: Joker) {
        self.joker = joker
        self.name = joker.name
        
    }
    
    func performLike(callback:@escaping ((_ state: ThankedState, _ result: Bool, _ success: Bool)-> Void)) {
        
        self.thankedState = .stateChangeInProgress
        callback(.stateChangeInProgress, self.thanked, true)
        self.joker.performThank { (success) in
            self.thanked = !self.thanked
            callback(.stateKnown, self.thanked, true)
        }
        
        
    }
}

class JokeCardViewModel : FeedCardViewModel {
    var type: FeedViewModelCardType {
        return .joke
    }
    var cellID: String {
        return "jokeCell"
    }
    var content: String!
    
    init(content: String) {
        self.content = content
    }
}

class PunCardViewModel : FeedCardViewModel {
    var type: FeedViewModelCardType {
        return .pun
    }
    var cellID: String {
        return "punCell"
    }
    var content: String!
    
    init(content: String) {
        self.content = content
    }
}


// MARK: Data
let newsFeedData = [["type" : "pun",
                     "content" : "Id love to data model"],
                    ["type" : "joke",
                     "content" : "knock knock"],
                    ["type" : "joker",
                     "name" : "Billy B"],
                    ["type" : "joke",
                     "content" : "what did the chicken say"],
                    ["type" : "pun",
                     "content" : "feed controller is hungry"],
                    ["type" : "joker",
                     "name" : "Davey K"],
                    ["type" : "pun",
                     "content" : "home is where your feed is"]]

let profileFeedData = ["type" : "joker",
                       "name" : "Davey K",
                       "jokes" : [["type" : "joke", "content" : "knock knock"],
                                  ["type" : "joke", "content" : "what did the chicken say"],
                                  ["type" : "joke", "content" : "why did the chicken"],
                                  ["type" : "joke", "content" : "knock knock"],
                                  ["type" : "joke", "content" : "what did the chicken say"],
                                  ["type" : "joke", "content" : "why did the chicken"]],
                       "puns" : [["type" : "pun", "content" : "feed controller is hungry"],
                                 ["type" : "pun", "content" : "home is where your feed is"],
                                 ["type" : "pun", "content" : "feed controller is hungry"],
                                 ["type" : "pun", "content" : "home is where your feed is"],
                                 ["type" : "pun", "content" : "feed controller is hungry"],
                                 ["type" : "pun", "content" : "home is where your feed is"]]] as [String : Any]

