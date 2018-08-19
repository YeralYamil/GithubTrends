//
//  ProjectListViewModel.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol ProjectListViewModelProtocol {
    func transform(input: ProjectListViewModel.Input) -> ProjectListViewModel.Output
}

struct ProjectListViewModel: ProjectListViewModelProtocol {
    
    private let service: GithubServiceProtocol
    
    init(service: GithubServiceProtocol = GithubService()) {
        self.service = service
    }
    
    func transform(input: Input) -> Output {
        
        let viewModels = service
            .searchProjects(searchTermSignal: input.searchText)
            .map { (arg) -> ([ProjectViewModelProtocol]?, ServiceError?) in
                
                let (projects, error) = arg
                let viewModels =
                    projects?
                        .map({ (project) -> ProjectViewModelProtocol in
                            return ProjectViewModel(project: project)
                        })
                
                return (viewModels, error)
            }
            .observe(on: UIScheduler())
        
        let output = Output(projects: viewModels)
        return output
    }
    
}

//MARK: Defining Input and Output data types
extension ProjectListViewModel {
    struct Input {
        var searchText: Signal<String, NoError>
    }
    struct Output {
        var projects: Signal<([ProjectViewModelProtocol]?, ServiceError?), AnyError>
    }
}
