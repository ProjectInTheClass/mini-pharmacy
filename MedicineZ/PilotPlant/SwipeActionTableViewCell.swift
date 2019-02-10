//
//  SwipeActionTableViewCell.swift
//  PilotPlantCatalog
//
//  Created by Lingostar on 2017. 4. 30..
//  Copyright © 2017년 LingoStar. All rights reserved.
//

import UIKit

class SwipeActionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}





class RightSwipeTableViewCell: SwipeActionTableViewCell {
    
    let offsetValue = CGFloat(76.0)
    
    var cellSize:CGSize = CGSize.zero
    
    var buttonView = UIView()
    
    @IBOutlet var rightButtons:[UIButton]! = []
    
    var swipe = UIPanGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellSize = self.frame.size
        self.backgroundView? = UIView(frame: self.frame)
        self.backgroundView?.backgroundColor = UIColor.clear
        buttonView.frame = self.contentView.frame
        
        setupCell()
        
        swipe.delegate = self
    }
    
    func setupCell() {
        
        _ = rightButtons.map {
            $0.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
        }
        
        let buttonsWidth = rightButtons.reduce(CGFloat(0.0), {
            let xPosition:CGFloat = $0 + $1.frame.size.width
            $1.frame = CGRect(origin:CGPoint(x:xPosition, y:0), size:$1.frame.size)
            self.buttonView.addSubview($1)
            return xPosition
        })
        
        buttonView.frame = CGRect(origin:CGPoint(x:cellSize.width, y:0), size:CGSize(width:buttonsWidth, height:buttonView.frame.size.height))
        
        self.addSubview(buttonView)
        
        swipe = UIPanGestureRecognizer(target: self, action: #selector(self.swipeAct))
        swipe.delegate = self
        self.contentView.addGestureRecognizer(swipe)
    }

    
    
    @objc func moveBack() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{
            self.buttonView.frame.origin = CGPoint(x: self.cellSize.width, y: 0)
        }, completion: nil)
    }
    
    
    /*func firstSet() {
     UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{ _ in
     self.mainView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:53)
     self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:53)
     self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:53)
     //            self.muteBtn.frame = CGRect(x:-152, y:0, width:152, height:71)
     //            self.pinBtn.frame = CGRect(x:-76, y:0, width:76, height:71)
     
     }, completion: nil)
     
     }*/
    
    @objc func swipeAct(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in:self)
        
        recognizer.setTranslation(CGPoint.zero, in: self)
        print(translation)
        
        if recognizer.state == UIGestureRecognizer.State.began{
            
        }
        
        if recognizer.state == UIGestureRecognizer.State.ended{
            self.contentView.center = CGPoint(x:contentView.center.x + translation.x , y:contentView.center.y)
            
           /* if self.contentView.center.x <= UIScreen.main.bounds.width/2 - offsetValue{
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{ _ in
                    self.contentView.frame = CGRect(x:-(self.offsetValue * 2), y:0, width:self.cellSize.width, height:self.cellSize.height)
                    self.rightButtons[0].frame = CGRect(x:self.cellSize.width - (self.offsetValue * 2), y:0, width:(self.offsetValue * 2), height:self.cellSize.height)
                    if let secondButton = self.rightButtons[1] as? UIButton {
                        secondButton.frame = CGRect(x:self.cellSize.width - self.offsetValue, y:0, width:self.offsetValue, height:self.cellSize.height)
                    }
                }, completion: nil)
                
            }else{*/
                /*UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{ _ in
                    self.mainView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:cellSize.height)
                    self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:cellSize.height)
                    self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:cellSize.height)
                }, completion: nil)*/
            //}
            
        }
        
        if recognizer.state == UIGestureRecognizer.State.changed{
            let cellCenterx = self.center.x
            let contentCenterx = self.contentView.center.x
            let offsetx = cellCenterx - contentCenterx
            if offsetx < buttonView.frame.width {
                let minValue = max(translation.x, -(buttonView.frame.width))
                let contentCenter = self.contentView.center
                self.contentView.center  = CGPoint(x:contentCenter.x + minValue , y:contentCenter.y)
            }
            
            //            //왼쪽으로 스와이프 할 때
            //            if self.mainView.center.x > UIScreen.main.bounds.width/2{
            //                if self.mainView.center.x >= UIScreen.main.bounds.width/2 + 152 {
            //                    self.muteBtn.center = CGPoint(x: 76, y:mainView.center.y)
            //                    self.pinBtn.center = CGPoint(x:38 , y: mainView.center.y)
            //                    self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:71)
            //                    self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:71)
            //                }else{
            //                    self.muteBtn.center = CGPoint(x:muteBtn.center.x + translation.x, y:mainView.center.y)
            //                    self.pinBtn.center = CGPoint(x: pinBtn.center.x + translation.x/2, y: mainView.center.y)
            //                    self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:71)
            //                    self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:71)
            //                }
            //
            //            }
            
        } else{
            
            
            
        }
    }
    
    
    
}

