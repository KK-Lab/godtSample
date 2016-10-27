//
//  ListViewController.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 23.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit
import SnapKit

struct RecipeList {}

extension RecipeList {
    
    enum Section: Int {
        case Recipes = 0
        case NoRecipes = 1
        
        static var allValues: [RecipeList.Section] = [.Recipes, .NoRecipes]
    }
    
    class ViewController: UIViewController {
        private var tableView: UITableView?
        
        private var recipes: [RecipeList.RecipeData] = []
        
        var presenter: RecipeListPresenter?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.setupUI()
            self.presenter?.getRecipes()
        }
        
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            
            self.presenter?.updateRecipes()
        }
        
        private func setupUI() {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            
            self.setupNavigationBar()
            self.setupTableView()
            self.setupSearchBar()
        }
        
        private func setupNavigationBar() {
            self.title = "godt"
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = false
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName: Color.Gray.colorValue,
                NSFontAttributeName: UIFont.systemFontOfSize(20, weight: UIFontWeightSemibold)
            ]
            self.navigationController?.navigationBar.tintColor = Color.Gray.colorValue
        }
        
        private func setupTableView() {
            let tableView = UITableView(frame: CGRectZero)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(tableView)
            
            tableView.snp_makeConstraints { (make) in
                make.edges.equalTo(self.view)
            }
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .None
            
            RecipeList.TableViewCell.registerForTableView(tableView)
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
            
            self.tableView = tableView
        }
        
        private func setupSearchBar() {
            let searchBar = UISearchBar(frame: CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), 44))
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.backgroundColor = UIColor.clearColor()
            searchBar.placeholder = "Search"
            searchBar.searchBarStyle = UISearchBarStyle.Minimal
            searchBar.backgroundImage = UIImage()
            searchBar.barTintColor = Color.LightGray.colorValue
            searchBar.tintColor = Color.Gray.colorValue
            searchBar.delegate = self
            searchBar.snp_makeConstraints { (make) in
                make.width.equalTo(UIScreen.mainScreen().bounds.width)
                make.height.equalTo(44)
            }
            
            self.tableView?.tableHeaderView = searchBar
        }
    }
}

extension RecipeList.ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return RecipeList.Section.allValues.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows: Int
        
        if section == RecipeList.Section.Recipes.rawValue {
            numberOfRows = self.recipes.count > 0 ? self.recipes.count : 0
        } else {
            numberOfRows = self.recipes.count > 0 ? 0 : 1
        }
        
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell: UITableViewCell
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(RecipeList.TableViewCell.identifier, forIndexPath: indexPath) as? RecipeList.TableViewCell where indexPath.section == RecipeList.Section.Recipes.rawValue {
            cell.clear()
            cell.configureWithRecipe(self.recipes[indexPath.row])
            
            tableViewCell = cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell.self), forIndexPath: indexPath)
            cell.textLabel?.text = "No recipes found"
            cell.textLabel?.textAlignment = .Center
            
            tableViewCell = cell
        }
        
        tableViewCell.selectionStyle = .None
        
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        if indexPath.section == RecipeList.Section.Recipes.rawValue {
            self.presenter?.showDetailsForRecipeAtIndex(indexPath.row)
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let estimatedHeight: CGFloat
        
        if indexPath.section == RecipeList.Section.Recipes.rawValue {
            estimatedHeight = RecipeList.TableViewCell.estimatedHeight
        }
        else {
            estimatedHeight = 40
        }
        
        return estimatedHeight
    }
}

extension RecipeList.ViewController: UISearchBarDelegate {
    // MARK: UISearchBarDelegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.filterRecipesWithText(searchText)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.presenter?.filterRecipesWithText("")
        
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}

extension RecipeList.ViewController: RecipeListView {
    // MARK: ListView protocol implementation
    
    func setRecipes(recipes: [RecipeList.RecipeData]) {
        self.recipes = recipes
        self.tableView?.reloadData()
    }
}
