// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.8.0;


contract comprandotoken{
    //Error: invalid address (arg="", coderType="address", value="", version=4.0.47) LEMBRE-SE esse erro se da porque não foi inserido o endereço.
    // então sempre ao inserir o deploy deve indicar um endereço, ou seja, copie e cole um enderereço na função constructor
     mapping (address => uint256) public tokenscomprados; //Saldos da carteira
     address payable carteira; // endereço que irá pagar
     fallback()external payable { // função interna do contrato, que institui a transferencia ESSA FUNÇÃO NÃO TEM NECESSIDADE AQUI.
        comprartoken(); //estudar função fallback
    }
     
     
     event Compra( 
         address indexed _comprador,
         uint256 _quiantidade
         
         );
    
    constructor(address payable _carteira) public{ //não esqueça de inserir o endereço por exemplo: 0x617F2E2fD72FD9D5503197092aC168c91465E7f2
        carteira=_carteira;
    }
    
    
    
    function comprartoken() public payable{ //
        tokenscomprados [msg.sender] +=1;
         //enviar ether para carteira (wallet)
        carteira.transfer(msg.value); 
        
        //definimos quem vai comprar o token na "account" abaixo em "value" preencher com o preço em ether do token, em deploy inserir o endereço da conta que irá transferir o valor do token.
        // Tudo isso fica registrado no contrato, para conferir a transação vai em debug e veja os detalhes
        
        //Como mandar ether para outra conta? vá em "value" e selecione "ether", feito isso mude o "value" para quantos ether quer transferir da sua conta para outra.
        // Ao seguir os passos acima, irá definir em "account" a conta que irá transferir o valor em ether, agora é definira para qual conta irá o valor desejado em ether.
        // Em Deploy terá escrito "address _carteira" ali irá inserir a conta que quer transferir o valor, lógicamente diferente da que está selecionada em "account".
        // Ao clicar em Deploy já com a conta, clique em "transferirether" já com "value" preenchido, quando clicar terá feito a transferencia.
        // para conferir, vai no endereço que tranferiu e confira o valor.
        // cada transferencia será computada na sua conta.
        // sendo somado +1 em cada transferencia que fizer cada vez que clicar na função "transferirether", ou seja, o numero de transferencias feita pela conta.
    }
}