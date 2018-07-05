//
//  ViewController.swift
//  Diffing
//
//  Created by Kaushal on 27/03/18.
//  Copyright © 2018 BusyBear. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit
import CHTCollectionViewWaterfallLayout
import IGListKit

class ViewController: UIViewController {
    var items: [ListDiffable] = []
    
    lazy var layout: UICollectionViewLayout = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumColumnSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.backgroundColor = UIColor.flatWhite
        collection.register(FeedCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        collection.bounces = true
        collection.alwaysBounceVertical = true
        return collection
    }()
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        createData()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let rightBbi = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        let leftBbi = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(handleReload))
        navigationItem.setLeftBarButton(leftBbi, animated: true)
        navigationItem.setRightBarButton(rightBbi, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        
        cell.label.text = (items[indexPath.item] as! FeedItem).desc
        
        return cell
    }
}

extension ViewController: CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let randomOffset: CGFloat = CGFloat(arc4random() % 100)
        
        var height: CGFloat = 0
        if indexPath.row % 2 == 0 {
            height = 220 + randomOffset
        } else {
            height = 220 - randomOffset
        }

        return CGSize(width: (self.view.bounds.width - 30) / 2, height: height)
    }
}

extension ViewController {
    @objc func handleAdd() {
        let additions: [ListDiffable] = [
            FeedItem(pk: 50, desc: "50"),
            FeedItem(pk: 60, desc: "60"),
        ]
        
        var new = self.items.map { $0 }
        new.append(contentsOf: additions)
        let result = ListDiffPaths(fromSection: 0, toSection: 0, oldArray: self.items, newArray: new, option: .equality).forBatchUpdates()
        
        self.items = new
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: result.inserts)
            //collectionView.reloadItems(at: result.updates)
        }, completion: nil)
    }
    
    @objc func handleReload() {
        
    }
    
    func createData() {
        let array = [
            FeedItem(pk: 10, desc: "10"),
            FeedItem(pk: 20, desc: "20"),
            FeedItem(pk: 30, desc: "30"),
            FeedItem(pk: 40, desc: "40")
        ]
        
        self.items = array
        self.collectionView.reloadData()
    }
}


