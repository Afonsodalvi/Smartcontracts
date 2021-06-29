pragma solidity ^0.4.0;
 contract presenca{
    struct Aluno{
        bool matriculado;
        uint presenca;
        
    }
address public professor;
mapping(address=> Aluno) public turma;
function presenca(){
    // professor cria contrato
    professor=msg.sender;
    
}
function registraAluno(address Aluno) {
    if (msg.sender !=professor) return;
    turma[Aluno].matriculado=true;
    turma[Aluno].presenca=0;
}
function assinapresenca (){
    //Aluno assina a lista de presença
    if(msg.sender == professor || turma[msg.sender].matriculado == false ) return;
    turma[msg.sender].presenca += 1;
}
}