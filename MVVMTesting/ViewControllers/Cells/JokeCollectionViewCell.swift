//
//  JokeCollectionViewCell.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

class JokeCollectionViewCell: FeedItemCompatibleClass {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    var viewModel: JokeCardViewModel!
    
    override func configure(viewModel: FeedCardViewModel) {
        self.viewModel = viewModel as! JokeCardViewModel
        self.jokeLabel.text = self.viewModel.content
    }

}
