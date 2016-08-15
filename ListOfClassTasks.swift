//
//  ListOfClassTasks.swift
//  Calculator4FollowingLectureWithListOfTODOs
//
//  Created by justin on 10/08/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import Foundation


//TODO: 1) IF I initialise "graphCenterOriginInParentView" and "axesDrawer" in "required init?(coder aDecoder: NSCoder) {}", then when the axes of the graph is drawn, "graphCenterOriginInParentView", which is the origin of the graph axes, is not in the center of the screen of the device. When I used debugger, the value of x and y for "graphCenterOriginInParentView" is 300, 300, and the "bounds.width" and "bounds.height" for the view is 600, 600, which means that in "required init?(coder aDecoder: NSCoder) {}", the view is not yet been initalised to the size of the device screen and it is still has the same size as the view in the storyboard. Find out more about it

//TODO: 2)IF I initialise "graphCenterOriginInParentView" and "axesDrawer" in "required init?(coder aDecoder: NSCoder) {}" instead of "override func drawRect(rect: CGRect) {}". then the "setNeedsDisplay()" in "var graphCenterOriginInParentView: CGPoint { didSet { setNeedsDisplay() } }" is not called. find out more about it

//TODO: 3) try different way of initlaising a gesutre recognizer. First, add "UIPinchGestureRecognizer" in "GraphViewController" but call method "func zoom(recognizer: UIPinchGestureRecognizer){}" in "GraphView" class. Second, add "UIPanGestureRecognizer" in "GraphViewController" class and call method "func pan(recognizer: UIPanGestureRecognizer){}" in the same class. Third, add "UITapGestureRecognizer" in storyboard and call "func tap(recognizer: UITapGestureRecognizer)" in "GraphViewController" class. ALL SUCCESSFULL!! YEAH!! 