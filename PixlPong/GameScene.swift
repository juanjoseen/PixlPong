//
//  GameScene.swift
//  PixlPong
//
//  Created by Juan Jose Elias Navaro on 27/02/18.
//  Copyright © 2018 Axkan Software. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let COUNT_DOWN:Int = 3
    
    var remainingLives:Int = 5
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    var isMoving = false
    
    let ballCategory:UInt32   = 0x1 << 0
    let bottomCategory:UInt32 = 0x1 << 1
    let paddleCategory:UInt32 = 0x1 << 2
    
    var lblCount:SKLabelNode!
    var lblScore:SKLabelNode!
    var ballNode:SKSpriteNode!
    var upBar:SKSpriteNode!
    var downBar:SKSpriteNode!
    var leftBar:SKSpriteNode!
    var rightBar:SKSpriteNode!
    
    var score:Double = 0 {
        didSet{
            lblScore.text = "Score: \(Int(score))"
            GlobalData.shared.localScore = score
        }
    }
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: screenWidth, height: screenHeight)
        
        // Config labels
        lblCount = self.childNode(withName: "lblCount") as? SKLabelNode
        lblScore = self.childNode(withName: "scoreLabel") as? SKLabelNode
        lblScore.fontName = "8BITWONDERNominal"
        score = 0
        
        // Config world
        self.physicsWorld.gravity = CGVector.zero
        let borderBody:SKPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        self.physicsBody?.friction = 0.0
        self.physicsWorld.contactDelegate = self
        
        // Config Bars & Ball
        ballNode = self.childNode(withName: "ball") as? SKSpriteNode
        ballNode.physicsBody = SKPhysicsBody(rectangleOf: ballNode.size)
        ballNode.physicsBody?.friction = 0.0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.linearDamping = 0
        ballNode.physicsBody?.allowsRotation = true
        
        upBar = self.childNode(withName: "upBar") as? SKSpriteNode
        upBar.physicsBody = barPhysicsBodyOfSize(upBar.size)
        
        downBar = self.childNode(withName: "downBar") as? SKSpriteNode
        downBar.physicsBody = barPhysicsBodyOfSize(downBar.size)
        
        leftBar = self.childNode(withName: "leftBar") as? SKSpriteNode
        leftBar.physicsBody = barPhysicsBodyOfSize(leftBar.size)
        
        rightBar = self.childNode(withName: "rightBar") as? SKSpriteNode
        rightBar.physicsBody = barPhysicsBodyOfSize(rightBar.size)
        
        self.physicsBody?.categoryBitMask        = bottomCategory
        ballNode.physicsBody?.categoryBitMask    = ballCategory
        upBar.physicsBody?.categoryBitMask       = paddleCategory
        downBar.physicsBody?.categoryBitMask     = paddleCategory
        leftBar.physicsBody?.categoryBitMask     = paddleCategory
        rightBar.physicsBody?.categoryBitMask    = paddleCategory
        ballNode.physicsBody?.contactTestBitMask = bottomCategory | paddleCategory
        
        configBall()
        configBars()
        
        // Start count down & game
        showCountDown(count: COUNT_DOWN)
        startGame(afterTime: COUNT_DOWN + 1)
        
    }
    
    private func configBall(){
        if GlobalData.shared.useBallTextures {
            // TODO: implement texture in ball node
            let textureName:String = GlobalData.shared.ballTexture
        } else {
            let sColor:String = GlobalData.shared.ballColor
            let color:UIColor = UIColor.hexColor(sColor)
            ballNode.color = color
        }
    }
    
    private func configBars(){
        if UIDevice.modelName == "iPhone X"{
            let leftX:CGFloat = 0 - screenWidth/2 + 25
            leftBar.position = CGPoint(x: leftX, y: leftBar.position.y)
            
            let rightX:CGFloat = (screenWidth - rightBar.frame.width)/2
            rightBar.position = CGPoint(x: rightX, y: rightBar.position.y)
        }
        
        if GlobalData.shared.useBarTextures {
            // TODO: implement texture in bar nodes
            let textureName:String = GlobalData.shared.barTexture
        } else {
            let sColor:String = GlobalData.shared.barColor
            let color:UIColor = UIColor.hexColor(sColor)
            
            rightBar.color = color
            leftBar.color = color
            downBar.color = color
            upBar.color = color
        }
    }
    
    // MARK: - Touches -
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            let prevLoc = touch.previousLocation(in: self)
            
            var yBar = leftBar.position.y + (touchPoint.y - prevLoc.y)
            var xBar = upBar.position.x + (touchPoint.x - prevLoc.x)
            
            let yTop = self.size.height/2.0 - leftBar.size.height
            let xTop = (self.size.width - upBar.size.width)/2.0
            
            yBar = min(yTop, max(yBar,-yTop))
            xBar = min(xTop, max(xBar,-xTop))
            
            leftBar.position  = CGPoint(x: leftBar.position.x,  y: yBar)
            rightBar.position = CGPoint(x: rightBar.position.x, y: yBar)
            upBar.position    = CGPoint(x: xBar, y: upBar.position.y)
            downBar.position  = CGPoint(x: xBar, y: downBar.position.y)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        ballNode.run(SKAction.speed(to: 0, duration: 0.1))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: - Update -
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let dx:CGFloat = (ballNode.physicsBody?.velocity.dx)!
        let dy:CGFloat = (ballNode.physicsBody?.velocity.dy)!
        
        let speed:CGFloat = sqrt(dx*dx + dy*dy)
        
        if isMoving {
            if speed < 360 || fabs(dx) < 10 || fabs(dy) < 10 {
                ballNode.physicsBody?.applyImpulse(randomImpulse())
            }
            if speed < 30 {
                ballNode.physicsBody?.applyImpulse(randomImpulse())
            }
        }
        if speed <= 0 {
            isMoving = false
        }
        
        if ballIsOut() {
            returnAndStartAgain()
        }
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    // MARK: - Functions -
    
    func startGame(afterTime time:Int){
        let wait:SKAction = SKAction.wait(forDuration: TimeInterval(time))
        let move:SKAction = SKAction.run {
            self.startMoving()
        }
        let sequence:SKAction = SKAction.sequence([wait, move])
        self.run(sequence){
            self.lblCount.text = nil
        }
    }
    
    func showCountDown(count:Int){
        for i in (0...count).reversed() {
            fadeNumber(i, withDelay:TimeInterval(count-i))
        }
    }
    
    func fadeNumber(_ num:Int, withDelay delayTime:TimeInterval){
        if lblCount != nil {
            let scaleDown:SKAction = SKAction.scale(to: 0.001, duration: 0.01)
            let changeText:SKAction = SKAction.run({
                DispatchQueue.main.async {
                    self.lblCount.text = "\(num)"
                }
            })
            let before:SKAction = SKAction.group([scaleDown, changeText])
            
            let delay:SKAction = SKAction.wait(forDuration: delayTime as TimeInterval)
            
            let fadeIn:SKAction = SKAction.fadeIn(withDuration: 0.2)
            let scaleUp:SKAction = SKAction.scale(to: 1.0, duration: 0.2)
            let initGroup = SKAction.group([fadeIn,scaleUp])
            
            let wait:SKAction = SKAction.wait(forDuration: 0.5)
            
            let fadeOut:SKAction = SKAction.fadeOut(withDuration: 0.1)
            let scaleMore:SKAction = SKAction.scale(to: 3.0, duration: 0.1)
            let finishGroup:SKAction = SKAction.group([fadeOut, scaleMore])
            
            let sequence:SKAction = SKAction.sequence([delay, initGroup, wait, finishGroup])
            
            lblCount.run(sequence, completion: {
                self.lblCount.run(before){
                }
            })
        }
    }
    
    func startMoving(){
        if !isMoving {
            isMoving = true
            ballNode.physicsBody?.applyImpulse(randomImpulse())
        }
    }
    
    func randomImpulse() -> CGVector {
        let random:GKRandomSource = GKRandomSource.sharedRandom()
        var dx:Int = random.nextInt(upperBound: 50) + 20
        var dy:Int = random.nextInt(upperBound: 50) + 20
        let n1:Int = random.nextInt(upperBound: 100)
        let n2:Int = random.nextInt(upperBound: 100)
        
        if n1%3 == 0 {
            dx = -dx
        }
        if n2%3 == 0 {
            dy = -dy
        }
        
        return CGVector(dx: dx, dy: dy)
    }
    
    func barPhysicsBodyOfSize(_ size:CGSize) -> SKPhysicsBody {
        let bar:SKPhysicsBody = SKPhysicsBody(rectangleOf: size)
        bar.friction = 0.0
        bar.restitution = 1.0
        bar.isDynamic = false
        return bar
    }
    
    func ballIsOut() -> Bool {
        if ballNode.position.x < -self.size.width || ballNode.position.x > self.size.width {
            print("x out of bounds")
            return true
        }
        if ballNode.position.y < -self.size.height || ballNode.position.y > self.size.height {
            print("y out of bounds")
            return true
        }
        return false
    }
    
    func returnAndStartAgain(){
        isMoving = false
        ballNode.position = CGPoint.zero
        ballNode.physicsBody?.velocity = CGVector.zero
        ballNode.physicsBody?.angularVelocity = 0
        ballNode.physicsBody?.isResting = true
        ballNode.speed = 0
        
        showCountDown(count: COUNT_DOWN)
        startGame(afterTime: COUNT_DOWN + 1)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var first:SKPhysicsBody
        var second:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            first = contact.bodyA
            second = contact.bodyB
        } else {
            first = contact.bodyB
            second = contact.bodyA
        }
        
        if first.categoryBitMask == ballCategory {
            switch second.categoryBitMask {
                case bottomCategory:
                    if remainingLives > 0 {
                        remainingLives -= 1
                        removeHeart(remainingLives)
                    } else {
                        GlobalData.shared.maxScore = score
                        gameover()
                    }
                    break;
                case paddleCategory:
                    let dx:CGFloat = (ballNode.physicsBody?.velocity.dx)!
                    let dy:CGFloat = (ballNode.physicsBody?.velocity.dy)!
                    score += Double(sqrt(dx*dx + dy*dy) / 100.0)
                    break;
                default:
                    break;
            }
        }
    }
    
    func removeHeart(_ lives:Int){
        let name:String = String(format: "heart%d", lives)
        if let heart:SKSpriteNode = self.childNode(withName: name) as? SKSpriteNode {
            heart.removeFromParent()
        }
    }
    
    func gameover(){
        
        // Change scene
        let transition = SKTransition.fade(withDuration: 1)
        if let gameScene:SKScene = SKScene(fileNamed: "GameoverScene"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
}
