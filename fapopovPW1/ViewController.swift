//
//  ViewController.swift
//  fapopovPW1
//
//  Created by Фома Попов on 10.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var upperLeftView: UIView!
    @IBOutlet weak var upperMiddleView: UIView!
    @IBOutlet weak var upperRightView: UIView!
    @IBOutlet weak var lowerLeftView: UIView!
    @IBOutlet weak var lowerMiddleView: UIView!
    @IBOutlet weak var lowerRIghtVIew: UIView!
    @IBOutlet weak var longView: UIView!
    @IBOutlet weak var bigVIew: UIView!
    @IBOutlet weak var smallView: UIView!
    
    // MARK: - Constants
    
    private enum Const {
        static let animationDuration: Double = 1.0
        static let maxRadius: CGFloat = 25
        static let digitsHex: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        static let hexColorLength: Int = 6
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        let views: [UIView] = [upperLeftView, upperMiddleView, upperRightView, lowerLeftView, lowerMiddleView, lowerRIghtVIew, longView, bigVIew, smallView]
        
        button.isEnabled = false
        UIView.animate(withDuration: Const.animationDuration, animations: {
            self.changeColor(views)
            self.changeCornerRadius(views)
        },
                       completion: { [weak self] _ in
            self?.button.isEnabled = true
        })
    }
    
    // MARK: - Private Methods
    
    private func changeCornerRadius(_ views: [UIView]) {
        for view in views {
            view.layer.cornerRadius = .random(in: 0...Const.maxRadius)
        }
    }
    
    private func checkIfColorsSimilar(_ color1: UIColor, _ color2: UIColor) -> Bool {
        let minDifference: CGFloat = 0.4
        
        var red1: CGFloat = 0.0
        var green1: CGFloat = 0.0
        var blue1: CGFloat = 0.0
        var alpha1: CGFloat = 0.0
        
        var red2: CGFloat = 0.0
        var green2: CGFloat = 0.0
        var blue2: CGFloat = 0.0
        var alpha2: CGFloat = 0.0

        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        
        if abs(red1 - red2) < minDifference && abs(green1 - green2) < minDifference && abs(blue1 - blue2) < minDifference {
            return true
        }
        return false
    }
    
    private func getUniqueColors(_ views: [UIView]) -> [UIColor] {
        var colors: [UIColor] = []
        
        while colors.count < views.count {
            var hexColor: String = "#"
            for _ in 0...(Const.hexColorLength - 1) {
                let index: Int = .random(in: 0...(Const.digitsHex.count - 1))
                hexColor += Const.digitsHex[index]
            }
            
            let newColor: UIColor = UIColor.convertToRGBInit(hexColor)
            var checkFlag: Bool = true
            for color in colors {
                if checkIfColorsSimilar(newColor, color) {
                    checkFlag = false
                }
            }
            if checkFlag {
                colors.append(newColor)
            }
        }
        
        return colors
    }
    
    private func changeColor(_ views: [UIView]) {
        var set = getUniqueColors(views)
        for view in views {
            view.backgroundColor = set.popLast()
        }
    }
    
}

