// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.8.0;


contract aprendendodoadicionarpessoa{
     
    
    uint256 public contapessoanumero=0; //variável inteira uint, onde determinamos que se inicia no 0.
    mapping (uint=> Nomecomplet) public pessoa; //variável mapping definida aqui vai armazenar um numero (1,2,3...) que identifica o Nomecomplet (id, primeironome e sobrenome) e sendo consultado ao clicar no deploy publico "pessoa"
    // sempre que "adicionarpessoa" será registrado no mapping, com seu numero de id primeironome e sobrenome, o id consultamos na variável global publica: "contapessoanumero"
    
    
    uint256 tempodeabrir=1602583300; 
    //definimos o dia e hora que vai abrir, mas pq desse numero? 
    //retiramos do site https://www.epochconverter.com/ (abra o site e copie o numero) que converte para dia e hora será igual ao numero definido na variável "tempo de abrir"
    // ou seja, só consegue inserir uma pessoa no dia e hora determinada.(pense isso em contratos onde deve se respeitar algum tempo, não podendo ultrapassalo)
    modifier somentequemabrir(){
        require(block.timestamp >= tempodeabrir); //definimos a varável modifier, para abrir no dia e hora que definimos, caso não seja, será negado.
        _;
    }
    
    struct Nomecomplet { //vamos definir na estrutura Nomecomplet o id, primeironome e sobrenome.
        uint _id;
        string primeironome;
        string sobrenome;
    }
    
    
    function adicionarpessoa(
        string memory _primeironome, string memory _sobrenome
        ) public somentequemabrir{ // função que escreve o primeironome e o sobrenome para salvar na variável mapping pessoa, dando o resultado o nome inteiro (primeironome e sobrenome)
       incrementarconta();
       pessoa[contapessoanumero]=Nomecomplet(contapessoanumero, _primeironome,_sobrenome);
    }
    function incrementarconta() internal{ //função interna que incrementa e adiciona o numero referente a pessoa da função adicionarpessoa
        contapessoanumero +=1; //cada primeironome e sobrenome adicionado é somado 1, ou seja, ao conferir o numero da pessoa que guardou na variável mapping "pessoa" sendo ela global e publica terá o resultado de primeironome e sobrenome.
    }
    
    
    
}
