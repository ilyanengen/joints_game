//
//  GameScene.swift
//  InverseKinematics
//
//  Created by Ilya B Macmini on 28/03/2020.
//  Copyright © 2020 ilyabiltuev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var selectedNode: SKNode?
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // No need in touch handle if we already have selected node
        guard selectedNode == nil else { return }
        
        guard let touch = touches.first else { return }
        
        let locationInScene = touch.location(in: self)
        
        let touchedNodes = self.nodes(at: locationInScene)

        touchedNodes.map { print($0.name) }
        
        selectedNode = touchedNodes.first
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, let node = self.selectedNode {
        
            let touchLocation = touch.location(in: self)
            
//            node.position = touchLocation

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        selectedNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        selectedNode = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
