//
//  SettingsScene.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 03/03/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class SettingsScene: SKScene {
    
    // MARK: - Scenes -
    var startScene:SKScene!
    weak var settingsSceneTexture:SKScene!
    
    // MARK: - Nodes -
    var lblCancel:SKLabelNode?
    var lblSave:SKLabelNode?
    weak var lblSound:SKLabelNode?
    weak var lblQuit:SKLabelNode?
    weak var lblTextures:SKLabelNode?
    
    // MARK: - Methods -
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: screenWidth, height: screenHeight)

        lblCancel = self.childNode(withName: "lblCancel") as? SKLabelNode
        lblSave = self.childNode(withName: "lblSave") as? SKLabelNode
        lblSound = self.childNode(withName: "lblSound") as? SKLabelNode
        lblQuit = self.childNode(withName: "lblQuit") as? SKLabelNode
        lblTextures = self.childNode(withName: "lblTextures") as? SKLabelNode
        
        lblSave?.fontName = GlobalData.shared.fontName
        lblCancel?.fontName = GlobalData.shared.fontName
        lblSound?.fontName = GlobalData.shared.fontName
        lblQuit?.fontName = GlobalData.shared.fontName
        lblTextures?.fontName = GlobalData.shared.fontName
        
        lblCancel?.text = "cancel"
        lblSave?.text = "save"
        lblSound?.text = "sound: on"
        lblQuit?.text = "Colors"
        lblTextures?.text = "textures"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == lblCancel {
                print("Cancel touched")
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                returnToStart()
            } else if node == lblSound{
                print("lbl Sound selected, deactivate all sounds")
            } else if node == lblSave {
                print("Save touched")
                // TODO: save settings
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                returnToStart()
            } else if node == lblTextures{
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                gotoTexturesScene()
            } else if node == lblQuit {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                goToColorScene()
            }
        }
    }
    
    // MARK: - Functions -
    
    func returnToStart(){
        print("returnToStart")
        let transition = SKTransition.fade(withDuration: 1)
        startScene = SKScene(fileNamed: "StartScene")
        startScene.scaleMode = .aspectFill
        self.view?.presentScene(startScene, transition: transition)
    }
    
    func saveSettings(){
        
    }

    func gotoTexturesScene(){
        let transition = SKTransition.fade(withDuration: 1)
        settingsSceneTexture = SKScene(fileNamed: "SettingsTexturesScene")
        settingsSceneTexture.scaleMode = .aspectFill
        self.view?.presentScene(settingsSceneTexture, transition: transition)
    }
    
    func goToColorScene(){
        let transition = SKTransition.fade(withDuration: 1)
        let colorScene:SKScene! = SKScene(fileNamed: "SettingsColorScene")
        colorScene.scaleMode = .aspectFill
        self.view?.presentScene(colorScene, transition: transition)
    }
}
