pragma solidity ^0.5.1; //MEU TOKEN DA AULA INTRO ETHEREUM EM 2:26:45 DE VIDEO

contract token{
    string public nome= "Afonso Dalvi Token";
    string public simbolo= "ADT";
    uint256 public decimals= 18;
    uint256 public totalfornecido;
    mapping (address => uint256) public saldototal;
    mapping (address =>mapping (address=>uint256)) public mesada;
    
    event transferencia( address indexed from, address indexed to, uint256 valor);
    event aprovacao (address indexed dono, address indexed comprador, uint256 valor);
    
    constructor()public{
        totalfornecido= 1000000 * (10** decimals);
        saldototal[msg.sender]= totalfornecido;
    }
    
    function transferir (address paraquem, uint256 _valor) public returns (bool sucesso){
        require(saldototal[msg.sender]>=_valor);
        _transferir(msg.sender, paraquem, _valor);
        return true;
    }
    
    function _transferir(address deonde, address paraquem, uint256 _valor) internal{
        require (paraquem != address(0));
        saldototal [deonde]=saldototal[deonde] - _valor;
        saldototal [paraquem] =saldototal[paraquem] + _valor;
        emit transferencia (paraquem, deonde, _valor);
        
    }
    function aprovar(address _comprador, uint256 _valor) public returns (bool sucesso){
        require (_comprador != address (0));
        mesada[msg.sender][_comprador]=_valor;
        emit aprovacao (msg.sender,_comprador, _valor);
        return true;
        
    }
    
    
    function transferirdeonde(address deonde, address paraquem, uint256 _valor) public returns (bool sucesso){
        require (_valor <= saldototal[deonde]);
        require (_valor<= mesada[deonde][msg.sender]);
        mesada [deonde][msg.sender] = mesada[deonde][msg.sender] - _valor;
        _transferir (deonde, paraquem, _valor);
        return true;
    }
}
//COMECE AQUI
// ENTENDER COMO FAZER, PRIMEIRAMENTE VC DA O DEPLOY DO CONTRATO DESTE TOKEN. FEITO ISSO, AGORA O TOKEN ESTA PUBLICADO E VAMOS AO CONTRATO DE TIME LOCK (TEMPODOTOKEN) 
// PARA FAZER O DEPLOY DO CONTRATO DE TOKENTIME VC IRÁ SELECIONAR ELE LOGO ACIMA E DEPOIS SELECIONAR ELE NO CONTRACT A SUA ESQUERDA.
//VÁ ATÉ ELE E CONFIRA O RESTANTE DA EXPLICAÇÃO LÁ(1)....E DEPOIS VOLTARÁ AQUI


// (2)AGORA CONTINUANDO NO CONTRATO DO TOKEN DEVERÁ ABRIR A FUNÇÃO TRANFERIR E INSERIR O VALOR QUE DESEJA COM 18 ZEROS NO FINAL.
// NA MESMA FUNÇÃO TRANSFERIR AGORA QUE INSERIR O VALOR IRÁ INSERIR O ENDEREÇO paraquem, QUE DEVERÁ SER O ENDEREÇO DO CONTRATO TOKENTIME QUE VOCE FEZ O DEPLOY ANTERIORMENTE.
// AO INSERIR AS DUAS INFORMAÇÕES NA FUNÇÃO TRANSFERIR CLIQUE EM transact.
// PRONTO, AGORA VÁ NO CONTRATO DE TEMPO DE TOKEN E VEJA QUEM FOI O BENEFICIÁRIO, O TEMPOQUEPODETRANSFERIR E O TOKEN (NUMERO DO CONTRATO DO TOKEN) CONTINUO A EXPLICAÇÃO NO CONTRATO DE TOKEN (3)


//FINALIZANDO(4).. VÁ NESSE CONTRATO EM saldototal COLOQUE O ENDEREÇO QUE INSERIRU NO CONTRATO tokentime E O BENEFICIÁRIO QUE VOCE TRANSFERIRU O VALOR/tokentime
// AO INSERIR CLIQUE EM saldototal E IRÁ APARECER O VALOR.
