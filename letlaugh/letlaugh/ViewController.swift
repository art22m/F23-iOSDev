//
//  ViewController.swift
//  letlaugh
//
//  Created by Artem Murashko on 16.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let ass = ServiceAssemblyImpl()
        let jokesService = ass.makeJokesNetworkService()
        jokesService.getJoke(number: 10) { result in
            print(result)
        }
    }

}
