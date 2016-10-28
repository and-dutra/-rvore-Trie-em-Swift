//: Playground - noun: a place where people can play
let addPalavras = ["So","Sol","Solar","Sola", "Lua","Lunar" ,"Lunático","Mar","Maré"]
let remPalavras = ["So","Lunar","Mar"]

public class NodoTrie {
    var letra: Character!
    //var filhos : Array<NodoTrie>
    var filho : Dictionary = [Character:NodoTrie]() //Dictionary cria os nós usando letra como indice.
    var pai : NodoTrie? // pai usado na remocao
    var isFinal : Bool //Indicador usado para dizer se o nó é uma palavra
    //var level : Int
    
    init(_letra: Character, _final: Bool) {
       self.letra = _letra
       self.isFinal = _final
       
    }
    
}



class trie {
    var root : NodoTrie = NodoTrie(_letra: "\0", _final: false) // Iniciando a árvore
    
    func add(palavra: String)  {
        
        let tamPalavra = palavra.characters.count - 1 // - 1 porque o contaLetra começa do index 0
        //print(tamPalavra)
        var nodoAtual : NodoTrie? = root // Checa se existe um nodo atual e seta
 
        var contaLetra = 0
        
        for letra in palavra.uppercased().characters { //percorre a palavra letra por letra
           // print(nodoAtual?.letra)
            
            let nodoPai = nodoAtual
           // print(letra,contaLetra, tamPalavra)
            let final = contaLetra == tamPalavra ? true : false // Define se é final
            
            if final {
               // print("chegou no fim, ultima letra \(letra)")
            }
            
            contaLetra += 1
            
            if nodoAtual!.filho[letra] == nil { //Se ainda não tem filho com essa letra, adiciona
                print("ainda não tem filho com a letra: \(letra)")
                nodoAtual!.filho[letra] = NodoTrie(_letra: letra, _final: final)
                nodoAtual!.filho[letra]?.pai = nodoPai
                //print(nodoAtual?.letra)
                
            } else {
                print("ja tem filho com a letra: \(letra)")
            /*    if final { //Caso adicione uma palavra menor que uma já existente ele reconhece.
                    nodoAtual!.filho[letra]?.isFinal = true
                    //print("Agora \(letra) eh final tambem")
                } */
               
            }
            
            //print(nodoAtual?.letra)
            
            nodoAtual = nodoAtual!.filho[letra]
            
        }
    }
    
    func buscar(palavra: String) { //Identifica se uma string passada é uma palavra reconhecida pela arvore.
        
        let tamPalavra = palavra.characters.count
       // print("entrou na busca")
        var nodoAtual : NodoTrie? = root
        var contaLetra = 0
        
        for letra in palavra.uppercased().characters {
            nodoAtual = nodoAtual!.filho[letra]
            
            print("letra \(letra) , filhos \(nodoAtual?.filho.count)")
            
            if nodoAtual == nil {
                print("Palavra nao encontrada")
                return
            } else {
               // print("encontrou a letra \(letra)")
            }
            
            contaLetra = contaLetra + 1
            
            if contaLetra == tamPalavra { // Chegou no fim da palavra
                if nodoAtual!.isFinal == true {
                    print("Palavra \(palavra) encontrada e reconhecida!")
                } else {
                    print("Palavra encontrada mas não reconhecida!")
                }
                
                return
            }
        }
    }
    
    
    func remover(palavra: String) {
        let tamPalavra = palavra.characters.count
        var nodoAtual : NodoTrie? = root
        var contaLetra = 0
        
        for var letra in palavra.uppercased().characters {
            nodoAtual = nodoAtual!.filho[letra]
            
            if nodoAtual == nil {
                return
            } else {
                print("encontrou a letra \(letra)")
            }
            
            contaLetra = contaLetra + 1
            
            if contaLetra == tamPalavra { // Chegou no fim da palavra
                if nodoAtual!.isFinal == true {
                    
                    if (nodoAtual?.filho.count)! > 0 {
                      //  print("ainda tem filh")
                        print("Palavra \(palavra) removida")
                        nodoAtual!.isFinal = false
                        return
                    } else {
                       // print("nao tem mais filho \(nodoAtual?.letra) e \(nodoAtual?.pai?.letra)") // quer dizer
 
                        while nodoAtual?.filho.count == 0,let nPai = nodoAtual?.pai {
                            if nPai.isFinal {
                                return
                            }
                            nodoAtual = nPai
                            nodoAtual?.filho[letra] = nil
                            letra = (nodoAtual?.letra)!
                        }
                        
                    }
                    
                }
               
            }
         
        }
        
    }
    

    
    
    
    
    
    
}

var arvore : trie = trie()


//Executando operações


for item in addPalavras {
    print("\n\nAdicionando \(item) na arvore.")
    arvore.add(palavra: item)
    
}

print("\n\n Remover ")
for item in remPalavras {
    print("\n Removendo \(item)")
    arvore.remover(palavra: item)
}


arvore.buscar(palavra: "Sol")



