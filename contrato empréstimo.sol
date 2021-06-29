// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;




contract emprestimo{ //DEFINI AS VARIÁVEIS GLOBAIS PARA CONSTRUIR O CONTRATO E DEFINIR ALGUMAS MODIFIER
    address Click; // ENDEREÇO DA EMPRESA
    uint valorlimite; //VALOR LIMITE DO CONTRATO 
    string nome; // NOME DO CONTRATO
    bool autorizacao;// DEFINI VARÁVEL QUE A EMPRESA AUTORIZA OU NÃO O CONTRATO
    uint soliemprestimos;
    uint prazominimo; //ESTABELECI EM 30 DIAS
    uint inicidoprazo;// VARIÁVEL QUE IRÁ RETORNAR O INICIO DO CONTRATO
   
    

    struct clienteEmprestimo{ // CRIEI A ESTRUTURA DO CIENTE QUE QUER O EMPRESTIMO
        address payable cliente;
        uint quantoquer;
        uint inicio;
        bool status;
        string nome;
        uint8 CPF;
        uint ultima;
        uint saldo;
        uint prazo;

    }
   uint []pedidos; // CRIEI UMA LISTA DE PEDIDOS
    
   
    
    modifier Empresa(){
        require(msg.sender==Click, "Somente a empresa pode fazer essa funcao"); // INSERI ESSE MODIFIER PARA DEFINIR EM ALGUNS PONTOS QUE SOMENTE A EMPRESA CLICK PODERÁ FAZER DETERMINADAS FUNÇÕES
        _;
    }
    constructor (uint _valorlimite, string memory _nome, uint _prazo) public { //FIZ ESSA CONSTRUÇÃO PARA DAR NOME AO CONTRATO DE EMPRÉSTIMO E DEFININDO UM VALOR LIMITE E QUAL MOEDA USADA (FUTURAMENTE O TOKEN)
    require (_prazo > 30 days, "O prazo tem que ser maior que 30 dias");
    autorizacao=true; //COMEÇA VERDADEIRO MAS A EMPRESA PODERÁ NÃO AUTORIZAR E NINGUEM MAIS PODERÁ FAZER NADA
        valorlimite=_valorlimite;
        nome=_nome;
        soliemprestimos=0;
        Click=msg.sender; // QUEM FAZ O DPLOY DO CONTRATO É A EMPRESA
        prazominimo=_prazo;
        inicidoprazo=block.timestamp;//COMEÇA A CONTAR QUANDO FAZER O DEPLOY
        
    }
    mapping (address=>clienteEmprestimo)clientes; // MAPPING QUE O ENDEREÇO INDICARÁ O CLIENTE DO EMPRESTIMO
     event status(string nome, bool status);//ATENTENO ONDE IRÁ INSERIR(NAO FIZ AINDA)
     event valorparcela (uint valor, uint parcelas);//ATENTO ONDE IRÁ INSERIR(NAO FIZ)
     
    
     
    modifier ativo(address _emprestimo) {
        require(clientes[_emprestimo].status, "Nao esta ativo");
        _;
    }
    
    
    
    function difinicoescontrato()view public returns(string memory, uint, uint, uint){
        return (nome, valorlimite, prazominimo, inicidoprazo);
        
    }
    
    function mudarautorizacao() public Empresa { //olhar onde colocar requiere
        autorizacao=!autorizacao;
        
    }
    
    function consultarautorizacao() public view returns(bool){
        return autorizacao;
    }
    

    
    
    function QUEROemprestimo (string memory _nome, uint quantoquer, uint _prazo) public  { /* FUNÇÃO QUE DEFINI OS ASPECTOS
    QUE AQUI SOMENTE O CLIENTE PODERÁ PREENCHER E SOMENTE DENTRO DO LIMITE DO VALOR QUE DEFINIMOS, 
    SE A CONTA JÁ SE ENCONTRA EM USO NÃO SERÁ ACEITA
    E SE NÃO ESTIVER AUTORIZADA PELA EMPRESA SERÁ NEGADO
    */
        require (msg.sender!=Click,"A empresa nao pode preencher informacoes da solicitacao de emprestimo");
        require (quantoquer<=valorlimite, "ULTRAPASSOU O VALOR LIMITE");
        require(clientes[msg.sender].quantoquer == 0, "Conta ja se encontra em uso.");
        require (autorizacao == true, "NaO AUTORIZADA");
        require (_prazo<= prazominimo, "O prazo para pagamento tem que ser dentro do estabelecido, confira nas definicoes do contrato");
         // 
        clientes[msg.sender].nome = _nome;
        clientes[msg.sender].inicio = block.timestamp; 
        clientes[msg.sender].ultima = clientes[msg.sender].inicio;
        clientes[msg.sender].status = true;
        clientes[msg.sender].quantoquer = quantoquer;
        clientes [msg.sender].saldo = 0;
        clientes [msg.sender].prazo=_prazo;
    }  
   
    
    
    
    function adicionarsolici(uint i) public Empresa{
        pedidos.push(i); // MUDAR AQUI PARA NUMERO MAS JUNTAR A ESTRUTURA DO CLIENTE OLHAR NA LISTA B
        i= soliemprestimos+1; //ACRESCENTAR AS SOLICITAÇÕES
        emit status (clientes[msg.sender].nome, clientes[msg.sender].status);//EMITIR NOME E STATUS
    }
    
    
    
    function consultarquantassoli()view public returns (uint){ //conferequantos pedidos
        return pedidos.length;
        
        
    }
    
    function consultarclienteEmprestimo(address _emprestimo) ativo (_emprestimo) view public returns (string memory, uint, uint, bool, uint,uint){
        
        
        return(
        
        clientes[msg.sender].nome,
        clientes[msg.sender].inicio, 
        clientes[msg.sender].ultima,
        clientes[msg.sender].status,
        clientes[msg.sender].quantoquer,
        clientes[msg.sender].prazo
        
        );
        
    
    }
    
  
    
   
    
     struct containvestidor{ //ESTRUTURA DO INVESTIDOR
        uint valor;
        address payable Investidor;
        string nome;
        bool status;
        uint perfil;
        
    }
  
     mapping (address=>containvestidor)clienteinvestidor;
     mapping (address=>uint) transferencias;
    
    
     modifier Investimento(){
        require (clienteinvestidor[msg.sender].Investidor==msg.sender, "So pode o investidor");
        _;
    }
    
     modifier investativo(address _investidor) {
        require(clienteinvestidor[_investidor].status, "NaO ESTa ATIVA");
        _;
    }
    
    
    function QUEROinvestir(string memory _nome) public { //CADASTRAMENTO INVESTIDOR
        clienteinvestidor[msg.sender].nome=_nome;
        
        clienteinvestidor[msg.sender].status=true;
        clienteinvestidor[msg.sender].Investidor=msg.sender;
    }
    
    function desativarinvest() view public Empresa{
        clienteinvestidor[msg.sender].status!=clienteinvestidor[msg.sender].status; //FUNÇÃO DA EMPRESA DE DESATIVAR O CONTRATO CASO HAJA PROBLEMAS
        // DESATIVANDO NINGUEM PODERÁ CRIAR AS CONTAS E ASSIM NINGUÉM PODERÁ INVESTIR OU PODER PEDIR EMPRESTIMO
    }
    function conferirstatus() view public returns(bool){ // CONFERIR O STATUS DO CLIENTE INVESTIDOR
        return clienteinvestidor[msg.sender].status;
    }
    function conferirinvestidor(address)view public returns (string memory, uint){
        return (
            clienteinvestidor[msg.sender].nome,
            clienteinvestidor[msg.sender].valor);
    }
    

    
    mapping(address=>uint)public confirmeovalor;
   
   
   
    function quantoInvestiu() view public returns(uint){
        
        return address(this).balance;
    }
    
    function inserirvalorparainvestir(address endereco) investativo (msg.sender) ativo (endereco) public Investimento payable{
        require(msg.value<=valorlimite, "O Valor do emprestimo ultrapassou o limite");
        uint total=msg.value;
        confirmeovalor[endereco]=confirmeovalor[endereco] + total;
       
    }
    
    function transferirvalor(address payable endereco)  ativo (endereco) public Empresa{
        transferencias[msg.sender]+=1;
         uint pagamento= confirmeovalor[endereco];
        confirmeovalor[endereco]=0;
       
        endereco.transfer(pagamento);
         
    }
    
    
   
  

}


