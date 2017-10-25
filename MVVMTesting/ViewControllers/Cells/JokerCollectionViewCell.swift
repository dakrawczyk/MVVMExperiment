//
//  JokerCollectionViewCell.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

class JokerCollectionViewCell: FeedItemCompatibleClass {
    
    @IBOutlet weak var thankeButton: UIButton!
    @IBOutlet weak var jokerLabel: UILabel!
    
    var viewModel: JokerCardViewModel!
    
    override func configure(viewModel: FeedCardViewModel) {
        self.viewModel = viewModel as! JokerCardViewModel
        self.jokerLabel.text = self.viewModel.name
        
        if self.viewModel.thanked {
            self.thankeButton.backgroundColor = UIColor.green
        } else {
            self.thankeButton.backgroundColor = UIColor.red
        }

    }
    
    @IBAction func thankButtonTapped(_ sender: Any) {
        self.viewModel.performLike { (thankedState, thanked, success) in
            switch thankedState {
            case .stateChangeInProgress:
                self.thankeButton.backgroundColor = UIColor.blue
            case .stateKnown:
                if thanked {
                    self.thankeButton.backgroundColor = UIColor.green
                } else {
                    self.thankeButton.backgroundColor = UIColor.red
                }
                
            }
        }
    }
}
