//
//  FifthAnimationViewController.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 5.01.23.
//

import UIKit

final class FifthAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let snowflakeEmitterCell = makeEmitterCell(imageName: "snowflake")
                
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterCells = [snowflakeEmitterCell]
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: -100)
        emitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.timeOffset = 10

        view.layer.addSublayer(emitterLayer)
    }
    
    func makeEmitterCell(imageName: String) -> CAEmitterCell {
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "snowflake")?.cgImage
        emitterCell.scale = 0.02
        emitterCell.scaleRange = 0.05
        emitterCell.emissionRange = .pi
        emitterCell.lifetime = 20.0
        emitterCell.birthRate = 10
        emitterCell.velocity = -10
        emitterCell.velocityRange = -10
        emitterCell.yAcceleration = 20
        emitterCell.xAcceleration = 0
        emitterCell.spin = -0.5
        emitterCell.spinRange = 1.0
        
        return emitterCell
    }
}
