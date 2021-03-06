//
//  MainViewController.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/17.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var uiSwitch: UISwitch!
    @IBOutlet weak var urlTextFileld: UITextField!
    @IBAction func clickSwitch(_ sender: UISwitch) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if let url=defaults.string(forKey: "weexurl") {
            urlTextFileld.text=url
        }
        uiSwitch.setOn(defaults.bool(forKey: "isCatch"), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let idenfifier = segue.identifier {
            switch idenfifier {
            case "weex":
                if let vc = segue.destination as? ViewController  {
                    
                    let urlStr=urlTextFileld.text!
                    let defaults = UserDefaults.standard
                    defaults.set(urlStr, forKey: "weexurl")
                    defaults.set(uiSwitch.isOn, forKey: "isCatch")
                    defaults.synchronize();
                    vc.url=urlStr
                    vc.setRightItem(title: "规则")
                }
            default: break
            }
        }
    }

}
