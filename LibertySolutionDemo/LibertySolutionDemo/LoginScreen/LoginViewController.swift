//
//  LoginViewController.swift
//  LibertySolutionDemo
//
//  Created by Ashish Viltoriya on 01/04/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenName
        viewModel.isValidForm.bind {[weak self] (success) in
            if success {
                self?.loginButton.isEnabled = true
                self?.loginButton.backgroundColor = .systemRed
            } else {
                self?.loginButton.isEnabled = false
                self?.loginButton.backgroundColor = .systemFill
            }
        }
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            viewModel.isValidEmail(textField.text ?? "")
            viewModel.checkLoginFields()
            return true
        } else {
            return viewModel.fieldsShouldChangeCharactersInRange(textfield: textField, range: range, replacementString: string)
        }
    }
    
}