/* Yoon
class BothSideSwipableTableViewCell: RightSwipableTableViewCell {
    
    let pinBtn = UIButton()
    let muteBtn = UIButton()
    var pinImg = UIImageView()
    var muteImg = UIImageView()
    
    var leftSwipe = UIPanGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 53)
        
        setupForCell()
        
        leftSwipe.delegate = self
    }
    
    override func setupForCell() {
        hideBtn.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: 150, height: 53)
        hideBtn.backgroundColor = UIColor(hex: "c6c6cc")
        hideBtn.addTarget(self, action: #selector(self.firstSet), for: .touchUpInside)
        hideBtn.setTitle("Hide", for: .normal)
        addSubview(hideBtn)
        
        delBtn.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: 75, height: 53)
        delBtn.backgroundColor = UIColor(hex: "ff3600")
        delBtn.addTarget(self, action: #selector(self.firstSet), for: .touchUpInside)
        delBtn.setTitle("Block", for: .normal)
        addSubview(delBtn)
        
        muteBtn.frame = CGRect(x: -150, y: 0, width: 150, height: 53)
        muteBtn.backgroundColor = UIColor(hex: "5181e2")
        muteBtn.addTarget(self, action: #selector(self.firstSet), for: .touchUpInside)
        addSubview(muteBtn)
        
        muteImg.frame = CGRect(x: 97.5, y: 20.5, width: 30, height: 30)
        muteImg.image = UIImage(named: "chat_list_icon_notice_on")
        muteBtn.addSubview(muteImg)
        
        pinBtn.frame = CGRect(x: -75, y: 0, width: 75, height: 53)
        pinBtn.backgroundColor = UIColor(hex: "82a5e6")
        pinBtn.addTarget(self, action: #selector(self.firstSet), for: .touchUpInside)
        addSubview(pinBtn)
        
        pinImg.frame = CGRect(x: 22.5, y: 20.5, width: 30, height: 30)
        pinImg.image = UIImage(named: "chat_list_icon_pin_off")
        pinBtn.addSubview(pinImg)
        
        swipe = UIPanGestureRecognizer(target: self, action: #selector(self.swipeAct))
        swipe.delegate = self
        self.mainView.addGestureRecognizer(swipe)
        
    }
    
    override func firstSet() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{ _ in
            self.mainView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:71)
            self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:71)
            self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:71)
            self.muteBtn.frame = CGRect(x:-152, y:0, width:152, height:71)
            self.pinBtn.frame = CGRect(x:-76, y:0, width:76, height:71)
            
        }, completion: nil)
        
    }
    
    override func swipeAct(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in:self)
        
        recognizer.setTranslation(CGPoint.zero, in: self)
        print(translation)
        
        if recognizer.state == UIGestureRecognizerState.began{
            
        }
        
        if recognizer.state == UIGestureRecognizerState.ended{
            //    self.mainView.center = CGPoint(x:mainView.center.x + translation.x , y:mainView.center.y)
            if self.mainView.center.x <= UIScreen.main.bounds.width/2 - 76{
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{ _ in
                    self.mainView.frame = CGRect(x:-152.0, y:0, width:UIScreen.main.bounds.width, height:71)
                    self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width - 152, y:0, width:152, height:71)
                    self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width - 76, y:0, width:76, height:71)
                    
                }, completion: nil)
                
            }else if self.mainView.center.x >= UIScreen.main.bounds.width/2 + 76{
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{ _ in
                    self.mainView.frame = CGRect(x:152.0, y:0, width:UIScreen.main.bounds.width, height:71)
                    self.muteBtn.frame = CGRect(x:0, y:0, width:152, height:71)
                    self.pinBtn.frame = CGRect(x:0, y:0, width:76, height:71)
                    
                }, completion: nil)
                
                
            }else{
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations:{ _ in
                    self.mainView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:71)
                    self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:71)
                    self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:71)
                    self.muteBtn.frame = CGRect(x:-152, y:0, width:152, height:71)
                    self.pinBtn.frame = CGRect(x:-76, y:0, width:76, height:71)
                    
                }, completion: nil)
            }
            
        }
        
        if recognizer.state == UIGestureRecognizerState.changed{
            
            self.mainView.center = CGPoint(x:mainView.center.x + translation.x , y:mainView.center.y)
            
            //왼쪽으로 스와이프 할 때
            if self.mainView.center.x > UIScreen.main.bounds.width/2{
                if self.mainView.center.x >= UIScreen.main.bounds.width/2 + 152 {
                    self.muteBtn.center = CGPoint(x: 76, y:mainView.center.y)
                    self.pinBtn.center = CGPoint(x:38 , y: mainView.center.y)
                    self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:71)
                    self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:71)
                }else{
                    self.muteBtn.center = CGPoint(x:muteBtn.center.x + translation.x, y:mainView.center.y)
                    self.pinBtn.center = CGPoint(x: pinBtn.center.x + translation.x/2, y: mainView.center.y)
                    self.hideBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:152, height:71)
                    self.delBtn.frame = CGRect(x:UIScreen.main.bounds.width, y:0, width:76, height:71)
                }
                
            }
            
        } else{
            
            
            
        }
    }
    
}
 
 */
