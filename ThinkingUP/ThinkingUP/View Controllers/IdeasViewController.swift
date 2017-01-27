//
//  IdeasViewController.swift
//  ThinkingUP
//
//  Created by Álvaro Murillo del Puerto on 22/1/17.
//  Copyright © 2017 NSCoder Sevilla. All rights reserved.
//

import UIKit

class IdeasViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    var ideas: [Idea] = []
    
    let ideaCellIdentifier = "IdeaTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ideas"
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl.addTarget(self, action: #selector(loadIdeas), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        loadIdeas()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadIdeas() -> Void {
        
        ApiManager.appInstance().ideas(completion: { [weak self] (ideas: [Idea]?, error: Error?) in
            
            guard let strongSelf = self else { return }
            
            if let ideas: [Idea] = ideas {
                
                strongSelf.ideas = ideas
                strongSelf.tableView.reloadData()
                
                strongSelf.refreshControl.endRefreshing()
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: IdeaTableViewCell = tableView.dequeueReusableCell(withIdentifier: ideaCellIdentifier, for: indexPath) as! IdeaTableViewCell
        
        cell.idea = ideas[indexPath.row]
        
        return cell
    }
}

class IdeaTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    var idea: Idea? {
        
        didSet {
            
            titleLabel.text = idea?.title
            descriptionLabel.text = idea?.ideaDescription
            authorLabel.text = idea?.user.name
        }
    }
    
}
