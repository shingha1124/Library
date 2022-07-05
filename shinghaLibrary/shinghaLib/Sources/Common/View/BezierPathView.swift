//
//  BezierPathView.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/09.
//

import UIKit

final class BezierPathView: UIView {
    
    private let bezierPath = UIBezierPath()
    private let bezierLayer = CAShapeLayer()
    
    var strokeColor: CGColor = UIColor.clear.cgColor
    var lineWidth: CGFloat = 1
    var points: [CGPoint] = [] {
        didSet {
        }
    }
    var isHiddenStrock = false
    
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        isHidden = points.count < 2
        
        bezierPath.removeAllPoints()
        
        if points.count < 2 {
            return
        }
        
        let firstPoint = points[0]
        let lastPoint = points[points.count - 1]

        var fillPoints = points
        fillPoints.append(CGPoint(x: lastPoint.x, y: 0))
        fillPoints.append(CGPoint(x: firstPoint.x, y: 0))
        fillPoints.append(firstPoint)

        let pathCoords = fillPoints.map { self.getCoord($0, to: rect) }
        drawPath(pathCoords)

        layer.mask = bezierLayer
    }
    
    private func drawPath(_ coords: [CGPoint]) {
        bezierPath.move(to: coords[0])
        coords.dropFirst().forEach {
            bezierPath.addLine(to: $0)
        }
        
        bezierLayer.path = bezierPath.cgPath
        bezierLayer.strokeColor = strokeColor
        bezierLayer.lineWidth = lineWidth
        bezierLayer.lineJoin = .round
        bezierLayer.lineCap = .round
        
        if !isHiddenStrock {
            bezierPath.stroke()
        }
        
        bezierPath.close()
    }
    
    private func getCoord(_ point: CGPoint, to rect: CGRect) -> CGPoint {
        let coordX = rect.width * point.x
        let coordY = rect.height - (rect.height * point.y)
        return CGPoint(x: coordX, y: coordY)
    }
}
