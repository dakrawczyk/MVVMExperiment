//
//  ViewController.swift
//  MVVMTesting
//
//  Created by Dave Krawczyk on 10/24/17.
//  Copyright © 2017 Dave Krawczyk. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    var feedVC: FeedViewController!
    var viewModel: NewsFeedViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedVC.collectionView.dataSource = self

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel = NewsFeedViewModel()
        self.feedVC.collectionView.reloadData()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedEmbed" {
            self.feedVC = segue.destination as! FeedViewController
        }
    }
}

extension NewsFeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellViewModel = viewModel.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellID, for: indexPath) as! FeedItemCompatibleClass
        cell.configure(viewModel: cellViewModel)
        return cell
        
    }
}
