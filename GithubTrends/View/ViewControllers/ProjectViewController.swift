//
//  ProjectViewController.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/19/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ProjectViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsForksSegmentedControl: UISegmentedControl!
    @IBOutlet weak var readmeContentLabel: UILabel!
    
    private let starCountSegmentIndex = 0
    private let forkCountSegmentIndex = 1
    
    var viewModel: ProjectViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        avatarImageView.circular()
        // Do any additional setup after loading the view.
    }
    
    func bindViews() {
        self.navigationItem.title = viewModel.output.name.value
        descriptionLabel.reactive.text <~ viewModel.output.description
        userNameLabel.reactive.text <~ viewModel.output.userName
        starsForksSegmentedControl.setTitle(R.string.localizable.stars(viewModel.output.starsCount.value), forSegmentAt: starCountSegmentIndex)
        starsForksSegmentedControl.setTitle(R.string.localizable.forks(viewModel.output.forksCount.value), forSegmentAt: forkCountSegmentIndex)
        
        viewModel.output.getAvatarImageData()
            .skipNil()
            .map(dataToImage)
            .observe(on: UIScheduler())
            .take(first: 1)
            .start { [weak self] (event) -> Void in
                guard let image = event.value else { return }
                self?.avatarImageView.image = image
            }
    }
    
    func dataToImage(_ data: Data) -> UIImage? {
        return UIImage.init(data: data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
