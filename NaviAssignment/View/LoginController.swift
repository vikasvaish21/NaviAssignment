//
//  LoginController.swift
//  NaviAssignment
//
//  Created by Vikas Vaish on 05/08/22.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Variables
    
    lazy var viewModel : RequestViewModel = RequestViewModel()
    var responseData : DataModel?
    
    
    //MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Set Labels, TextFields and Buttons
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "All Pull closed Request"
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.font = UIFont(name: "Avenir-Light", size: 30)
        return label
    }()
    
    
    private lazy var usernameConatinerView: UIView = {
        let view = UIView().inputContainerView(image: UIImage(named: "ic_account_box_white_2x")!,textFiled: userNameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var RepoNameConatinerView: UIView = {
        let view = UIView().inputContainerView(image: UIImage(named: "baseline_menu_black_36dp")!,textFiled: repoNameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let userNameTextField:UITextField = {
        return UITextField().textField(withPlaceHolder: "Username", isSecureTextField: false)
    }()
    
    private let repoNameTextField:UITextField = {
        return UITextField().textField(withPlaceHolder: "Repository name", isSecureTextField: false)
    }()
    
    private let loginButton: LoginButton = {
        let loginButton = LoginButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.addTarget(LoginController.self, action: #selector(loginAction), for: .touchUpInside)
        return loginButton
    }()
    
    
    // MARK: - Custom Functions
    
    func configureUI() {
        configureNavigationBar()
        view.backgroundColor = .backGroundColor
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        let stack  = UIStackView(arrangedSubviews: [userNameTextField,repoNameTextField,loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 16, paddingRight: 16)
        
    }
    
    func handleShowLogin() {
        let controller = PullRequestViewController()
        controller.responseData = self.responseData
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    // MARK: - Objc Functions
    
    @objc func loginAction() {
        if userNameTextField.text == ""{
            showAlert(withTitle: "", withMessage: "Please Enter Username")
        }else if repoNameTextField.text == ""{
            showAlert(withTitle: "", withMessage: "Please Enter Repository Name")
        }else{
            loginRequest()
        }
    }
    
}


    //MARK: - Api Hit

extension LoginController{
    
    func loginRequest(){
        viewModel.fetchData(userNameTextField.text ?? "",  repoNameTextField.text ?? "") { response, success, error in
            print(response)
            if success == true{
                self.responseData = response
                DispatchQueue.main.async {
                    self.handleShowLogin()
                }
            }else{
                print(error ?? "")
                self.showAlert(withTitle: "", withMessage: "Please check your Username or Reponame")
            }
        }
    }
}
