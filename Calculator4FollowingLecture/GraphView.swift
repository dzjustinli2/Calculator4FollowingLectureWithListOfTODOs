//
//  GraphView.swift
//  Calculator4FollowingLectureWithListOfTODOs
//
//  Created by justin on 10/08/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    var graphCenterOriginInParentView: CGPoint! {
        didSet {
            setNeedsDisplay()
        }
    }
    private var color: UIColor = UIColor.orangeColor(){
        didSet {
            setNeedsDisplay()
        }
    }
    private var pointsPerUnit: CGFloat = 100{
        didSet {
            setNeedsDisplay()
        }
    }
    private var localContentScaleFactor: CGFloat {
        return contentScaleFactor
    }
    private var axesDrawer: AxesDrawer?
    var boundsBeforeScreenRotation: CGRect?

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //in the original "Calculator assignment 3 from github account MichelDeiman StanfordCS193P2016-Calculator-III-master" project, if "graphCenterOriginInParentView" and "axesDrawer" is equal to nil, then the intialisation is done inside "func drawRect(rect: CGRect) {}",
        if graphCenterOriginInParentView == nil {
            graphCenterOriginInParentView = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        }
        if boundsBeforeScreenRotation != nil {
            graphCenterOriginInParentView.x *= (bounds.width / boundsBeforeScreenRotation!.width)
            graphCenterOriginInParentView.y *= (bounds.height / boundsBeforeScreenRotation!.height)
            boundsBeforeScreenRotation = nil
        }
        if axesDrawer == nil {
            axesDrawer = AxesDrawer(color: color, contentScaleFactor: localContentScaleFactor)
        }
        
        axesDrawer?.drawAxesInRect(bounds, origin: graphCenterOriginInParentView, pointsPerUnit: pointsPerUnit)
    }
    
    func zoom(recognizer: UIPinchGestureRecognizer){
        switch recognizer.state {
        case .Began, .Changed:
            pointsPerUnit *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

//TODO: 1) IF I initialise "graphCenterOriginInParentView" and "axesDrawer" in "required init?(coder aDecoder: NSCoder) {}", then when the axes of the graph is drawn, "graphCenterOriginInParentView", which is the origin of the graph axes, is not in the center of the screen of the device. When I used debugger, the value of x and y for "graphCenterOriginInParentView" is 300, 300, and the "bounds.width" and "bounds.height" for the view is 600, 600, which means that in "required init?(coder aDecoder: NSCoder) {}", the view is not yet been initalised to the size of the device screen and it is still has the same size as the view in the storyboard. Find out more about it
        
//TODO: 2)IF I initialise "graphCenterOriginInParentView" and "axesDrawer" in "required init?(coder aDecoder: NSCoder) {}" instead of "override func drawRect(rect: CGRect) {}". then the "setNeedsDisplay()" in "var graphCenterOriginInParentView: CGPoint { didSet { setNeedsDisplay() } }" is not called. find out more about it
        
//        //in the original "Calculator assignment 3 from github account MichelDeiman StanfordCS193P2016-Calculator-III-master" project, if "graphCenterOriginInParentView" and "axesDrawer" is equal to nil, then the intialisation is done inside "func drawRect(rect: CGRect) {}",
//        if graphCenterOriginInParentView == nil {
//            graphCenterOriginInParentView = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
//        }
//        if axesDrawer == nil {
//            axesDrawer = AxesDrawer(color: color, contentScaleFactor: localContentScaleFactor)
//        }
    }
}
