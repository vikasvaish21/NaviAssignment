//
//  PullRequestViewController.swift
//  NaviAssignment
//
//  Created by Vikas Vaish on 05/08/22.
//

import Foundation
import UIKit

class PullRequestViewController: UIViewController{
    
    //MARK: - Variables
    
    let requestTableView = UITableView()
    var responseData: DataModel?
    
    //MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        configureTableView()
        setLabel()
        navigationController?.navigationBar.isHidden = false
        
    }
    
    // MARK: - Custom Functions
    
    func setLabel(){
        view.backgroundColor = .white
        view.addSubview(noClosedRequestLabel)
        noClosedRequestLabel.translatesAutoresizingMaskIntoConstraints = false
        noClosedRequestLabel.centerX(inView: requestTableView)
        noClosedRequestLabel.centerY(inView: requestTableView)
        noClosedRequestLabel.isHidden = true
    }
    
    func configureTableView() {
        view.addSubview(requestTableView)
        requestTableView.translatesAutoresizingMaskIntoConstraints = false
        requestTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        registerOurCells()
        requestTableView.backgroundColor = .systemGray6
        requestTableView.dataSource = self
        requestTableView.delegate = self
        requestTableView.isHidden = false
        
    }
    
    func registerOurCells() {
        requestTableView.register(RequestTableViewCell.self, forCellReuseIdentifier: RequestTableViewCell.reuseId)
    }
    
    //MARK: - Set Labels
    
    private var noClosedRequestLabel : UILabel = {
        let label = UILabel()
        label.text = "No Data Found"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = UIColor.black
        return label
    }()
    
}

    //MARK: - TableView Functions

extension PullRequestViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if responseData?.count ?? 0 > 0{
            tableView.isHidden = false
            noClosedRequestLabel.isHidden = true
        }else{
            tableView.isHidden = true
            noClosedRequestLabel.isHidden = false
        }
        return responseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.reuseId, for: indexPath) as! RequestTableViewCell
       cell.setup(responseData: responseData, itemIndex: indexPath.row)
       return cell
    }
    
}

