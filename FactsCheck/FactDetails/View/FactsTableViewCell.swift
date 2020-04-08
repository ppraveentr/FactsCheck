//
//  FactsTableViewCell.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

final class FactsTableViewCell: UITableViewCell, ConfigurableCell {
    private var imgView: UIImageView?
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    
    private(set) var viewModel: Fact! {
        didSet {
            // update cell details
            titleLabel.text = viewModel.title
            descLabel.text = viewModel.description
            // clear out imageView on each load
            imgView?.removeFromSuperview()
            imgView = nil
        }
    }
    
    // clear out imageView before each use
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView?.removeFromSuperview()
        imgView = nil
    }
}

extension FactsTableViewCell {
    func setup(viewModel: Fact) {
        self.selectionStyle = .none
        self.viewModel = viewModel
        // set cell view
        configueCell()
    }
        
    private enum Constants {
        static let defaultimageSize: CGFloat = 0.0
        static let imageSize: CGFloat = 120.0
    }
    
    private var imageSize: CGFloat {
        return viewModel.imageHref == nil ? Constants.defaultimageSize : Constants.imageSize
    }
    
    private func configueCell() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 14)
        
        // setup imageView
        let imageView = UIImageView()
        imgView = imageView
        
        // download img async
        if let url = viewModel.imageHref {
            imageView.downloadedFrom(link: url)
        }
        
        // Setup constraints
        contentView.anchor(constraints: [
            "V:|-[image(\(imageSize))]-(>=8@900)-|",
            "V:|-[title]-[message]->=10-|",
            "H:|-[image(\(Constants.imageSize))]-[title]-|",
            "H:|-[image]-[message]-|"
            ], viewsDict: [
                "image": imageView,
                "title": titleLabel,
                "message": descLabel
        ])
    }
}
