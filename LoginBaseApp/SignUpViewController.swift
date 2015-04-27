/*
* Copyright (C) 2015 J. Steven Welch.
*
* Licensed under the Apache License, Version 2.0 (the "License");
*    you may not use this file except in compliance with the License.
*    You may obtain a copy of the License at
*
*        http://www.apache.org/licenses/LICENSE-2.0
*
*    Unless required by applicable law or agreed to in writing, software
*    distributed under the License is distributed on an "AS IS" BASIS,
*    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*    See the License for the specific language governing permissions and
*    limitations under the License.
*/

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordRetype: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtInviteCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title="Sign Up"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSignUp(sender: AnyObject) {
        if ((count(txtPassword.text)<8) || (txtPassword.text != txtPasswordRetype.text)){
            let alert=UIAlertView(title: "Password Issue", message: "Password does not match or is too short", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            txtPassword.text=""
            txtPasswordRetype.text=""
        }else if ((txtName.text=="") || (txtLastName.text=="") || (txtUsername.text=="") || (txtEmail.text=="") || (txtInviteCode=="")){
            let alert=UIAlertView(title: "Action Required", message: "All fields must be filled in", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }else{
            var email=Email()
            email.primary=txtEmail.text
            var name=Name()
            name.firstName=txtName.text
            name.lastName=txtLastName.text
            CatalyzeUser.signUpWithUsernameInBackground(txtUsername.text, email: email, name: name, password: txtPassword.text, inviteCode: txtInviteCode.text, success: {(user: CatalyzeUser!) -> Void in
                let alert=UIAlertView(title: "Success", message: "Check your email to activate your account", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                    self.navigationController?.popViewControllerAnimated(false)
                }, failure: {(result: [NSObject : AnyObject]!, status: Int32, error: NSError!) -> Void in
                    let alert=UIAlertView(title: "Failure", message: "Something did not work. Check your invite code again.", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
