//
//  DetailViewController.swift
//  Project7
//
//  Created by Omar Makran on 3/4/2024.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else {
            return
        }
        
        let html = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Petition Details</title>
            <style>
                body {
                    font-family: 'Helvetica Neue', Arial, sans-serif;
                    line-height: 1.6;
                    padding: 20px;
                    background-color: #f7f9fc;
                    color: #333;
                }
                header {
                    background-color: #a6dcef; /* Soft Blue */
                    color: white;
                    text-align: center;
                    padding: 10px 0;
                    margin-bottom: 20px;
                }
                footer {
                    background-color: #a6dcef; /* Soft Blue */
                    color: #333; /* Dark Text Color */
                    text-align: center;
                    padding: 10px 0;
                    position: center;
                    bottom: 1;
                    width: 100%;
                }
                h1, h2 {
                    color: black; /* Soft Blue */
                    border-bottom: 2px solid #a6dcef; /* Soft Blue */
                    padding-bottom: 10px;
                }
                .signature-count {
                    font-weight: bold;
                    color: #ff4500;
                    margin-top: 15px;
                }
                .description {
                    margin-top: 20px;
                    background-color: #ffffff;
                    padding: 15px;
                    border-radius: 8px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.1);
                }
                p {
                    margin-bottom: 15px;
                }
            </style>
        </head>
        <body>
            <header>
                <h1>\(detailItem.title)</h1>
                <p class="signature-count">Signature Count: \(detailItem.signatureCount)</p>
            </header>
            <div class="description">
                <h2>Description:</h2>
                <p>\(detailItem.body)</p>
            </div>
            <footer>
                <p>Data sourced from the We The People API of the Whitehouse</p>
            </footer>
        </body>
        </html>
        """

        
        webView.loadHTMLString(html, baseURL: nil)
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
