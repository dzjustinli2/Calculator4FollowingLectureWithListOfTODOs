//
//  GraphViewController.swift
//  Calculator4FollowingLectureWithListOfTODOs
//
//  Created by justin on 10/08/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    

    
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            setupGestureRecognizer()
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        //calling "super.viewWillTransitionToSize" becaseu the documentation told me so 
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        graphView.boundsBeforeScreenRotation = graphView.bounds
    }
    
    private func setupGestureRecognizer(){
        //TODO: 3) try different way of initlaising a gesutre recognizer. First, add "UIPinchGestureRecognizer" in "GraphViewController" but call method "func zoom(recognizer: UIPinchGestureRecognizer){}" in "GraphView" class. Second, add "UIPanGestureRecognizer" in "GraphViewController" class and call method "func pan(recognizer: UIPanGestureRecognizer){}" in the same class. Third, add "UITapGestureRecognizer" in storyboard and call "func tap(recognizer: UITapGestureRecognizer)" in "GraphViewController" class. ALL SUCCESSFULL!! YEAH!! 
        graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: #selector(graphView.zoom(_:))))
        graphView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(_:))))
    }
    
    @objc private func pan(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .Began, .Changed:
            let translation = recognizer.translationInView(graphView)
            graphView.graphCenterOriginInParentView.offsetBy(translation.x, yDirection: translation.y)
            recognizer.setTranslation(CGPointZero, inView: graphView)
        default:
            break
        }

    }

    
    @IBAction func tap(recognizer: UITapGestureRecognizer) {
        graphView.graphCenterOriginInParentView = recognizer.locationInView(graphView)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


