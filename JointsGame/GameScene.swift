//
//  GameScene.swift
//  InverseKinematics
//
//  Created by Ilya B Macmini on 28/03/2020.
//  Copyright © 2020 ilyabiltuev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var selectedNode: SKNode?
    
    override func didMove(to view: SKView) {
        
        configureScene()
        
        loadPinJointLevel()
    }
    
    func configureScene() {
        
        self.backgroundColor = .lightGray
        self.name = "scene";
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    // MARK: - Add joints
    
    func loadPinJointLevel() {
        
        let bodyA = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
        bodyA.position = CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2-bodyA.size.height/2);
        bodyA.physicsBody = SKPhysicsBody(rectangleOf: bodyA.size)
        bodyA.physicsBody?.isDynamic = true
        bodyA.physicsBody?.density = 1
        bodyA.name = "bodyA"
        self.addChild(bodyA)
        
        let bodyB = SKSpriteNode(color: .blue, size: CGSize(width: 20, height: 80))
        bodyB.position = CGPoint(x:bodyA.position.x, y:bodyA.position.y-bodyA.size.height/2-bodyB.size.height/2)
        bodyB.physicsBody = SKPhysicsBody(rectangleOf: bodyA.size)
        bodyB.physicsBody?.isDynamic = true
        bodyB.physicsBody?.density = 1
        bodyB.name = "bodyB"
        self.addChild(bodyB)
        
        let anchor = CGPoint(x:bodyA.position.x, y:bodyA.position.y-bodyA.size.height/2)
        let joint = SKPhysicsJointPin.joint(withBodyA: bodyA.physicsBody!, bodyB: bodyB.physicsBody!, anchor: anchor)
        
        joint.shouldEnableLimits = true
        
        let angle: CGFloat = 90.0
        
        // The smallest angle allowed for the pin joint, in radians.
        joint.lowerAngleLimit = -angle.degreesToRadians()
        
        // The largest angle allowed for the pin joint, in radians.
        joint.upperAngleLimit = angle.degreesToRadians()
        
        // The resistance applied by the pin joint to spinning around the anchor point.
        // Ranges from 0.0 to 1.0
        joint.frictionTorque = 0.0;
        
        self.physicsWorld .add(joint)
    }
    
//    func loadLimitJointLevel {
//        TouchedSpriteNode *bodyA = [TouchedSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
//        bodyA.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-bodyA.size.height/2);
//        bodyA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
//        bodyA.physicsBody.dynamic = YES;
//        bodyA.physicsBody.density = 1;
//        [self addChild:bodyA];
//
//        TouchedSpriteNode *bodyB = [TouchedSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(40, 40)];
//        bodyB.position = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height+80);
//        bodyB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bodyA.size];
//        bodyB.physicsBody.dynamic = NO;
//        bodyB.physicsBody.density = 1;
//        [self addChild:bodyB];
//
//        CGPoint anchorA = CGPointMake(bodyA.position.x, bodyA.position.y+bodyA.size.height/2);
//        CGPoint anchorB = CGPointMake(bodyB.position.x, bodyB.position.y-bodyB.size.height/2);
//        SKPhysicsJointLimit *joint = [SKPhysicsJointLimit jointWithBodyA:bodyA.physicsBody bodyB:bodyB.physicsBody anchorA:anchorA anchorB:anchorB];
//
//        // The maximum distance allowed between the two physics bodies connected by the limit joint.
//        //joint.maxLength = 40;
//
//        [self.physicsWorld addJoint:joint];
//    }
    
    // MARK: - Touches handle
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // No need in touch handle if we already have selected node
        guard selectedNode == nil else { return }
        
        guard let touch = touches.first else { return }
        
        let locationInScene = touch.location(in: self)
        
        let touchedNodes = self.nodes(at: locationInScene)

        selectedNode = touchedNodes.first
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, let node = self.selectedNode {
        
            let touchLocation = touch.location(in: self)
            
            selectedNode?.position = touchLocation
                        
            print("touchLocation = \(touchLocation), node = \(node)")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        selectedNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        selectedNode = nil
    }
    
    // MARK: - Update
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
