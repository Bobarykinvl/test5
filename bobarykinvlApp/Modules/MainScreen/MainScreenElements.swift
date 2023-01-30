//
//  MainScreenElements.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 17.12.22.
//

import Foundation
import UIKit

var animations: [Animation] = []

enum AnimationSegueIdentifier: String {
    case firstAnimationSegue, secondAnimationSegue, thirdAnimationSegue,
         fourthAnimationSegue, fifthAnimationSegue, sixthAnimationSegue
}

//MARK: IAPProducts
enum IAPProducts: String {
    case nonConsumable = "tcom.itexusllc.NonConsumable"
    case consumable = "tcom.itexusllc.Consumable"
}
