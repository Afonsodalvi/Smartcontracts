pragma solidity ^0.5.11;
 
contract LicencaSoftware {
    
    uint preco;             // Custo da licença do software
    address payable dono;   // Endereço da carteira da empresa desenvolvedorea do softrware
    uint serial;            // Serial da instalação do software
    
    // Contrutor que define preço e dono
    constructor(uint _valor) public {
        preco = _valor;
        dono = msg.sender;
    }
    
    // Função para licenciar o software, que definie a senha e paga o custo
    function licencar(uint _serial) public payable {
      require(msg.value >= preco, "Valor insuficiente para licenciar!");
      serial = _serial;
       uint troco = msg.value - preco;
        if(troco > 0) {
            msg.sender.transfer(troco);
        }
    }
    
    function saldo() view public returns(uint) {
        return address(this).balance;
    }
    
    function resgatar() public {
        dono.transfer(address(this).balance);
    }
    
    function autorizado(uint _serial) public view returns(bool){
        if(serial == _serial) {
            return true;
        } else {
            return false;
        }
    } 
}