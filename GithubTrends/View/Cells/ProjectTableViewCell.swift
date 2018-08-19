//
//  ProjectTableViewCell.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/18/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import UIKit
import ReactiveSwift

class ProjectTableViewCell: UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: ProjectViewModelProtocol?
    
    func configure(viewModel: ProjectViewModelProtocol) {
        self.viewModel = viewModel
        nameLabel.reactive.text <~ viewModel.output.name
        starsCountLabel.reactive.text <~ viewModel.output.starsCount
        descriptionLabel.reactive.text <~ viewModel.output.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
