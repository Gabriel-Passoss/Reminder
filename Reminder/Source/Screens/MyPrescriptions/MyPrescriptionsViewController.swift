//
//  MyPrescriptionsViewViewController.swift
//  Reminder
//
//  Created by Gabriel Passos on 19/12/25.
//

import UIKit

class MyPrescriptionsViewController: UIViewController {
    let contentView: MyPrescriptionsView
    private var prescriptions: [Prescription] = []
    
    init(view: MyPrescriptionsView) {
        self.contentView = view
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTable()
        loadPrescriptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPrescriptions()
    }
    
    private func setup() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        self.setupContentViewToBounds(contentView)
    }
    
    private func setupTable() {
        contentView.prescriptionsTable.dataSource = self
        contentView.prescriptionsTable.delegate = self
        contentView.prescriptionsTable.register(PrescriptionTableViewCell.self, forCellReuseIdentifier: PrescriptionTableViewCell.identifier)
    }
    
    private func loadPrescriptions() {
        prescriptions = DatabaseManager.shared.fetchPrescriptions()
        contentView.prescriptionsTable.reloadData()
    }
}

extension MyPrescriptionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrescriptionTableViewCell.identifier, for: indexPath) as! PrescriptionTableViewCell
        let prescription = prescriptions[indexPath.section]
        
        cell.configure(title: prescription.remedy, time: prescription.time, recurrence: prescription.recurrence)
        
        cell.handleDelete = { [weak self] in
            guard let self = self else { return }
            
            if let currentIndexPath = tableView.indexPath(for: cell) {
                if currentIndexPath.section < self.prescriptions.count {
                    DatabaseManager.shared.deleteReceipt(byId: self.prescriptions[currentIndexPath.section].id)
                    self.prescriptions.remove(at: currentIndexPath.section)
                    
                    tableView.deleteSections(IndexSet(integer: currentIndexPath.section), with: .automatic)
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return prescriptions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

extension MyPrescriptionsViewController: MyPrescriptionsViewDelegate {
    func didBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func didAddButtonTapped() {
        // TODO: Navigate to add new prescription
    }
}
