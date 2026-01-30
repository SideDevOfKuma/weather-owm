//
//  DependencyContainer.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 28/01/2026.
//

import Foundation

enum DependencyRegistrationType {
    case singleInstance(AnyObject)
    case multipleInstance(() -> Any)
}

enum DependencyResolvingType {
    case multipleInstance
    case singleInstance
}

protocol DependencyContainerProtocol {
    func register(type: DependencyRegistrationType, for dependencyInstance: Any.Type)
    func resolve<Value>(_ type: Value.Type, as resolvingType: DependencyResolvingType) -> Value
}


final class DependencyContainer {
    // Multiple instaces dependencies. Every time the dependency is requested a new instance is provided
    private var multipleInstancesDependencies: [ObjectIdentifier : ()-> Any] = [:]
    // Single instance dependedncies.
    private var singleInstancesDependencies: [ObjectIdentifier : AnyObject] = [:]
    
    // Concurrent Queue to control the dependencies access. Concurrent reading, synchronized wrinting
    private let dependencyAccessQueue = DispatchQueue(
        label: "com.sidedevofkuma.weatherowm.dependencyAccessQueue",
        attributes: .concurrent
    )
}

// MARK: - Dependency Access
extension DependencyContainer: DependencyContainerProtocol {
    func register(type: DependencyRegistrationType, for dependencyInstance: Any.Type) {
        // Lock the write access
        dependencyAccessQueue.sync(flags: .barrier) {
            switch type {
            case .singleInstance(let instance):
                singleInstancesDependencies[ObjectIdentifier(dependencyInstance)] = instance
            case .multipleInstance(let factory):
                multipleInstancesDependencies[ObjectIdentifier(dependencyInstance)] = factory
            }
        }
    }
    
    func resolve<Value>(_ type: Value.Type, as resolvingType: DependencyResolvingType) -> Value {
        return dependencyAccessQueue.sync {
            let identifier = ObjectIdentifier(type)
            
            switch resolvingType {
            case .singleInstance:
                guard let resolvedInstance = singleInstancesDependencies[identifier] as? Value else {
                    fatalError("There was no instance of \(type) in the container")
                }
                return resolvedInstance
            case .multipleInstance:
                guard let factory = multipleInstancesDependencies[identifier],
                      let resolvedInstance = factory() as? Value else {
                    fatalError("There was no factory for \(type) in the container")
                }
                return resolvedInstance
            }
        }
    }
}
