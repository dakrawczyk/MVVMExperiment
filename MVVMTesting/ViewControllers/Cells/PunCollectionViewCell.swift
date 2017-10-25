//
//  PunCollectionViewCell.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

class PunCollectionViewCell: FeedItemCompatibleClass {
    
    @IBOutlet weak var punLabel: UILabel!
    var viewModel: PunCardViewModel!
    
    override func configure(viewModel: FeedCardViewModel) {
        self.viewModel = viewModel as! PunCardViewModel
        self.punLabel.text = self.viewModel.content
    }
}
