//
//  EntrarViewController.swift
//  EthanolOrGasoline
//
//  Created by Eduardo Junior on 25/03/22.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var senhaLogin: UITextField!
    @IBOutlet weak var emailCadastro: UITextField!
    @IBOutlet weak var senhasCadastro: UITextField!
    
    override func viewDidLoad () {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func exibirMensagem(titulo: String, mensagem: String){
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction( acaoCancelar)
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        //Recuperar dados digitados
        if let emailR = emailCadastro.text {
            if let senhaR = senhasCadastro.text {
                
                //Criar conta no FireBase
                let autenticacao = Auth.auth()
                autenticacao.createUser(withEmail: emailR, password: senhaR, completion: { (usuario, erro ) in
                    
                    if erro == nil {
                        print("Sucesso ao cadastrar usuário.")
                        self.exibirMensagem(titulo: "Sucesso", mensagem: "Usuário cadastrado com sucesso.")
                    }else{
                       
                        /*  error_invalid_email
                            error_weak_passaword
                            error_email_already_in_use */
                        
                       let erroR = erro! as NSError
                        if let codigoErro = erroR.userInfo["error_name"] {
                            
                            let erroTexto = codigoErro as! String
                            var mensagemErro = ""
                          
                            switch erroTexto {
                                
                            case "ERROR_INVALID_EMAIL" :
                                mensagemErro = "E-mail inválido, digite um e-mail válido!"
                                break
                            case "ERROR_WEAK_PASSWORD" :
                                mensagemErro = "Senha precisa ter no mínimo 6 caracteres, com letras e números."
                                break
                            case "ERROR_EMAIL_ALREADY_IN_USE" :
                                mensagemErro = "Esse e-mail já está sendo utilizado, crie sua conta com outro e-mail."
                                break
                            default:
                            mensagemErro = "Dados digitados estão incorretos."
                            }
                            
                            self.exibirMensagem(titulo: "Dados inválidos", mensagem: mensagemErro)
                        }
                    } /*Fim da validação erro Firebase*/
                })
            }
        }
    }
    
        @IBAction func entrar(_ sender: Any) {
        // Recuperar dados digitados
        if let emailR = emailLogin.text {
            if let senhaR = senhaLogin.text {
                
                //Autenticar usuário no Firebase
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: emailR, password: senhaR, completion: { (usuario, erro) in
                    
                    if erro == nil {
                        
                        if usuario == nil {
                            self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação, tente novamente.")
                        }else{
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    }else{
                        self.exibirMensagem(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente!")
                    }
                })
            }
        }
    }
}
    

