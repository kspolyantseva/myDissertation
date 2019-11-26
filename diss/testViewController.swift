//
//  testViewController.swift
//  diss
//
//  Created by Ksenia Polyantseva on 25.11.2019.
//  Copyright © 2019 Ксения Полянцева. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
var position:Int = 0
var road:Int = 0
var time:Int = 0
var tyre:Int = 0

class TestViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var dry: UIButton!
    @IBOutlet weak var rain: UIButton!
    @IBOutlet weak var snow: UIButton!
    @IBOutlet weak var night: UIButton!
    @IBOutlet weak var day: UIButton!
    @IBOutlet weak var evening: UIButton!
    @IBOutlet weak var yesbut: UIButton!
    @IBOutlet weak var nobut: UIButton!
    
    
    // 1
    @IBAction func forwardButton(_ sender: Any) {
        self.btn.backgroundColor = UIColor.green;
        self.forward.backgroundColor = UIColor.red;
        position = 1;
    }
    //2
    @IBAction func followButton(_ sender: Any) {
        self.btn.backgroundColor = UIColor.red;
        self.forward.backgroundColor = UIColor.green;
        position = 2
    }
    //1
    @IBAction func dryButton(_ sender: Any) {
        self.dry.backgroundColor = UIColor.green;
        self.rain.backgroundColor = UIColor.red;
        self.snow.backgroundColor = UIColor.red;
        road = 1;
    }
    //2
    @IBAction func rainButton(_ sender: Any) {
        self.dry.backgroundColor = UIColor.red;
        self.rain.backgroundColor = UIColor.green;
        self.snow.backgroundColor = UIColor.red;
        road = 2;
    }
    //3
    @IBAction func snowButton(_ sender: Any) {
        self.dry.backgroundColor = UIColor.red;
        self.rain.backgroundColor = UIColor.red;
        self.snow.backgroundColor = UIColor.green;
        road = 3;
    }
    //1
    @IBAction func nightButton(_ sender: Any) {
        self.night.backgroundColor = UIColor.green;
        self.day.backgroundColor = UIColor.red;
        self.evening.backgroundColor = UIColor.red;
        time = 1;
    }
    //2
    @IBAction func dayButton(_ sender: Any) {
        self.night.backgroundColor = UIColor.red;
        self.day.backgroundColor = UIColor.green;
        self.evening.backgroundColor = UIColor.red;
        time = 2;
    }
    //3
    @IBAction func eveningButton(_ sender: Any) {
        self.night.backgroundColor = UIColor.red;
        self.day.backgroundColor = UIColor.red;
        self.evening.backgroundColor = UIColor.green;
        time = 3;
    }
    //1
    @IBAction func yesButton(_ sender: Any) {
        self.yesbut.backgroundColor = UIColor.green;
        self.nobut.backgroundColor = UIColor.red;
        tyre = 1;
    }
    //2
    @IBAction func noButton(_ sender: Any) {
        self.yesbut.backgroundColor = UIColor.red;
        self.nobut.backgroundColor = UIColor.green;
        tyre = 2;
    }
    
    @IBAction func startButton(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
