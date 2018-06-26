//
//  infoTableViewController.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/16/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import UIKit
var outputdata = ""
var info2d = [[String]](repeating: [String](repeating: "", count: 10), count: 4)
var simpleLocationArray = [String](repeating: "", count: 10)
var earthquakeCenter: String = ""


class infoTableViewController: UITableViewController
{
    override func viewDidLoad()
    {
        data_request("http://cgda.csie.ncnu.edu.tw/haoming/earthquake/testForJava.php")
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
        
    func data_request(_ url:String)
    {
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
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
                var dataArray = outputdata.components(separatedBy: ";")
                dataArray.remove(at: 50)
                for j in 0..<10          //get recent 10 info
                {
                    for i in 0..<4      //get mag,dep,time,location
                    {
//                        self.info2d[i][j] = dataArray[(j)*5+i]
//                        print(self.info2d[i][j])
                        info2d[i][j] = dataArray[(j)*5+i]
//                        print(info2d[i][j])
                        
//                        var locationString = info2d[3][indexPath.row]
//                        var simpleLocationString = String(locationString.prefix(3))
//                        print(simpleLocationString)

                        if (i == 3)
                        {
                            let locationString = info2d[i][j]
                            let simpleLocationString = String(locationString.prefix(3))
                            simpleLocationArray[j] = simpleLocationString
                        }
                    }
                    //print(simpleLocationArray[j])
                }
                self.tableView.reloadData()
            }
        }
        task.resume()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! earthquakeInfoTableViewCell
        
//        cell.magnitudeLbl.text = self.info2d[0][indexPath.row]
//        cell.timeLbl.text = self.info2d[2][indexPath.row]
//        cell.locationLbl.text = self.info2d[3][indexPath.row]
//        cell.depthLbl.text = self.info2d[1][indexPath.row]
//        cell.magnitudeLbl.text = "震度: \(info2d[0][indexPath.row])"
        
//        for i in 0..<10
//        {
//            locationArray[i] = info2d[3][i]
//            simpleLocationArray[i] = String(locationArray[i].prefix(3))
//            print(simpleLocationArray[i])
//        }
        
//        locationArray[0] = info2d[3][indexPath.row]
//        var locationString = String(locationArray[0].prefix(3))
//        simpleLocationArray = locationString.components(separatedBy: " ")
//        simpleLocationArray[0] = locationString
//
//        simpleLocationArray[0] = String(locationArray[0].prefix(3))
//        toMapLocationArray =
//        for i in 0..<10
//        {
//             print(simpleLocationArray[i])
//        }
       
//        print(simpleLocationArray[0])
        
//        var locationString = info2d[3][indexPath.row]
//        var simpleLocationString = String(locationString.prefix(3))
//        print(simpleLocationString)
//         locationArray = simpleLocationString.components(separatedBy: " ")
//        print(locationArray)
        
        earthquakeCenter = simpleLocationArray[indexPath.row]
        print(earthquakeCenter)
        
        cell.magnitudeLbl.text = info2d[0][indexPath.row]
        cell.timeLbl.text = info2d[2][indexPath.row]
        cell.locationLbl.text = info2d[3][indexPath.row]
        cell.depthLbl.text = "\(info2d[1][indexPath.row]) KM"
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
