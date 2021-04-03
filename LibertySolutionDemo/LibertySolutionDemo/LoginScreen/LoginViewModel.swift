//
//  LoginViewModel.swift
//  LibertySolutionDemo
//
//  Created by Ashish Viltoriya on 01/04/21.
//

import UIKit

class LoginViewModel {
    let screenName = "Login"
    let isValidForm = Dynamic(false)
    var isValidEmail = false
    var isPasswordValid = false
    
    func checkLoginFields() {
        if isPasswordValid && isValidEmail {
            isValidForm.value = true
        } else {
            isValidForm.value = false
        }
    }
    
    func isValidEmail(_ email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
    }
    
    func fieldsShouldChangeCharactersInRange(textfield: UITextField, range: NSRange, replacementString string: String) -> Bool {
            let currentText = textfield.text ?? ""

            guard let stringRange = Range(range, in: currentText) else { return false }

            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            if updatedText.count <= 15 && updatedText.count >= 8 {
                isPasswordValid = true
            } else {
                isPasswordValid = false
            }
            checkLoginFields()
            return updatedText.count <= 15
        }
    
    
}
