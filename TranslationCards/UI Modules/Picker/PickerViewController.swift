//
//  PickerViewController.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 10.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import UIKit

final class PickerViewController: ViewController<PickerRouter, PickerViewModel> {
    let pickerView = UIPickerView()
    
    let toolsStackView = UIStackView()
    let cancelButton = UIButton(type: .custom)
    let doneButton = UIButton(type: .custom)
    let titleLabel = UILabel()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { [weak self] in
        guard let self = self else { return }
            $0.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        
        view.addSubview(toolsStackView)
        toolsStackView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.left.right.equalTo(self.pickerView)
            $0.bottom.equalTo(self.pickerView.snp.top)
            $0.height.equalTo(50.0)
        }
        toolsStackView.addArrangedSubview(cancelButton)
        let firstDummyView = UIView()
        toolsStackView.addArrangedSubview(firstDummyView)
        toolsStackView.addArrangedSubview(titleLabel)
        let secondDummyView = UIView()
        toolsStackView.addArrangedSubview(secondDummyView)
        toolsStackView.addArrangedSubview(doneButton)
        
        firstDummyView.snp.makeConstraints {
            $0.width.equalTo(secondDummyView.snp.width)
        }
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        toolsStackView.axis = .horizontal
    }
    
    override func binding() {
        super.binding()
        viewModel
            .items
            .bind(to: pickerView.rx.itemTitles) {
                (row, element) in
                return element }
            .disposed(by: disposeBag)

        pickerView
            .rx
            .itemSelected
            .bind(to: viewModel.selectedItem)
            .disposed(by: disposeBag)
        
        pickerView.selectRow(viewModel.selectedItem.value.row,
                             inComponent: viewModel.selectedItem.value.component,
                             animated: false)

        viewModel
            .bind(cancelAction: cancelButton.rx.tap, doneAction: doneButton.rx.tap)
        
        viewModel
            .title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func localizable() {
        super.localizable()
        cancelButton.setTitle("  Cancel", for: .normal)
        doneButton.setTitle("Done  ", for: .normal)
        
        #if DEBUG
        titleLabel.text = "Title"
        #endif
    }
}
