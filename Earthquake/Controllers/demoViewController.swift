//
//  demoViewController.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/7/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import UIKit

var outputdata = ""
var info2d = [[String]](repeating: [String](repeating: "", count: 10), count: 5)

class demoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! earthquakeInfoTableViewCell
        cell.magnitudeLabel.text = info2d[indexPath.row][0]
        cell.timeLabel.text = info2d[indexPath.row][2]
        cell.locationLabel.text = info2d[indexPath.row][3]
        cell.depthLabel.text = info2d[indexPath.row][1]
        
        return cell
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //data_request("https://cgda.csie.ncnu.edu.tw/haoming/earthquake/testForJava.php")
        data_request("http://cgda.csie.ncnu.edu.tw/haoming/earthquake/testForJava.php")
        // Do any additional setup after loading the view.
    }
    
    /*@IBAction func displayMessage(_ sender: Any)
    {
        messageLabel.text = outputdata
    }
    
    @IBOutlet weak var messageLabel: UILabel!*/
    
    func data_request(_ url:String)
    {
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        //let paramString = "mode=list&type=report&type=warning"
        let paramString = "mode=list&type=report"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request as URLRequest)
        {
            (data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else
            {
                print("error")
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                //print(dataString)                         //print result to console
                outputdata = String(dataString)
                //print(outputdata)
                //var info2d = [[String]]()
                //var info2d = [[String]](repeating: [String](repeating: "", count: 10), count: 5)
                var dataArray = outputdata.components(separatedBy: ";")
                dataArray.remove(at: 50)
                
                for j in 0..<10
                {
                    for i in 0..<5
                    {
                        info2d[i][j] = dataArray[(j)*5+i]
                        //print(info2d[i][j])
                    }
                }
            }
        }
        task.resume()
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
