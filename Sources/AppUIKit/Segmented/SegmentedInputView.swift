//
//  SegmentedInputView.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/03/2026.
//

import UIKit

public final class SegmentedInputView: BaseInputView {

    // MARK: UI Components
    private let segmentedControl = UISegmentedControl()
    
    public var segmentedViewModel: SegmentedInputViewModel {
        return super.viewModel as! SegmentedInputViewModel
    }

    // MARK: Init
    public init(viewModel: SegmentedInputViewModel, style: InputStyle = InputStyle()) {
        super.init(viewModel: viewModel, style: style)
        setupUI()
        updateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: Setup
    private func setupUI() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        userInputView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: userInputView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: userInputView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: userInputView.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: userInputView.bottomAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: Update UI
    public override func updateUI() {
        super.updateUI()
        
        segmentedControl.removeAllSegments()
        for (index, option) in segmentedViewModel.options.enumerated() {
            segmentedControl.insertSegment(withTitle: option, at: index, animated: false)
        }
        
        if let selectedIndex = segmentedViewModel.selectedIndex, selectedIndex < segmentedControl.numberOfSegments {
            segmentedControl.selectedSegmentIndex = selectedIndex
        } else {
            segmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        }
        
        segmentedControl.isEnabled = segmentedViewModel.isEditable
    }

    // MARK: Actions
    @objc private func selectionChanged() {
        let index = segmentedControl.selectedSegmentIndex
        segmentedViewModel.selectedIndex = index == UISegmentedControl.noSegment ? nil : index
        segmentedViewModel.onSelectionChanged?(segmentedViewModel.selectedIndex)
    }
}

// MARK: - Swift Macros
#Preview("SegmentedInputView") {
    
    let viewModel = SegmentedInputViewModel(title: "Title", options: ["Income", "Expense"], selectedIndex: 0, isEditable: true, placeholder: "Placeholder", subtitle: "Subtitle", isMandatory: false)
    
    let style = InputStyle()
    let inputView = SegmentedInputView(viewModel: viewModel, style: InputStyle())
    
    inputView.showBottomLabel("This is an informative label below the segmented control.", type: .informativeType)
    
    let vc = UIViewController()
    vc.view.backgroundColor = .systemBackground
    
    inputView.translatesAutoresizingMaskIntoConstraints = false
    vc.view.addSubview(inputView)
    
    NSLayoutConstraint.activate([
        inputView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
        inputView.centerYAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.centerYAnchor),
        inputView.leadingAnchor.constraint(greaterThanOrEqualTo: vc.view.leadingAnchor, constant: 16),
        inputView.trailingAnchor.constraint(lessThanOrEqualTo: vc.view.trailingAnchor, constant: -16)
    ])
    
    return vc
}
