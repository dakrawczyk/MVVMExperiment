//
//  SecondViewController.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var feedVC: FeedViewController!
    var viewModel = ProfileFeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedVC.collectionView.dataSource = self
        self.feedVC.collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.feedVC.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedEmbed" {
            self.feedVC = segue.destination as! FeedViewController
        }
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = self.viewModel.heightForHeader(section: section)
        return CGSize(width: self.view.frame.size.width,  height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FeedViewController.kSegementCellID, for: indexPath) as! SegmentCollectionReusableView
            
            headerView.segmentUpdated = { newSegment in
                self.viewModel.selectedSegmentIndex = newSegment
                self.feedVC.collectionView.reloadData()
            }
            
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProfileSectionsViewModelType.count.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cellViewModel = self.viewModel.cellViewModelForIndexPath(indexPath: indexPath) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellID, for: indexPath) as! FeedItemCompatibleClass
            cell.configure(viewModel: cellViewModel)
            return cell
        }
        
        return UICollectionViewCell()
    }
}
