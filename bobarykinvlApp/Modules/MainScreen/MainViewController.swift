//
//  ViewController.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 17.12.22.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let coreDataManager = CoreDataManager()
    private let transitionManagerCoordinator = TransitionManagerCoordinator()
    private let alert = Alert()
    private var didSelectRow: Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coreDataManager.fetchRequestAnimation()
        coreDataManager.getDataFromFile()
    }
    
    @IBAction func addAnimation(_ sender: Any) {
        let alertViewController = alert.getAlertController(tableView: tableView)
        present(alertViewController, animated: true)
    }
}

// MARK: UITableViewDelegate and UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainScreen", for: indexPath) as? MainScreenTableViewCell else { return UITableViewCell() }
        let animation = animations[indexPath.row]
        cell.configure(title: animation.title ?? "", description: animation.descriptionAnimation ?? "Test")
        cell.animationImage.loadingImage(URLString: animations[indexPath.row].imageURL ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow = animations[indexPath.row].animationTransitionType
        performSegue(withIdentifier: transitionManagerCoordinator.getSegueId(animationTransitionType: animations[indexPath.row].animationTransitionType), sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let animationToDelete = animations.remove(at: indexPath.row)
            coreDataManager.deleteAnimation(animation: animationToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = transitionManagerCoordinator.customTransitionManagerUpDown
        segue.destination.modalPresentationStyle = .custom
    }
}

// MARK: Register cells
private extension MainViewController {
    
    func registerTableViewCells() {
        tableView.register(UINib(nibName: "MainScreenTableViewCell", bundle: nil), forCellReuseIdentifier: "MainScreen")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: UINavigationControllerDelegate
extension MainViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            return transitionManagerCoordinator.getTransitionManager(animationTransitionType: didSelectRow)
        case .pop:
            return transitionManagerCoordinator.getTransitionManager(animationTransitionType: didSelectRow)
        default:
            return nil
        }
    }
}
