//
//  SwiftHSVColorPicker.swift
//  SwiftHSVColorPicker
//
//  Created by johankasperi on 2015-08-20.
//

import UIKit

public class SwiftHSVColorPicker: UIView {
    var colorWheel: ColorWheel!
    var brightnessView: BrightnessView!
    var selectedColorView: SelectedColorView!

    public var color: UIColor!
    var hue: CGFloat = 1.0
    var saturation: CGFloat = 1.0
    var brightness: CGFloat = 1.0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setViewColor(color: UIColor) {
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0, alpha: CGFloat = 0.0
        let ok: Bool = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if (!ok) {
            print("SwiftHSVColorPicker: exception <The color provided to SwiftHSVColorPicker is not convertible to HSV>")
        }
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.color = color
        setup()
    }
    
    func setup() {
        // Remove all subviews
        let views = self.subviews
        for view in views {
            view.removeFromSuperview()
        }

        let width = self.bounds.width
        
        // Init SelectedColorView subview
        selectedColorView = SelectedColorView(frame: CGRect(x: 0, y:0, width: width, height: 44), color: self.color)
        // Add selectedColorView as a subview of this view
        self.addSubview(selectedColorView)
        
        // Init new ColorWheel subview
        colorWheel = ColorWheel(frame: CGRect(x: 0, y: 44, width: width, height: width), color: self.color)
        colorWheel.delegate = self
        // Add colorWheel as a subview of this view
        self.addSubview(colorWheel)
        
        // Init new BrightnessView subview
        brightnessView = BrightnessView(frame: CGRect(x: 0, y: width+44, width: width, height: 26), color: self.color)
        brightnessView.delegate = self
        // Add brightnessView as a subview of this view
        self.addSubview(brightnessView)
    }
    
    func hueAndSaturationSelected(hue: CGFloat, saturation: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: 1.0)
        brightnessView.setViewColor(self.color)
        selectedColorView.setViewColor(self.color)
    }
    
    func brightnessSelected(brightness: CGFloat) {
        self.brightness = brightness
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: 1.0)
        colorWheel.setViewBrightness(brightness)
        selectedColorView.setViewColor(self.color)
    }
}
