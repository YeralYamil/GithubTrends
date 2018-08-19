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
    private var selectedViewModel: ProjectViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureTableView()
        bindViews()
    }
    
    private func configureTableView() {
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        
        tableViewDataSource.itemSelected = { [unowned self] (viewModel: ProjectViewModelProtocol) -> Void in
            self.selectedViewModel = viewModel
            self.performSegue(withIdentifier: R.segue.projectListViewController.projectDetailSegue.identifier, sender: nil)
        }
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
                if let projects = projects {
                    self.tableViewDataSource.elements = projects
                    self.tableView.reloadData()
                }
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let projectViewControler = segue.destination as? ProjectViewController,
            let selectedViewModel = self.selectedViewModel else { return }
        projectViewControler.viewModel = selectedViewModel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

