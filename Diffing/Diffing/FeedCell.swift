//
//  FeedCell.swift
//  Diffing
//
//  Created by Kaushal on 27/03/18.
//  Copyright © 2018 BusyBear. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 28)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setups()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedCell {
    func setups() {
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.randomFlat
        contentView.addSubview(label)
        label.snp.makeConstraints { (amke) in
            amke.center.equalToSuperview()
        }
    }
}
