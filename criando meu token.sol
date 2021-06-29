pragma solidity 0.5.1; // REPARE QUAL A VERSÃO USADA AQUI


contract ERC20Token{
    string public nome;
    mapping (address => uint256) public tokenscomprados; //descobrir quantos tokens o contrato "meutoken" comprou
    
    constructor (string memory _nome) public{ //no deploy do contrato "meutoken" ficará guardado o nome que insereriu como o titular 
        nome=_nome;
    }
    
    
    function comprar()public{ //função comprar do contrato "ERC20Token" é ligada a mesma função no contrato "meutoken"
        tokenscomprados[tx.origin]++; //Toda vez que a conta clicar em comprar, será somado como uma compra, e guardado no variável mapping o endereço da compra mais o numero de tokens comprados por ela.
    }
    


}


contract Afonsotoken is ERC20Token{ //conexão entre o contrato "Afonsotokentoken" e "ERC20Token"
    string public simbolo; //inserir simbolo de identificação
    address [] public donoscompradores;// caso mude a account e compre mais tokens o contrato terá mais de um dono de token, mas com o mesmo nome e simbolo inserido, para mudar deverá fazer um novo deploy do contrato "meutoken"
    uint256 donoconta;
    
    
    constructor (string memory _nome,string memory _simbolo)
    ERC20Token(_nome)public{simbolo=_simbolo;}
    
    function comprar()public {
        super.comprar();
        donoconta++;
        donoscompradores.push(msg.sender);
    }
    
    
}
    
    //Nesse contrato ligamos dois contratos um como sendo o seu token e outro identificando um token especifico, ou seja, o Afonsotoken é ligado ao token ERC20Token.
    // No controto Afonsotoken pode inserir nome e simbolo dele em questão, e no mesmo contrato outras contas podem efetuar a compra de token.
    // Sendo assim, outras contas podem comprar o Afonsotoken, caso queira identificar a ordem de donoscompradores inserir o numero em donoscompradores.
    // Além disso, podemos saber quantos tokens foram comprados pelo endereço da conta, em tokenscomprados ao inserir o endereço da conta irá saber quantos foram comprados.
       
    