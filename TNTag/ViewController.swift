//
//  ViewController.swift
//  TNTag
//
//  Created by Tung Nguyen on 11/22/17.
//  Copyright © 2017 Tung Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tagView: TagView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tagView.delegateTagView = self
        tagView.dataSource = ["tungtasdasdung","tung1ffsfsdfsdfsffsdf","hami","tung1","hami","tungtasdasdung","tung1ffsfsdfsdfsffsdf","hami","tung1","hami","tungtasdasdung","tung1ffsfsdfsdfsffsdf","hami","tung1","hami"]
        
        tagView.indexDefault = 4

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: TagViewDelegate{
    func didSelectTag(row:Int ,value:String){
        print(row,value)
    }
}

