
pragma solidity 0.5.1; // REPARE QUAL A VERSÃO USADA AQUI


contract ERC20Token{
    string public nome;
    mapping (address => uint256) public tokenscomprados;
    
    
    
    function mint()public{
        tokenscomprados[tx.origin]++;
    }
    


}


contract comprandotoken{
    
     address payable carteira; // endereço que irá pagar
     address public token;
     
    
    
    constructor(address payable _carteira, address _token) public{ 
        token=_token;
        carteira=_carteira;
    }
    
    function ()external payable { 
        comprartoken(); //estudar função fallback
    
    }
    
    function comprartoken() public payable{ //
        
        ERC20Token _token= ERC20Token(address(token));
        _token.mint();
        carteira.transfer(msg.value); 
        
        
        // primeiro selecione o primeiro contrato, ou seja, ERC20Token e faça o deploy, na aba das transações logo abaixo ao lado do debug veja o teor do contrato.
        // Ao abrir, copie o "contract address" que será gerado. Feito isso, agora mude o contrato para o "comprandotokentoken", agora no deploy deste contrato terá as variáveis que vc definiu nele.
        //No deploy do contrato "comprandotoken" voce irá preencher o endereço do "token",ou seja, o segundo argumento e sendo o numero do "contract address" copiado do ERC20Token.
        // no primeiro argumento "carteira" irá copiar o endereço que desejar da "account", depois de preencher os dois fará o debloy do contrato "comprartoken"
        // Agora clique em "comprartoken" no contrato "comprandotoken", e confira em "token" o enderesso.
        //apos feito isso, vá no contrato "ERC20Token" e em "tokenscomprados" e cole o endereço que esta no accounte e terá quantos tokens foram comprados, no "mint" é uma forma de comprar mais tokens no mesmo contrato. 
        
       
    }
}