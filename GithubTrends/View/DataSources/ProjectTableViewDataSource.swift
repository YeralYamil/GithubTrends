//
//  GenericTableViewDataSource.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import UIKit

class ProjectTableViewDataSource: NSObject, UITableViewDataSource {
    
    var elements: [ProjectViewModelProtocol]? = nil
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let elements = elements else { return 0 }
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.projectCell.identifier) as? ProjectTableViewCell else { return UITableViewCell() }
        
        guard let projectViewModel = elements?[indexPath.row] else { return cell }
        cell.configure(viewModel: projectViewModel)
        return cell
    }
   
}