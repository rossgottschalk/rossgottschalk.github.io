//
//  LoginViewController.swift
//  FilmFest2
//
//  Created by Tyler on 9/24/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController
{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
     
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let user = FIRAuth.auth()?.currentUser
        {
            userIsSignedIn(user: user)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == emailTextField && (emailTextField.text?.characters.count)! > 0
        {
            emailTextField.resignFirstResponder()
            if passwordTextField.text?.characters.count == 0
            {
                passwordTextField.becomeFirstResponder()
            }
        } else if textField == passwordTextField && (passwordTextField.text?.characters.count)! > 0
        {
            passwordTextField.resignFirstResponder()
            if emailTextField.text?.characters.count == 0
            {
                emailTextField.becomeFirstResponder()
            }
        }
        
        return false
    }
    
    // MARK: - Firebase methods
    
    func userIsSignedIn(user: FIRUser)
    {
        AppState.sharedInstance.uid = user.uid
        AppState.sharedInstance.displayName = user.displayName ?? user.email
        AppState.sharedInstance.signedIn = true
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginPressed(_ sender: UIButton)
    {
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) {
                user, error in
                if let error = error
                {
                    print(error.localizedDescription)
                    return
                }
                print("Sign in successful!")
                self.userIsSignedIn(user: user!)
            }
        }
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton)
    {
        let firebaseAuth = FIRAuth.auth()
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            firebaseAuth?.signIn(withEmail: email, password: password)  {
                user, error in
                if let error = error
                {
                    print(error.localizedDescription)
                    return
                }
                print("User created successfully")
                self.setDisplayName(user: user!)
            }
        }
    }
    
    func setDisplayName(user: FIRUser)
    {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges() {
            error in
            if let error = error
            {
                print(error.localizedDescription)
                return
            }
            
            let currentUser = (FIRAuth.auth()?.currentUser!)!
            self.userIsSignedIn(user: currentUser)
        }
    }

}
