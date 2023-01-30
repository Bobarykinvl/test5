//
//  SixthAnimationViewController.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 6.01.23.
//

import UIKit
import Lottie

final class SixthAnimationViewController: UIViewController {

    @IBOutlet weak var viewLottieAnimation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewLottieAnimation.animationSpeed = 1.2
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.pulsate()
        viewLottieAnimation.play()
    }
}
