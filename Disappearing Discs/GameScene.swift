//
//  GameScene.swift
//  Disappearing Discs
//
//  Created by Nathan Toland on 9/5/16.
//  Copyright (c) 2016 Nathan Toland. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    let gameArea: CGRect
        
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)
        gameArea = CGRect(x: gameAreaMargin, y: 0, width: playableWidth, height: size.height)
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF )
    }
    
    func random(min min:CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "DiscsBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let disc = SKSpriteNode(imageNamed: "Disc2")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = "discObject"
        self.addChild(disc)
        
    }
    
    
    func spawnNewDisk(){
        
        var randomImageNumber = arc4random()%4
        randomImageNumber += 1
        
        
        let disc = SKSpriteNode(imageNamed: "Disc\(randomImageNumber)")
        disc.zPosition = 2
        disc.name = "discObject"
        
        let randomX = random(min: CGRectGetMinX(gameArea) + disc.size.width/2,
                             max: CGRectGetMaxX(gameArea) - disc.size.width/2)
        
        let randomY = random(min: CGRectGetMinY(gameArea) + disc.size.height/2,
                             max: CGRectGetMaxY(gameArea) + disc.size.height/2)
        
        disc.position = CGPoint(x: randomX, y: randomY)
        self.addChild(disc)
    
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
         
            let positionOfTouch = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            if nameOfTappedNode == "discObject"{
              tappedNode.removeFromParent()
              spawnNewDisk()
            }
        }
    }
    
    
}
