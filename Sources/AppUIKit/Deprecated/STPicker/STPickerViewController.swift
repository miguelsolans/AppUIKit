//
//  STPickerViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 28/02/2024.
//

import UIKit

public enum STPickerStyle {
    case singleLabel
    case doubleLabel
}

protocol STPickerViewControllerDelegate : AnyObject {
    func didSelectOption(_ option: STPickerOption);
}

class STPickerViewController: UIViewController {
    /// ViewControllers and Delegates
    weak var delegate: STPickerViewControllerDelegate?
    
    /// Properties
    fileprivate var searching = false;
    fileprivate let pickerStyle: STPickerStyle;
    fileprivate let pickerWithSearch : Bool;
    public var searchResults = [STPickerOption]();
    public let options: [STPickerOption];
    
    
    /// UI Components
    fileprivate let tableView = UITableView();
    fileprivate let searchBar = UISearchBar();
    
    init(options: [STPickerOption], withSearch search: Bool, andStyle pickerStyle: STPickerStyle) {
        self.pickerWithSearch = search;
        self.options = options
        self.pickerStyle = pickerStyle;
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTable();
        self.style();
        self.layout();
    }
}

// MARK: Layout and Styling
extension STPickerViewController {
    func style() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout() {
        
        self.view.addSubview(self.tableView);
        if(self.pickerWithSearch) {
            self.view.addSubview(self.searchBar);
            
            NSLayoutConstraint.activate([
                self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                self.searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            ]);
        }
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.pickerWithSearch ? self.searchBar.bottomAnchor : self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]);
    }
    
    
    func setupTable() {
        self.tableView.register(STPickerDoubleLabelTableViewCell.self, forCellReuseIdentifier: getReusableIdentifier())
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.estimatedRowHeight = 80;
        self.tableView.rowHeight = UITableView.automaticDimension;
        
        self.searchBar.delegate = self;
    }
}

extension STPickerViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.pickerStyle == .doubleLabel) {
            let cell = tableView.dequeueReusableCell(withIdentifier: getReusableIdentifier(), for: indexPath) as! STPickerDoubleLabelTableViewCell
            
            let option = self.searching ? self.searchResults[ indexPath.row ] : self.options[ indexPath.row ];
            
            cell.updateWithLabel(text: option.label, andSubText: option.subLabel ?? "")
            
            return cell;
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: getReusableIdentifier(), for: indexPath)
            
            cell.textLabel?.text = self.searching ? self.searchResults[indexPath.row].label : self.options[ indexPath.row ].label;
            
            return cell;
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        self.delegate?.didSelectOption(self.searching ? self.searchResults[ indexPath.row ] : self.options[ indexPath.row ]);
        
        self.dismiss(animated: true);
    }
    
}

extension STPickerViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searching ? self.searchResults.count : self.options.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.pickerStyle {
        case .singleLabel:
            return 44;
        case .doubleLabel:
            return 80;
        }
    }
    
}

extension STPickerViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searching = true;
        
        self.searchResults = self.options.filter() { $0.label.lowercased().contains(searchText.lowercased()) };
        
        
        self.tableView.reloadData();
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false;
        self.searchBar.text = "";
        self.tableView.reloadData();
    }
}


extension STPickerViewController {
    fileprivate func getReusableIdentifier() -> String {
        switch self.pickerStyle {
        case .singleLabel:
            return "SingleLabel";
        case .doubleLabel:
            return STPickerDoubleLabelTableViewCell.reusableIdentifier;
        }
    }
}

#Preview("STPickerViewController ViewController") {
    let options = [
        STPickerOption(id: "0", label: "First Test", subLabel: "A First sublabel"),
        STPickerOption(id: "1", label: "Second Test", subLabel: "A Second sublabel"),
        STPickerOption(id: "2", label: "Third Test", subLabel: "A Third sublabel"),
        STPickerOption(id: "3", label: "Fourth Test", subLabel: "A Fourth sublabel")
    ];
    let viewController = STPickerViewController(options: options, withSearch: true, andStyle: .singleLabel);
    
    return viewController
}
