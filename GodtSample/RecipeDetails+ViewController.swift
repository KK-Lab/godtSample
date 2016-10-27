//
//  Details+ViewController.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit

struct RecipeDetails {}

extension RecipeDetails {
    
    class ViewController: UIViewController {
        private var scrollView: UIScrollView?
        private var contentView: UIView?
        private var headerImageView: UIImageView?
        private var titleLabel: UILabel?
        private var descriptionLabel: UILabel?
        private var ingredientsLabel: UILabel?
        
        var presenter: RecipeDetailsPresenter?
        
        private let headerHeight: CGFloat = 250
        private let sideInset: CGFloat = 10
        private let offsetBetweenViews: CGFloat = 15
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.setupUI()
            
            self.presenter?.getRecipe()
        }
        
        private func setupUI() {
            self.view.backgroundColor = UIColor.whiteColor()
            self.title = "Recipe"
            
            self.setupScrollView()
            self.setupContentView()
            self.setupHeaderImageView()
            self.setupTitleLabel()
            self.setupDescriptionLabel()
            self.setupIngredientsView()
        }
        
        private func setupScrollView() {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.contentSize = self.view.frame.size
            
            self.view.addSubview(scrollView)
            
            scrollView.snp_makeConstraints { (make) in
                make.edges.equalTo(self.view)
            }
            
            self.scrollView = scrollView
        }
        
        private func setupContentView() {
            guard let scrollView = self.scrollView else { return }
            
            let contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(contentView)
            
            contentView.snp_makeConstraints { (make) in
                make.width.equalTo(self.view.frame.size.width)
                make.edges.equalTo(scrollView)
            }
            
            self.contentView = contentView
        }
        
        private func setupHeaderImageView() {
            guard let contentView = self.contentView else { return }
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .ScaleAspectFill
            
            self.contentView?.addSubview(imageView)
            
            imageView.snp_makeConstraints { (make) in
                make.top.equalTo(contentView)
                make.leading.equalTo(contentView)
                make.trailing.equalTo(contentView)
                make.height.equalTo(self.headerHeight)
            }
            
            self.headerImageView = imageView
        }
        
        private func setupTitleLabel() {
            guard let contentView = self.contentView, headerImageView = self.headerImageView else { return }
            
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.numberOfLines = 0
            
            self.contentView?.addSubview(titleLabel)
            
            titleLabel.snp_makeConstraints { (make) in
                make.top.equalTo(headerImageView.snp_bottom).offset(self.offsetBetweenViews)
                make.leading.equalTo(contentView).inset(self.sideInset)
                make.trailing.equalTo(contentView).inset(self.sideInset)
            }
            
            self.titleLabel = titleLabel
        }
        
        private func setupDescriptionLabel() {
            guard let contentView = self.contentView, titleLabel = self.titleLabel else { return }
            
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.numberOfLines = 0
            
            self.contentView?.addSubview(descriptionLabel)
            
            descriptionLabel.snp_makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(self.offsetBetweenViews)
                make.leading.equalTo(contentView).inset(self.sideInset)
                make.trailing.equalTo(contentView).inset(self.sideInset)
            }
            
            self.descriptionLabel = descriptionLabel
        }
        
        private func setupIngredientsView() {
            guard let contentView = self.contentView, descriptionLabel = self.descriptionLabel else { return }
            
            let ingredientsView = UIView()
            ingredientsView.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView?.addSubview(ingredientsView)
            
            ingredientsView.snp_makeConstraints { (make) in
                make.top.equalTo(descriptionLabel.snp_bottom).offset(self.offsetBetweenViews)
                make.leading.equalTo(contentView).inset(self.sideInset)
                make.trailing.equalTo(contentView).inset(self.sideInset)
                make.bottom.equalTo(contentView)
            }
            
            let headerLabel = UILabel()
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            headerLabel.text = "Ingredients:"
            headerLabel.textColor = Color.Orange.colorValue
            headerLabel.font = UIFont.systemFontOfSize(16, weight: UIFontWeightSemibold)
            
            ingredientsView.addSubview(headerLabel)
            
            headerLabel.snp_makeConstraints { (make) in
                make.top.equalTo(ingredientsView)
                make.leading.equalTo(ingredientsView)
                make.trailing.equalTo(ingredientsView)
            }
            
            let bodyLabel = UILabel()
            bodyLabel.translatesAutoresizingMaskIntoConstraints = false
            bodyLabel.numberOfLines = 0
            
            ingredientsView.addSubview(bodyLabel)
            
            bodyLabel.snp_makeConstraints { (make) in
                make.top.equalTo(headerLabel.snp_bottom).offset(self.offsetBetweenViews * 0.5)
                make.leading.equalTo(ingredientsView)
                make.trailing.equalTo(ingredientsView)
                make.bottom.equalTo(ingredientsView).inset(self.offsetBetweenViews)
            }
            
            self.ingredientsLabel = bodyLabel
        }
    }
}

extension RecipeDetails.ViewController: RecipeDetailsView {
    // MARK: DetailsView protocol implementation
    
    func setRecipe(recipe: RecipeDetails.RecipeData) {
        self.headerImageView?.kf_setImageWithURL(recipe.imageURL)
        self.titleLabel?.attributedText = NSAttributedString(string: recipe.title, attributes: TextAttributes.Title.attributesValue)
        self.descriptionLabel?.attributedText = NSAttributedString(string: recipe.fullDescription, attributes: TextAttributes.Description.attributesValue)
        self.ingredientsLabel?.attributedText = NSAttributedString(string: recipe.ingredients.joinWithSeparator("; "), attributes: TextAttributes.Ingredients.attributesValue)
    }
}