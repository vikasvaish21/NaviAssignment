//
//  RequestTableViewCell.swift
//  NaviAssignment
//
//  Created by Vikas Vaish on 05/08/22.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    //MARK: - Variables
    
    static var reuseId = "RequestTableViewCell"
    
    //MARK: - Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - Set Cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(backGround)
        backGround.addSubview(titleLabel)
        backGround.addSubview(profileImage)
        backGround.addSubview(usernameLabel)
        backGround.addSubview(createdAtLabel)
        backGround.addSubview(closeDateLabel)
        setConstraints()
        
    }
    
    //MARK: - Custom Functions
    
    func setConstraints(){
        backGround.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 120)
        titleLabel.anchor(top: backGround.topAnchor,left: backGround.leftAnchor,paddingTop: 8,paddingLeft: 16,paddingBottom: 10,width: 200)
        usernameLabel.anchor(top: backGround.topAnchor,left: titleLabel.rightAnchor, right: backGround.rightAnchor, paddingTop: 8, paddingRight: 16)
        usernameLabel.centerY(inView: titleLabel)
        profileImage.anchor(top: titleLabel.bottomAnchor,left: titleLabel.leftAnchor,bottom: backGround.bottomAnchor,paddingBottom: 10,width: 60,height: 60)
        createdAtLabel.anchor(top: usernameLabel.bottomAnchor,right: usernameLabel.rightAnchor, paddingTop: 20)
        closeDateLabel.anchor(top: createdAtLabel.bottomAnchor,bottom: profileImage.bottomAnchor,right: usernameLabel.rightAnchor, paddingTop: 8)
        
    }
    
    func setup(responseData: DataModel?,itemIndex: Int) {
        titleLabel.text = responseData?[itemIndex].title
        usernameLabel.text = responseData?[itemIndex].user.login
        let createDate = responseData?[itemIndex].createdAt ?? ""
        createdAtLabel.text = "Created At: \(dateFormater(dateString: "\(createDate )", withFormat: "yyyy-MM-dd") ?? "Not Available")"
        let closedDate = responseData?[itemIndex].closedAt ?? ""
        closeDateLabel.text = "Closed At: \(dateFormater(dateString: "\(closedDate)", withFormat: "yyyy-MM-dd") ?? "Not Available")"
        downloadImage(responseData?[itemIndex].user.avatarURL ?? "" )
     }
    
    
    func dateFormater(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    func downloadImage(_ profileURL: String) {
        NetworkingManager.shared.getImage(profileURL) { image, error in
            guard error == nil else{
                return
            }
            self.profileImage.image = image
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Set Views, Labels & ImageView
    
    
    let backGround : UIView = {
        let view = UIView()
        return view
    }()
    
    
    var profileImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    
    private let createdAtLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let closeDateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let usernameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    

}
