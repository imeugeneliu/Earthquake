//
//  webviewViewController.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/7/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import UIKit
import WebKit

class webviewViewController: UIViewController, WKUIDelegate
{

    @IBOutlet weak var earthquakeWebview: WKWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let myURL = URL(string: "http://cgda.csie.ncnu.edu.tw/grass/new/earthquake/3dmap4.html")
        let myRequest = URLRequest(url: myURL!)
        earthquakeWebview.load(myRequest)
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
