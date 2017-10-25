//
//  FunnyCellProtocol.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    func configure(viewModel: FeedCardViewModel) 
}

class FeedItemCompatibleClass: UICollectionViewCell, CellRepresentable {
    func configure(viewModel: FeedCardViewModel) {}

}
