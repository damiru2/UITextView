//
//  ViewController.swift
//  UITextView
//
//  Created by Damir Chalkarov on 24.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    let toTopButton = UIButton()
    var mode = Mode.edit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTF.delegate = self
        
        titleTF.borderStyle = .roundedRect
        titleTF.layer.borderWidth = 1
        titleTF.layer.cornerRadius = 10
        titleTF.layer.borderColor = UIColor.gray.cgColor
        
        descriptionTV.layer.borderWidth = 1
        descriptionTV.layer.cornerRadius = 10
        descriptionTV.layer.borderColor = UIColor.gray.cgColor
        
        descriptionTV.dataDetectorTypes = [.link, .phoneNumber]
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.green
        shadow.shadowBlurRadius = 15
        
        descriptionTV.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.shadow: shadow
        
        ]
        descriptionTV.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        descriptionTV.text = """

        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
https://www.lipsum.com

"""
        view.addSubview(toTopButton)
        toTopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toTopButton.topAnchor.constraint(equalTo: descriptionTV.bottomAnchor, constant: 20),
            toTopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toTopButton.heightAnchor.constraint(equalToConstant: 20),
            toTopButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        toTopButton.setTitle("to top", for: .normal)
        toTopButton.setTitleColor(.blue, for: .normal)
        toTopButton.addTarget(self, action: #selector(toTop), for: .touchUpInside)
        
        descriptionTV.keyboardAppearance = .default
        descriptionTV.keyboardDismissMode = .onDrag

}
    @objc func toTop() {
        descriptionTV.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        mode.togle()
        let buttonTitle = mode == .preview ? "Edit" : "Preview"
        let toValue: CGFloat = mode == .preview ? 0 : 1
        
        UIView.animate(withDuration: 1) {
            sender.setTitle(buttonTitle, for: .normal)
        }
        
        titleTF.animateBorderWidth(toValue: toValue, duration: 0.5)
        descriptionTV.animateBorderWidth(toValue: toValue, duration: 0.5)
        descriptionTV.isEditable = mode == .edit
    }
    
}

    extension ViewController: UITextFieldDelegate {
        
    }

extension ViewController: UITextViewDelegate {
    
}

extension UIView {
    func animateBorderWidth(toValue: CGFloat, duration: Double) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
    }
}

enum Mode {
    case preview
    case edit
    
    mutating func togle() {
        switch self {
        case .preview: self = .edit
        case .edit: self = .preview
        }
    }
}
