//
//  PlaceholderTextView.swift
//  shinghaLibrary
//
//  Created by seongha shin on 2022/06/09.
//

import UIKit

class PlaceholderTextView: UITextView {
    
    var placeholder: String?
    
    private var placeholderLabel: UILabel?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    private func bind() {
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: nil) { _ in
            self.placeholderLabel?.isHidden = !self.text.isEmpty
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
                
        self.textContainer.lineFragmentPadding = 0
        let linePadding = self.textContainer.lineFragmentPadding
        let containerInset = self.textContainerInset
        let placeholderRect = CGRect(
            x: containerInset.left + linePadding,
            y: containerInset.top,
            width: rect.size.width - containerInset.left - containerInset.right - 2 * linePadding,
            height: rect.size.height - containerInset.top - containerInset.bottom)
        
        let label = UILabel(frame: placeholderRect)
        label.font = self.font
        label.textAlignment = self.textAlignment
        label.textColor = .gray
        label.text = placeholder
        label.sizeToFit()
        self.addSubview(label)
        placeholderLabel = label
    }
}
