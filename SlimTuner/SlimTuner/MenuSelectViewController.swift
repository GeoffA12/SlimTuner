//
//  MenuSelectViewController.swift
//  SlimTuner
//
//  Created by Geoff on 8/7/19.
//  Copyright © 2019 GeoffArroyo. All rights reserved.
//

import UIKit

class MenuSelectViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tunerButtonOutlet: UIButton!
    @IBOutlet weak var metronomeButtonOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    @IBOutlet weak var titleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var hTitleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var recordButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var recordButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var metronomeButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var metronomeButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var tunerButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var tunerButtonWidth: NSLayoutConstraint!
    // Constant variable indicating the size of the screen the app is being viewed on
    let screenSize: CGRect = UIScreen.main.bounds
    let const = "Background"
    
    // titleAxis is a global variable which is defined as a constraint because we need
    // to programatically determine whether the app is in landscape or portrait mode so we know
    // to use the correct horizontal center constraint in the animation function (there are two diff horizontal constraints)
    var titleAxis: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Change the constraints of the title so that the label is off the screen when the
        // app is still in the loading state
        titleAxis = (UIDevice.current.orientation.isPortrait) ? titleLabelConstraint : hTitleLabelConstraint
        titleAxis.constant -= view.bounds.width
        print("Title label is off the screen now.")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let heightArray = [recordButtonHeight, metronomeButtonHeight, tunerButtonHeight]
        let widthArray = [recordButtonWidth, metronomeButtonWidth, tunerButtonWidth]
        
        // Do we need to reset the constraints?
       /* for constraint in heightArray {
            if let constraint = constraint {
                constraint.constant = initialHeight
            }
        }
        for constraint in widthArray {
            if let constraint = constraint {
                constraint.constant = initialWidth
            }
        }*/
        
        DispatchQueue.main.async() {
            // One of the main problems initially was that you used self.screenSize.height. This float value
            // wasn't passed into the function and wasn't updated to the size of the view after the rotation occured.
            // Thus, we need to use DispatchQueue here because this block will be executed after the rotation
            // is complete and the new sizes are available.
            let height: CGFloat = self.view.bounds.size.height
            let width: CGFloat = self.view.frame.size.width
            self.setButtonConstants(array1: heightArray, array2: widthArray, screenHeight: height, screenWidth: width)
        }
//        setButtonConstants(array1: heightArray, array2: widthArray)
//        print(screenSize.height)
//        print("Height and width were changed inside viewWillTransition")
    }
    
    var viewImagesConfigured = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let heightArray = [recordButtonHeight, metronomeButtonHeight, tunerButtonHeight]
        let widthArray = [recordButtonWidth, metronomeButtonWidth, tunerButtonWidth]
        
        setButtonConstants(array1: heightArray, array2: widthArray, screenHeight: screenSize.height, screenWidth: screenSize.width)
       
        if !viewImagesConfigured {
            setImageCentering(aButton: tunerButtonOutlet)
            setImageCentering(aButton: recordButtonOutlet)
            setImageCentering(aButton: metronomeButtonOutlet)
            setupButtonBorder(aButton: tunerButtonOutlet)
            setupButtonBorder(aButton: recordButtonOutlet)
            setupButtonBorder(aButton: metronomeButtonOutlet)
            setCustomTitleFont(aLabel: titleLabel)
            viewImagesConfigured = true
        }
    }
    
    
    func setButtonConstants(array1: Array<NSLayoutConstraint?>, array2: Array<NSLayoutConstraint?>, screenHeight: CGFloat, screenWidth: CGFloat) {
        // Play around with the constants and test them on different devices
        // was 10 : 6, changed to 12 : 6
        let heightScale: CGFloat = UIDevice.current.orientation.isPortrait ? 12 : 6
        let widthScale: CGFloat = UIDevice.current.orientation.isPortrait ? 6 : 12
        print("Screen height is", screenHeight)
        print("Screen width is", screenWidth)
        for constraint in array1 {
            if let constraint = constraint {
                constraint.constant = screenHeight / heightScale
            }
        }
        print("Height of buttons were changed.")
        for constraint in array2 {
            if let constraint = constraint {
                constraint.constant = screenWidth / widthScale
            }
        }
        print("Width of buttons were changed.")
    }
    
    var animationPerformed = false
    // The reason why the landscape mode isn't animating is because the titleLabel has its own horizontal y constraint
    // which hasn't been hooked up to storyboard yet. Hook this constraint up and use a boolean to determine which
    // constraint needs to be animated.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !animationPerformed {
            // Duration of 0.5 seconds. No delay on the animation
            UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseOut, animations: {
                // Bring the titleLabel back to the center of the view by adding the view.bounds.width back to the
                // constant value of the titlelabel constraint
                self.titleAxis.constant += self.view.bounds.width
                // YOu always need to call layoutIfNeeded when animating with constraints. This lays out the subviews
                // immediately and is responsible for performing the animation when it comes to animating constraints.
                self.view.layoutIfNeeded()
            }, completion: nil)
            print("Animation was performed")
            animationPerformed = true
        }
    }
    
    func setImageCentering(aButton: UIButton) {
        aButton.contentMode = .center
        aButton.imageView?.contentMode = .scaleAspectFit
        print("Image has been centered and scaled.")
    }
    
    
    func setupButtonBorder(aButton: UIButton) {
        //aButton.layer.cornerRadius = 30;
        aButton.clipsToBounds = false;
        aButton.layer.borderColor = UIColor.black.cgColor;
        aButton.layer.borderWidth = 3;
        print("Changing the border.")
    }
    
    func setCustomTitleFont(aLabel: UILabel) {
        let multipleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Noteworthy-Bold", size: 40.0)!, NSAttributedString.Key.foregroundColor: UIColor(red: 13, green: 143, blue: 230)]
        let custom = NSMutableAttributedString(string: "Slim Tuner", attributes: multipleAttributes)
        titleLabel.attributedText = custom
        print("I just changed the title font.")
    }
    

}

