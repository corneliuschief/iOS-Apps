//
//  ViewController.swift
//  Air Horn
//
//  Created by Elaine Breen on 02/07/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var hornSound: AVAudioPlayer?

    @IBAction func makeNoise(_ sender: UIButton) {
        hornSound?.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainBundle = Bundle.main
        let resourcePath: String = mainBundle.path(forResource: "hornSound", ofType: "m4a")!
        let url = URL(fileURLWithPath: resourcePath)
        
        do {
            hornSound = try AVAudioPlayer(contentsOf: url)
        }
        catch {
            return
        }
        hornSound?.prepareToPlay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dealloc () {
        hornSound?.stop()
    }


}

