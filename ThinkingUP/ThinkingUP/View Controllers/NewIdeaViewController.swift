//
//  NewIdeaViewController.swift
//  ThinkingUP
//
//  Created by Álvaro Murillo del Puerto on 22/1/17.
//  Copyright © 2017 NSCoder Sevilla. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class NewIdeaViewController: UIViewController {
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let title = titleTextField.text else { return }
        
        guard let ideaDescription = descriptionTextView.text else { return }
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        ApiManager.appInstance().createIdea(with: title, and: ideaDescription) { [weak self] (success, error) in
            
            guard let strongSelf = self else { return }
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
            strongSelf.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancel(_ sender: Any) {
        
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

}
