//
//  PullRequestViewController.swift
//  NaviAssignment
//
//  Created by Vikas Vaish on 05/08/22.
//

import Foundation
import UIKit
class PullRequestViewController: UIViewController{
    
    let requestTableView = UITableView()
    var responseData: DataModel?
    
    override func viewDidLoad() {
        configureTableView()
        navigationController?.navigationBar.isHidden = false
    }
    
    
    func configureTableView() {
        view.addSubview(requestTableView)
        requestTableView.translatesAutoresizingMaskIntoConstraints = false
        requestTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        registerOurCells()
        requestTableView.backgroundColor = .systemGray6
        requestTableView.dataSource = self
        requestTableView.delegate = self
        
    }
    
    func registerOurCells() {
        requestTableView.register(RequestTableViewCell.self, forCellReuseIdentifier: RequestTableViewCell.reuseId)
    }
    
}


extension PullRequestViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.reuseId, for: indexPath) as! RequestTableViewCell
       cell.setup(responseData: responseData, itemIndex: indexPath.row)
       return cell
    }
    
}

