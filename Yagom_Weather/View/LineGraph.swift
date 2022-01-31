//
//  LineGraph.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class LineGraph: UIView {
    var values: [CGFloat] = []
    var sortedValues: [CGFloat] = []
    var graphPath: UIBezierPath!
    var color: CGColor!
    let graphLayer = CAShapeLayer()
    var isTemp: Bool!
    init(frame: CGRect, values: [CGFloat], color: CGColor, isTemp: Bool) {
        super.init(frame: frame)
        self.values = values
        self.color = color
        self.isTemp = isTemp
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.graphPath = UIBezierPath()
        if isTemp {
            graphTempDraw(graphLayer: graphLayer, values: values, color: color)
        } else {
            graphHumidityDraw(graphLayer: graphLayer, values: values, color: color)
        }
    }
    func graphTempDraw(graphLayer: CAShapeLayer, values: [CGFloat], color: CGColor) {
        self.layer.addSublayer(graphLayer)
        
        let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
        
        var currentX: CGFloat = 0
        let startPosition: CGPoint = CGPoint(x: currentX, y: (self.frame.height / 2) - (values[0] * 10) - 50)
        self.graphPath.move(to: startPosition)
        for i in 1..<values.count {
            currentX += xOffset
            let newPosition = CGPoint(x: currentX,
                                      y: (self.frame.height / 2) - (values[i] * 10) - 50)
            self.graphPath.addLine(to: newPosition)
        }
        let removedDuplicate: Set = Set(values)
        sortedValues = Array(removedDuplicate)
        sortedValues.sort()
        for i in 0..<sortedValues.count {
            let textView = UITextView(frame: CGRect(x: -30, y: (self.frame.height / 2) - sortedValues[i] * 10 - 50, width: 100, height: 24))
            textView.text = Int(sortedValues[i]).description
            textView.backgroundColor = .none
            self.addSubview(textView)
        }
        graphLayer.fillColor = nil
        graphLayer.strokeColor = color
        graphLayer.lineWidth = 2
        graphLayer.path = self.graphPath.cgPath
    }
    
    func graphHumidityDraw(graphLayer: CAShapeLayer, values: [CGFloat], color: CGColor) {
        self.layer.addSublayer(graphLayer)
        
        let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
        
        var currentX: CGFloat = 0
        let startPosition: CGPoint = CGPoint(x: currentX, y: (self.frame.height / 2) - values[0])
        self.graphPath.move(to: startPosition)
        for i in 1..<values.count {
            currentX += xOffset
            let newPosition = CGPoint(x: currentX,
                                      y: (self.frame.height / 2) - values[i])
            self.graphPath.addLine(to: newPosition)
        }
        for i in stride(from: 0, through: 100, by: 10) {
            let textView = UITextView(frame: CGRect(x: Int(self.frame.width), y: Int(self.frame.height / 2) - i, width: 100, height: 24))
            textView.text = i.description
            textView.backgroundColor = .none
            self.addSubview(textView)
        }
        graphLayer.fillColor = nil
        graphLayer.strokeColor = color
        graphLayer.lineWidth = 2
        graphLayer.path = self.graphPath.cgPath
    }
}
