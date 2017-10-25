//
//  SegmentCollectionReusableView.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/25/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

class SegmentCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var segmentUpdated: ((_ newSegment: Int) -> Void)!
    
    @IBAction func segmentControlTapped(_ sender: Any) {
        self.segmentUpdated(self.segmentControl.selectedSegmentIndex)
    }
}
