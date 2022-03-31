//
//  SeusVeiculosViewController.swift
//  EthanolOrGasoline
//
//  Created by Eduardo Junior on 28/03/22.
//

import UIKit
import FirebaseAuth

class SeusVeiculosViewController: UIViewController {

    @IBAction func sair(_ sender: Any) {
        
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print ("Erro ao deslogar usuário")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
