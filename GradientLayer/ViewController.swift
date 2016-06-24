import UIKit

class ViewController: UIViewController {

    // MARK: - Properties for gradient layer
    
    var gradientLayer = CAGradientLayer()
    var bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
    var location = [0.3, 0.9]
    var startPosition = CGPoint(x: 0, y: 0)
    var endPosition = CGPoint(x: 0.5, y: 1)
    var colors = [UIColor.redColor().CGColor, UIColor.greenColor().CGColor]
    
    // MARK: - Properties for gradient layer animation
    
    var animation = CABasicAnimation()
    var fromColors: [AnyObject]!
    var toColors: [AnyObject]!
    var duration = 6.0
    
    var fromLocation: [AnyObject]!
    var toLocation: [AnyObject]!
    
    var fromPos: [AnyObject]!
    var toPos: [AnyObject]!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawGradientLayer()
        
        toColors = [UIColor.blueColor().CGColor, UIColor.blueColor().CGColor]
        toLocation = [0.7, 1.0]
        toPos = [CGPoint(x: 0.5, y: 1), CGPoint(x: 1, y: 1)]
//        animateLayerWithColor()
//        animateLayerWithLocation()
        animateLayerWithPosition()
    }
    
    // MARK: - Private functions
    
    private func drawGradientLayer() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = location
        gradientLayer.startPoint = startPosition
        gradientLayer.endPoint = endPosition
        self.view.layer.addSublayer(gradientLayer)
    }
    
    private func animateLayerWithColor(){
        
        fromColors = self.gradientLayer.colors
        gradientLayer.colors = toColors
        
        animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = duration
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        gradientLayer.addAnimation(animation, forKey:"animateGradientColor")
    }
    
    private func animateLayerWithLocation() {
        fromLocation = self.gradientLayer.locations
        gradientLayer.locations = toLocation as? [NSNumber]
        animation = CABasicAnimation(keyPath: "locations")
        
        animation.fromValue = gradientLayer.locations
        animation.toValue = toLocation
        animation.duration = duration
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        gradientLayer.addAnimation(animation, forKey:"animateGradientLocation")
    }
    
    private func animateLayerWithPosition() {
        fromPos = self.gradientLayer.startPoint as! AnyObject
        gradientLayer.startPoint = toPos as! CGPoint
        animation = CABasicAnimation(keyPath: "position")
        
        animation.fromValue = gradientLayer.startPoint as? AnyObject
        animation.toValue = toPos
        animation.duration = duration
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        gradientLayer.addAnimation(animation, forKey:"animateGradientPosition")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
    }
    
    // MARK: - Delegate of CABasicAnimation
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.toColors = self.fromColors
        self.toLocation = self.fromLocation
        self.toPos = self.fromPos
//        animateLayerWithColor()
//        animateLayerWithLocation()
        animateLayerWithPosition()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
