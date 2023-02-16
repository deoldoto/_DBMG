program prjPedidos;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Horse,
  System.JSON,
  Rest.JSON,
  Horse.Jhonson,
  uBancoDados in 'uBancoDados.pas',
  pessoaDao in 'pessoaDao.pas',
  pessoaService in 'pessoaService.pas',
  pessoaController in 'pessoaController.pas',
  clientesDao in 'clientesDao.pas',
  clienteController in 'clienteController.pas',
  clienteService in 'clienteService.pas',
  fornecedorDao in 'fornecedorDao.pas',
  fornecedorService in 'fornecedorService.pas',
  fornecedorController in 'fornecedorController.pas',
  produtoDao in 'produtoDao.pas',
  produtoService in 'produtoService.pas',
  produtoController in 'produtoController.pas',
  vendasDao in 'vendasDao.pas',
  vendasService in 'vendasService.pas',
  cliente in '..\Classes\cliente.pas',
  fornecedor in '..\Classes\fornecedor.pas',
  listCliente in '..\Classes\listCliente.pas',
  listFornecedor in '..\Classes\listFornecedor.pas',
  listPessoa in '..\Classes\listPessoa.pas',
  listProduto in '..\Classes\listProduto.pas',
  listVendas in '..\Classes\listVendas.pas',
  produto in '..\Classes\produto.pas',
  uPessoa in '..\Classes\uPessoa.pas',
  vendas in '..\Classes\vendas.pas',
  vendaItem in '..\Classes\vendaItem.pas',
  listVendasItem in '..\Classes\listVendasItem.pas',
  vendaItemDAO in 'vendaItemDAO.pas',
  vendasController in 'vendasController.pas';

var
  App: THorse;
  retorno: String;
  clienteController: tClienteController;
  pessoaController: tPessoaController;
  fornecedorController: TFornecedorController;
  produtoController: TProdutoController;
  vendaController: TVendaController;

