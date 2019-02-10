//
//  WebViewController.swift
//  Parsing
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU AppDevelopment. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var manualUrl:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if manualUrl == "http://www.health.kr/images/insert_pdf/"{
            let alert = UIAlertController(title: "오류", message: "약 설명서가 등록되지 않았어요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
           
        }else{
        webView.load(URLRequest(url: URL(string: manualUrl)!))
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
