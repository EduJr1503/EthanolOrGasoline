//
//  VeiculoViewController.swift
//  EthanolOrGasoline
//
//  Created by Eduardo Junior on 28/03/22.
//

import UIKit
import Firebase

class VeiculoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController ()
    var idImagem = NSUUID().uuidString
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func proximoPasso(_ sender: Any) {
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando..", for: .normal)
        
        let armazenamento = Storage.storage().reference
        let imagens = armazenamento.child("imagens")
        
        // Recuperar a imagem
        if let imagemSelecionada = imagem.image {
            
            let imagemDados = UIImageJPEGRepresentation(imagemSelecionada, 0.5) {
                imagens.child("\(self.idImagem).jpg").putData(imagemDados, metadata: nil, StorageMetadata?, completion: {(metaDados, _: Error?) in
                    if erro == nil {
                        print("Sucesso ao enviar o arquivo!")
                        print(metaDados?.downloadURL()?.absoluteString)
                        
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                    }else {
                        print("Erro ao enviar o arquivo!")
                }
            })
        }
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagem.image = imagemRecuperada
        
        //Habilita botão próximo
        self.botaoProximo.isEnabled = true
        self.botaoProximo.backgroundColor = UIColor.white
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
        func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
            
        // desabilita o botão próximo
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
        }
    }
}
