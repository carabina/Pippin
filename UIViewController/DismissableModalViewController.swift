//
//  DismissableModalViewController.swift
//  shared-utils
//
//  Created by Andrew McKnight on 10/23/16.
//  Copyright © 2016 Two Ring Software. All rights reserved.
//

import Anchorage
import UIKit

class DismissableModalViewController: UIViewController {

    private var closeBlock: ((Void) -> Void)?

    init(childViewController: UIViewController, titleFont: UIFont, backgroundColor: UIColor = .clear, onClose closeBlock: ((Void) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = backgroundColor

        addChildViewController(childViewController)
        title = childViewController.title

        let titleAndCloseButtonView = UIView(frame: .zero)

        let closeButton = UIButton.button(withImageSetName: "close", emphasisSuffix: "-filled", tintColor: .black)
        titleAndCloseButtonView.addSubview(closeButton)
        closeButton.topAnchor == titleAndCloseButtonView.topAnchor
        closeButton.bottomAnchor == titleAndCloseButtonView.bottomAnchor
        closeButton.trailingAnchor == titleAndCloseButtonView.trailingAnchor - 10
        closeButton.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        let titleLabel = UILabel.label(withText: title ?? "", font: titleFont, alignment: .center)
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.allowsDefaultTighteningForTruncation = true

        titleAndCloseButtonView.addSubview(titleLabel)
        titleLabel.centerYAnchor == titleAndCloseButtonView.centerYAnchor
        titleLabel.leadingAnchor == titleAndCloseButtonView.leadingAnchor + 10
        titleLabel.trailingAnchor <= closeButton.leadingAnchor - 10

        let contentView = UIView(frame: .zero)
        contentView.addSubview(childViewController.view)
        childViewController.view.fillSuperview()

        let stack = UIStackView(arrangedSubviews: [
            titleAndCloseButtonView,
            contentView
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        view.addSubview(stack)
        titleAndCloseButtonView.widthAnchor == stack.widthAnchor
        stack.fillSuperview(insets: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))

        self.closeBlock = closeBlock
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func closeButtonTapped() {
        closeBlock?()
    }

}
