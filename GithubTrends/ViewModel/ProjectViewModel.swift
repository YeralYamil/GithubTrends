//
//  ProjectViewModel.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol ProjectViewModelProtocol {
    var output: ProjectViewModel.Output { get }
}

struct ProjectViewModel: ProjectViewModelProtocol {
    
    let project: Project
    let output: Output
    
    init(project: Project) {
        self.project = project
        let stargazersCount = project.stargazersCount ?? 0
        
        let avatarUrl = project.owner.avatarUrl ?? ""
        self.output = Output(name: Property<String?>(value: project.name), starsCount: Property<String>(value: String(describing: stargazersCount)), forksCount: Property<String>(value: String(describing: project.forks)), description: Property<String?>(value: project.description), userName: Property<String?>(value: project.owner.login), avatarUrl: Property<String?>(value: avatarUrl))
    }
    
}

//MARK: Defining Output data types
extension ProjectViewModel {
    
    struct Output {
        let name: Property<String?>
        let starsCount: Property<String>
        let forksCount: Property<String>
        let description: Property<String?>
        let userName: Property<String?>
        let avatarUrl: Property<String?>
        
        func getAvatarImageData(dataRequester: DataRequesting = URLSession.shared.reactive) -> SignalProducer<Data?, AnyError> {
            guard let avatarUrlString = avatarUrl.value else { return SignalProducer.empty }
            return dataRequester
                .data(urlString: avatarUrlString)
        }
        
        /*func getReadmeContent(dataRequester: DataRequesting = URLSession.shared.reactive) -> SignalProducer<String?, AnyError> {
            return dataRequester
                .data(urlString: "")
                .skipNil()
                .map({ (data) -> String? in
                    return String(data: data, encoding: .utf32)
                })
        }*/
        
    }
    
}
