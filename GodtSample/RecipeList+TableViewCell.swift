//
//  List+TableViewCell.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit
import Kingfisher

extension RecipeList {
    
    class TableViewCell: UITableViewCell {
        private var headerImageView: UIImageView?
        private var titleLabel: UILabel?
        private var descriptionLabel: UILabel?
        
        private let sideInset: CGFloat = 10
        private let offsetBetweenViews: CGFloat = 15
        static let headerHeight: CGFloat = 250
        static let titleHeight: CGFloat = 55
        static let descriptionHeight: CGFloat = 50
        static let topInset: CGFloat = 20
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.setupUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.contentView.snp_makeConstraints { (make) in
                make.edges.equalTo(self)
            }
            
            self.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            self.setupHeaderImageView()
            self.setupTitleLabel()
            self.setupDescriptionLabel()
        }
        
        private func setupHeaderImageView() {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .ScaleAspectFill
            
            self.contentView.addSubview(imageView)
            
            imageView.snp_makeConstraints { (make) in
                make.top.equalTo(self.contentView).inset(RecipeList.TableViewCell.topInset)
                make.leading.equalTo(self.contentView)
                make.trailing.equalTo(self.contentView)
                make.height.equalTo(RecipeList.TableViewCell.headerHeight)
            }
            
            self.headerImageView = imageView
        }
        
        private func setupTitleLabel() {
            guard let headerImageView = self.headerImageView else { return }
            
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.numberOfLines = 0
            
            self.contentView.addSubview(titleLabel)
            
            titleLabel.snp_makeConstraints { (make) in
                make.top.equalTo(headerImageView.snp_bottom).offset(self.offsetBetweenViews)
                make.leading.equalTo(self.contentView).inset(self.sideInset)
                make.trailing.equalTo(self.contentView).inset(self.sideInset)
            }
            
            self.titleLabel = titleLabel
        }
        
        private func setupDescriptionLabel() {
            guard let titleLabel = self.titleLabel else { return }
            
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.numberOfLines = 2
            
            self.contentView.addSubview(descriptionLabel)
            
            descriptionLabel.snp_makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(self.offsetBetweenViews)
                make.leading.equalTo(self.contentView).inset(self.sideInset)
                make.trailing.equalTo(self.contentView).inset(self.sideInset)
                make.bottom.equalTo(self.contentView)
            }
            
            self.descriptionLabel = descriptionLabel
        }
    }
}

extension RecipeList.TableViewCell {
    // MARK: Public API
    
    func configureWithRecipe(recipe: RecipeList.RecipeData) {
        self.headerImageView?.kf_setImageWithURL(recipe.imageURL)
        self.titleLabel?.attributedText = NSAttributedString(string: recipe.title, attributes: TextAttributes.Title.attributesValue)
        self.descriptionLabel?.attributedText = NSAttributedString(string: recipe.shortDescription, attributes: TextAttributes.Description.attributesValue)
    }
}

extension RecipeList.TableViewCell: TableViewCell {
    
    static var identifier: String {
        return String(self)
    }
    
    static var estimatedHeight: CGFloat {
        return RecipeList.TableViewCell.topInset + RecipeList.TableViewCell.headerHeight + RecipeList.TableViewCell.titleHeight + RecipeList.TableViewCell.descriptionHeight
    }
    
    class func registerForTableView(tableView: UITableView) {
        tableView.registerClass(RecipeList.TableViewCell.self, forCellReuseIdentifier: RecipeList.TableViewCell.identifier)
    }
    
    func clear() {
        self.headerImageView?.image = nil
        self.titleLabel?.text = nil
        self.descriptionLabel?.text = nil
    }
}