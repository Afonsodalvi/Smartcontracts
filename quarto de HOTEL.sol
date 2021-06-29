pragma solidity ^0.6.0;

contract quartodehotel{
    
    enum Statuses {VAGO, OCUPADO}
    Statuses currentStatus;
    
    event Ocuppy(address _ocupantes, uint _value);
    address payable public owner;
    
    constructor()public {
        owner = msg.sender;
        currentStatus=Statuses.VAGO;
        
    }
    modifier onlyWhileVago{
        require(currentStatus == Statuses.VAGO, "quarto ocupado.");
        _;
    }
    
    modifier custos (uint _amount){
        require (msg.value >= 2 ether, "o valor depositado ainda não é o preço da diária.");
        _;
        
    }
    
    receive() external  payable onlyWhileVago custos (2 ether){
      
        currentStatus=Statuses.OCUPADO;
        owner.transfer(msg.value);
        emit Ocuppy(msg.sender, msg.value);
    }
}