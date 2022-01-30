//
//  LineGraph.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit

class LineGraph: UIView {
    var values: [CGFloat] = []
    
    init(frame: CGRect, values: [CGFloat]) {
        super.init(frame: frame)
        self.values = values
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
