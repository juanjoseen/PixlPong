//
//  SettingsTexturesScene.swift
//  PixlPong
//
//  Created by Carlos Uribe on 13/08/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class SettingsTexturesScene: SKScene{
    weak var sknBrickTexture:SKSpriteNode?

    override func didMove(to view: SKView) {
        self.size = CGSize(width: screenWidth, height: screenHeight)

        let texture:SKTexture = SKTexture(imageNamed: "woodTree")
        sknBrickTexture = self.childNode(withName: "sknBrickTexture") as? SKSpriteNode
        sknBrickTexture?.texture = texture

    }
}
