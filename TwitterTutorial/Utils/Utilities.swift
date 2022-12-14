//
//  Utilities.swift
//  TwitterTutorial
//
//  Created by Guowei Lv on 6.12.2022.
//

import Foundation
import UIKit

class Utilities {

    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let iv = UIImageView()
        iv.image = image
        view.addSubview(iv)

        iv.anchor(
            left: view.leftAnchor, bottom: view.bottomAnchor, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)

        view.addSubview(textField)
        textField.anchor(
            left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
            paddingLeft: 8, paddingBottom: 8)

        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(
            top: iv.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8,
            height: 0.75)
        return view
    }

    func textField(withPlaceHolder placeHolder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeHolder
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(
            string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        return tf
    }

    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)

        let attributedTitle = NSMutableAttributedString(
            string: firstPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ])

        attributedTitle.append(
            NSAttributedString(
                string: secondPart,
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                ]))

        button.setAttributedTitle(attributedTitle, for: .normal)

        return button

    }

}
