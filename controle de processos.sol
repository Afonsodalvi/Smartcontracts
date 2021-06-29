// SPDX-License-Identifier: MIT
pragma solidity =>0.4.22<0.0.8;
/**
 * The votar contract does this and that...
 */
contract ControleProcessos {
  uint valor; //quantidade de processos
  function definir(uint x) public {
  	valor = x;
  	
  }
  function consultar () view public returns (uint) {
  	
  }
  // a função somar vai receber um valor de quem a chamou, que temporáriamente é armazenado na variável local numeroAsomar
  // (uint numeroAsomar)
  function somar (uint numeroAsomar) public {
  	valor = valor + numeroAsomar;
  	// pode ser: valor += numeroAsomar
  	
  }
// a função incrementar soma 1 ao que estava anteriormente armazenado na variável valor, passando a armazenar (atribuir) o resultado a variável valor.
  function incrementar () public {
  	valor = valor + 1
  	// pode ser: valor++
  	
  }
  
  
  
    
  }
}
