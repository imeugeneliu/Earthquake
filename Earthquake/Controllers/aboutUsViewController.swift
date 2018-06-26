//
//  aboutUsViewController.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/7/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import UIKit

class aboutUsViewController: UIViewController
{


    @IBAction func toFacebook(_ sender: Any)
    {
        openUrl(urlStr: "https://www.facebook.com/ncnucg/")
    }
    
    func openUrl(urlStr:String!)
    {
        if let url = NSURL(string:urlStr)
        {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
