//
//  MenuSelectViewController.swift
//  SlimTuner
//
//  Created by Geoff on 8/7/19.
//  Copyright © 2019 GeoffArroyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tunerButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var metronomeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*setupButtonBorder(aButton: metronomeOutlet)
        setupButtonBorder(aButton: tunerOutlet)*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImageCentering(aButton: tunerButton)
        setImageCentering(aButton: recordButton)
        setImageCentering(aButton: metronomeButton)
        print("Images have been centered and scaled.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setImageCentering(aButton: UIButton) {
        aButton.contentMode = .center
        aButton.imageView?.contentMode = .scaleAspectFit
    }
    
    
    func setupButtonBorder(aButton: UIButton) {
        aButton.layer.cornerRadius = 30;
        aButton.clipsToBounds = true;
        aButton.layer.borderColor = UIColor.black.cgColor;
        aButton.layer.borderWidth = 2;
        print("Changing the border.")
    }


}

