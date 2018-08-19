//
//  ProjectViewModel.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ProjectViewModelProtocol {
    var output: ProjectViewModel.Output { get }
}

struct ProjectViewModel: ProjectViewModelProtocol {
    
    let project: Project
    let output: Output
    
    init(project: Project) {
        self.project = project
        let stargazersCount = project.stargazersCount ?? 0
        let name = project.name ?? ""
        let description = project.description ?? ""
        self.output = Output(name: Property<String>(value: name), starsCount: Property<String>(value: String(describing: stargazersCount)), description: Property<String>(value: description))
    }
    
}

//MARK: Defining Output data types
extension ProjectViewModel {
    
    struct Output {
        let name: Property<String>
        let starsCount: Property<String>
        let description: Property<String>
    }
    
}
