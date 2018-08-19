//
//  ViewController.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/16/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ProjectListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: ProjectListViewModelProtocol = ProjectListViewModel()
    private let tableViewDataSource = ProjectTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = tableViewDataSource
        bindViews()
    }
    
    private func bindViews() {
        
        let input = ProjectListViewModel.Input(searchText: searchBar.reactive.continuousTextValues.skipNil().filter{ $0.count > 2 })  //Just make search after 3 characters to avoid going over the search limit soon
        let output = viewModel.transform(input: input)
        
        output.projects.observe { event in
            
            switch (event) {
            case .completed:
                print("Search signal completed")
                break;
            case .interrupted:
                print("Search signal interrupted")
                break;
            case let .failed(error):
                print("Search signal error: \(error)")
                break;
            case let .value(value):
                print("Search signal value: \(String(describing: value.0?.count))")
                
                let (projects, error) = value
                if let error = error {
                    print("Error while doing search: \(error)")
                }
                if let projects = projects,
                    projects.count != 0 {
                    self.tableViewDataSource.elements = projects
                    self.tableView.reloadData()
                }
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