begin
  try
    App := THorse.Create();
    clienteController := tClienteController.Create;
    pessoaController := tPessoaController.Create;
    fornecedorController := TFornecedorController.Create;
    produtoController := TProdutoController.Create;
    vendaController := TVendaController.Create;
    App.Use(Jhonson);

    // ==========pessoa=========
    App.Post('/pessoa',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        pessoa: TPessoa;
      begin
        retorno := EmptyStr;
        pessoa := TJson.JsonToObject<TPessoa>(Req.Body);
        Writeln(pessoa.ToString);
        Writeln('nome: ' + pessoa.nome);
        Writeln('id: ' + pessoa.idPessoa.ToString);
        Writeln('CPD/CNPJ: ' + pessoa.cpf_cnpj);
        retorno := pessoaController.InserirPessoa(pessoa);
        if retorno.IsEmpty then
          Res.Send(TJson.ObjectToJsonString(pessoa)).Status(200)
        else
          Res.Send(retorno).Status(201);

      end);

    App.get('/pessoa',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listPessoa: tListPessoa;
      begin

        listPessoa := pessoaController.ListarPessoas;
        Res.Send(TJson.ObjectToJsonString(listPessoa));
      end);

    App.get('/pessoa/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listPessoa: tListPessoa;
      begin
        listPessoa := pessoaController.BuscarPessoaPorId
          (Req.Params.Items['id']);
        Res.Send(TJson.ObjectToJsonString(listPessoa));
      end);

    App.put('/pessoa/',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retorno: string;
        pessoa: TPessoa;
      begin
        pessoa := TJson.JsonToObject<TPessoa>(Req.Body);
        Writeln(pessoa.ToString);
        Writeln('nome: ' + pessoa.nome);
        Writeln('id: ' + pessoa.idPessoa.ToString);
        Writeln('CPD/CNPJ: ' + pessoa.cpf_cnpj);
        retorno := pessoaController.alterarPessoa(pessoa);
        if retorno.IsEmpty then
          Res.Send('pessoa alterada com sucesso').Status(200)
        else
          Res.Send(retorno).Status(201);

      end);

    App.Delete('/pessoa/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retonro: string;
      begin
        Writeln(Req.Params.Items['id']);
        retonro := pessoaController.excluirPessoa(Req.Params.Items['id']
          .ToInteger());
        if retorno.IsEmpty then
          Res.Send('Pessoa excluida com sucesso').Status(200)
        else
          Res.Send(retonro).Status(201);
      end);

    // =======Cliente========

    App.Post('/cliente',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        cliente: TCliente;
        retorno: string;
      begin
        Writeln(DateTimeToStr(now()) + ' requisição: ' + Req.Body);
        cliente := TJson.JsonToObject<TCliente>(Req.Body);

        retorno := clienteController.InserirCliente(cliente);
        if retorno.IsEmpty then
          Res.Send(TJson.ObjectToJsonString(cliente)).Status(200)
        else
          Res.Send(retorno).Status(201);

      end);

    App.get('/cliente',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listClientes: TListCliente;
      begin

        listClientes := clienteController.ListarCliente;
        Res.Send(TJson.ObjectToJsonString(listClientes));
      end);

    App.get('/clientesativos',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listClientes: TListCliente;
      begin

        listClientes := clienteController.buscarClientesAtivos;
        Res.Send(TJson.ObjectToJsonString(listClientes));
      end);

    App.get('/cliente/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listCliente: TListCliente;
      begin
        listCliente := clienteController.BuscarClientePorId
          (Req.Params.Items['id']);
        Res.Send(TJson.ObjectToJsonString(listCliente));
      end);

    App.put('/cliente/',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retorno: string;
        cliente: TCliente;
      begin
        cliente := TJson.JsonToObject<TCliente>(Req.Body);
        Writeln(cliente.ToString);
        Writeln('nome: ' + cliente.nome);
        Writeln('id: ' + cliente.idPessoa.ToString);
        Writeln('CPD/CNPJ: ' + cliente.cpf_cnpj);
        clienteController.alterarCliente(cliente);
        if retorno.IsEmpty then
          Res.Send('cliente alterado com sucesso').Status(200)
        else
          Res.Send(retorno).Status(201);

      end);

    App.Delete('/cliente/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retonro: string;
      begin
        Writeln(Req.Params.Items['id']);
        retonro := clienteController.excluirCliente(Req.Params.Items['id']
          .ToInteger());
        if retorno.IsEmpty then
          Res.Send('cliente removido com sucesso').Status(200)
        else
          Res.Send(retorno).Status(201);
      end);


    // =======fornecedor========

    App.Post('/fornecedor',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        fornecedor: TFornecedor;
        retorno: string;
      begin
        fornecedor := TJson.JsonToObject<TFornecedor>(Req.Body);
        Writeln('requisição: ' + Req.Body);
        retorno := fornecedorController.InserirFornecedor(fornecedor);
        if retorno.IsEmpty then
          Res.Send(TJson.ObjectToJsonString(fornecedor)).Status(200)
        else
          Res.Send(retorno).Status(201);
      end);

    App.get('/fornecedor',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listFornecedor: TListFornecedor;
      begin

        listFornecedor := fornecedorController.ListarFornecedor;
        Res.Send(TJson.ObjectToJsonString(listFornecedor));
      end);

    App.get('/fornecedor/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listFornecedor: TListFornecedor;
      begin
        listFornecedor := fornecedorController.BuscarFornecedorPorId
          (Req.Params.Items['id']);
        Res.Send(TJson.ObjectToJsonString(listFornecedor));
      end);

    App.put('/fornecedor/',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        fornecedor: TFornecedor;
       retorno: string;
      begin
        fornecedor := TJson.JsonToObject<TFornecedor>(Req.Body);
        Writeln(fornecedor.ToString);
        Writeln('nome: ' + fornecedor.nome);
        Writeln('id: ' + fornecedor.idPessoa.ToString);
        Writeln('CPD/CNPJ: ' + fornecedor.cpf_cnpj);
        fornecedorController.alterarFornecedor(fornecedor);
        if retorno.IsEmpty then
          Res.Send('fornecedor alterado com sucesso').Status(200)
        else
          Res.Send(retorno).Status(201);

      end);

    App.Delete('/fornecedor/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retonro: string;
      begin
        Writeln(Req.Params.Items['id']);
        retonro := fornecedorController.excluirFornecedor(Req.Params.Items['id']
          .ToInteger());
         if retorno.IsEmpty then
        res.Send('fornecedor excluido com sucesso').Status(200)
      else
        res.Send(retorno).Status(201);
      end);

    // =======produto========

    App.Post('/produto',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        produto: tProduto;
        retorno: string;
      begin
        produto := TJson.JsonToObject<tProduto>(Req.Body);
        Writeln('requisição: ' + Req.Body);
        retorno := produtoController.InserirProduto(produto);
        if retorno.IsEmpty then
          Res.Send(TJson.ObjectToJsonString(produto)).Status(200)
        else
          Res.Send(retorno).Status(201);
      end);

    App.get('/produto',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listProduto: TListProduto;
      begin

        listProduto := produtoController.ListarProduto;
        Res.Send(TJson.ObjectToJsonString(listProduto));
      end);

    App.get('/produto/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listProduto: TListProduto;
      begin
        listProduto := produtoController.BuscarProdutoPorId
          (Req.Params.Items['id']);
        Res.Send(TJson.ObjectToJsonString(listProduto));
      end);

    App.put('/produto/',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        produto: tProduto;
        retorno: string;
      begin
        produto := TJson.JsonToObject<tProduto>(Req.Body);
        Writeln(produto.ToString);
        Writeln('produto: ' + produto.descricao);
        Writeln('id: ' + produto.id.ToString);
        Writeln('valor: ' + produto.valor.ToString);
        produtoController.alterarProduto(produto);
         if retorno.IsEmpty then
        res.Send('produto excluido com sucesso').Status(200)
      else
        res.Send(retorno).Status(201);

      end);

    App.Delete('/produto/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retonro: string;
      begin
        Writeln(Req.Params.Items['id']);
        retonro := produtoController.excluirProduto(Req.Params.Items['id']
          .ToInteger());
         if retorno.IsEmpty then
        res.Send('produto excluido com sucesso').Status(200)
      else
        res.Send(retorno).Status(201);
      end);



    // =======vendas========

    App.Post('/venda',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        venda: TVenda;
        retorno: string;
      begin
        venda := TJson.JsonToObject<TVenda>(Req.Body);
        Writeln('requisição: ' + Req.Body);
        retorno := vendaController.InserirVenda(venda);
        if retorno.IsEmpty then
          Res.Send(TJson.ObjectToJsonString(venda)).Status(200)
        else
          Res.Send(retorno).Status(201);
      end);

    App.get('/venda',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listVendas: TListVendas;
      begin
        listVendas := vendaController.listarVendas;
        Res.Send(TJson.ObjectToJsonString(listVendas));
      end);

    App.get('/venda/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listVenda: TListVendas;
      begin
        listVenda := vendaController.buscarVendaPorId(Req.Params.Items['id']);
        Res.Send(TJson.ObjectToJsonString(listVenda));
      end);

       App.get('/vendaporcliente/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        listVenda: TListVendas;
      begin
        listVenda := vendaController.buscarVendaPorId(Req.Params.Items['id']);
        Res.Send(TJson.ObjectToJsonString(listVenda));
      end);
    App.put('/venda/',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        venda: TVenda;
        retorno: string;
      begin
        venda := TJson.JsonToObject<TVenda>(Req.Body);
        Writeln(venda.ToString);
        Writeln('id: ' + venda.id.ToString);
        Writeln('valor: ' + venda.valorTotal.ToString);
        Writeln('Cliente: ' + venda.cliente.nome);
        vendaController.alterarvenda(venda);
         if retorno.IsEmpty then
        res.Send('venda alterada com sucesso').Status(200)
      else
        res.Send(retorno).Status(201);

      end);

    App.put('/efetivarvenda/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retorno: string;
      begin
        retorno := vendaController.efetivar(Req.Params.Items['id'].ToInteger);
        if retorno.IsEmpty then
          Res.Send('Venda efetivada com sucesso').Status(200)
        else
          Res.Send(retorno).Status(201);
      end);

    App.Delete('/venda/:id',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        retonro: string;
      begin
        Writeln(Req.Params.Items['id']);
        retonro := vendaController.excluirVenda(Req.Params.Items['id']
          .ToInteger());
         if retorno.IsEmpty then
        res.Send('venda excluida com sucesso').Status(200)
      else
        res.Send(retorno).Status(201);
      end);

    { TODO -oUser -cConsole Main : Insert code here }
    App.Listen(9000);

  except
    on E: Exception do

      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
