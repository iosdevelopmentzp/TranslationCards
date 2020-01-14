//
//  PickerViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class PickerViewController: ViewController<PickerRouter, PickerViewModel> {
    private let pickerView = UIPickerView()
    
    fileprivate let maskTransparenteView = UIView()
    fileprivate let containerView = UIView()
    private let topToolsStackView = UIStackView()
    private let toolsBackgroundView = UIView()
    private let cancelButton = UIButton(type: .custom)
    private let doneButton = UIButton(type: .custom)
    private let titleLabel = UILabel()
    
    // Constants
    fileprivate static let heightProportion: CGFloat = 0.3
    
    override init(viewModel: PickerViewModel) {
        super.init(viewModel: viewModel)
        transitioningDelegate = self
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        // transparent mask
        view.addSubview(maskTransparenteView)
        maskTransparenteView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // Container view
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(PickerViewController.heightProportion)
        }
        
        // Arranged views of stack view
        topToolsStackView.addArrangedSubview(cancelButton)
        let firstDummyView = UIView()
        topToolsStackView.addArrangedSubview(firstDummyView)
        topToolsStackView.addArrangedSubview(titleLabel)
        let secondDummyView = UIView()
        topToolsStackView.addArrangedSubview(secondDummyView)
        topToolsStackView.addArrangedSubview(doneButton)
        firstDummyView.snp.makeConstraints {
            $0.width.equalTo(secondDummyView.snp.width)
        }
        
        // stack view background view and stack view
        containerView.addSubview(toolsBackgroundView)
        containerView.addSubview(topToolsStackView)
        toolsBackgroundView.snp.makeConstraints {[weak self] in
            guard let self = self else { return }
            $0.edges.equalTo(self.topToolsStackView)
        }

        topToolsStackView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(50.0)
        }
        
        // picker view
        containerView.addSubview(pickerView)
        pickerView.snp.makeConstraints { [weak self] in
        guard let self = self else { return }
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(self.topToolsStackView.snp.bottom)
        }
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .clear
        maskTransparenteView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        topToolsStackView.axis = .horizontal
        
        toolsBackgroundView.backgroundColor = .pickerViewToolsPanelColor
        pickerView.backgroundColor = .pickerViewColor
        
        doneButton.titleLabel?.font = .font(type: .roboto, weight: .bold)
        cancelButton.titleLabel?.font = .font(type: .roboto, weight: .regular)
        titleLabel.font = .font(type: .roboto, weight: .bold)
        
        cancelButton.setTitleColor(UIColor.cancelButton, for: .normal)
        doneButton.setTitleColor(.pickerViewButtonTitleColor, for: .normal)
        titleLabel.textColor = .mainBackgroundColor
    }
    
    override func binding() {
        super.binding()
        let output = viewModel.output
        let input = viewModel.input
        
        output
            .items
            .bind(to: pickerView.rx.itemTitles) {
                (row, element) in
                return element }
            .disposed(by: disposeBag)

        pickerView
            .rx
            .itemSelected
            .bind(to: input.selectedItem)
            .disposed(by: disposeBag)

        cancelButton
            .rx.tap
            .bind(to: input.cancelTap)
            .disposed(by: disposeBag)
        
        doneButton
            .rx.tap
            .bind(to: input.doneTap)
            .disposed(by: disposeBag)
        
        pickerView.selectRow(output.selectedItem.value.row,
                             inComponent: output.selectedItem.value.component,
                             animated: false)
    }
    
    override func localize() {
        super.localize()
        cancelButton.setTitle("  Cancel", for: .normal)
        doneButton.setTitle("Done  ", for: .normal)
        viewModel.output.titleLabelText.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
    }
}

extension PickerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PickerViewPresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PickerViewDismissAnimator()
    }
}

class PickerViewPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let pickerVC = transitionContext.viewController(forKey: .to) as? PickerViewController else {
                transitionContext.completeTransition(true)
                return
        }
        
        let duration = transitionDuration(using: transitionContext)
        Timer.scheduledTimer(withTimeInterval: duration,
                             repeats: false) { (_) in
            transitionContext.completeTransition(true)
        }

        transitionContext.containerView.addSubview(pickerVC.view)

        pickerVC.maskTransparenteView.alpha = 0.0
        UIView.animate(withDuration: duration) { [weak pickerVC] in
            pickerVC?.maskTransparenteView.alpha = 1.0
        }
        
        let heightContainerViwe = pickerVC.view.bounds.height * PickerViewController.heightProportion
        let transformAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        transformAnimation.duration = duration
        transformAnimation.fromValue = heightContainerViwe
        transformAnimation.toValue = 0
        transformAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        transformAnimation.fillMode = .forwards
        transformAnimation.isRemovedOnCompletion = false
        pickerVC.containerView.layer.add(transformAnimation, forKey: "transform")
    }
}

class PickerViewDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let pickerVC = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(true)
            return
        }
        
        let duaration = transitionDuration(using: transitionContext)
        pickerVC.view.removeFromSuperview()
        
        Timer.scheduledTimer(withTimeInterval: duaration,
                             repeats: false) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
