//
//  BaseCoordinator.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 14/01/2026.
//

import UIKit

class BaseCoordinator<ControllerType> where ControllerType: UIViewController {
    let id = UUID()
    var presenter: ControllerType
    private(set) var childCoordinators = [UUID: Any]()
    
    init(presenter: ControllerType) {
        self.presenter = presenter
    }
    
    func start() {
        preconditionFailure("Not implemented")
    }
}


// MARK: - Child coordinators management
extension BaseCoordinator {
    func store<CtrlrType: UIViewController>(coordinator: BaseCoordinator<CtrlrType>) {
        // Store the coordinator only if it doesn't exists
        let coordinatorExist = childCoordinators.contains { (key: UUID, value: Any) ->Bool in
            return key == coordinator.id
        }
        
        if !coordinatorExist {
            childCoordinators[coordinator.id] = coordinator
        }
    }
    
    func delete<CtrlrType: UIViewController>(coordinator: BaseCoordinator<CtrlrType>) {
        // Remove the coordinator only if it exists
        let coordinatorExist = childCoordinators.contains { (key: UUID, value: Any) ->Bool in
            return key == coordinator.id
        }
        
        if coordinatorExist {
            childCoordinators[coordinator.id] = nil
        }
        
    }
    
    func deleteAllChildCoordinators() {
        childCoordinators = [UUID: Any]()
    }
    
    func childCoordinator<T>(withID key: UUID) -> T? {
        return childCoordinators.first(where: { $0.key == key})?.value as? T
    }
}
