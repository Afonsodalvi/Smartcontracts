// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;

contract SimpleStorage {

    uint valor;

    function definir(uint x) public {
        valor = x;
    }

    function consultar() public view returns (uint) {
        return valor;
    }


}