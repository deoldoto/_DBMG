unit vendasService;

interface

uses
  vendas, vendasDao, vendaItemDAO, listVendas, system.Generics.Collections,
  system.SysUtils,
  listVendasItem, vendaItem, clientesDao, clienteservice, listCliente,
  produtoService, listProduto,
  produto, system.Classes;

type
  TVendasService = class
  private
    vendasDao: TVendaDao;
    vendasItemDao: TVendaItemDao;
    clientesDao: TClienteDao;

    function ValidarVenda(venda: tVenda): string;
    function validaExclusao(idVenda: integer): String;
    function validaCliente(venda: tVenda): string;
    function validarProdutos(venda: tVenda): string;
  public
    function InserirVenda(venda: tVenda): String;
    function listarVendas(): TListVendas;
    function buscarVendaPorId(const id: String): TListVendas;
    function alterarvenda(venda: tVenda): String;
    function excluirVenda(const id: integer): String;
    function efetivar(const id: integer): string;
    function relatorioVendasPorCliente(const idCliente: integer): TListVendas;
    function geararId(): integer;
    constructor Create;
  end;

implementation

{ TVendasService }

function TVendasService.alterarvenda(venda: tVenda): String;
var
  vendaItem: TVendaitem;
begin
  Result := ValidarVenda(venda);

  if Result <> EmptyStr then
    exit;
  try
    Result := vendasDao.alterarvenda(venda);
    if Result <> EmptyStr then
      exit;
    for vendaItem in venda.listVendasItem.listaVendasItem do
    begin
      Result := vendasItemDao.AlterarvendaItem(vendaItem);
      if Result <> EmptyStr then
        break;
    end;

  except
    on E: Exception do
      Result := 'Falha ao alterar a venda: ' + E.Message;
  end;

end;

function TVendasService.buscarVendaPorId(const id: String): TListVendas;
begin
  Result := vendasDao.buscarVendaPorId(id);
  if Result.listVendas.Count = 0 then
    exit;
  Result.listVendas[0].listVendasItem := vendasItemDao.listarVendaItem
    (id.ToInteger);
end;

constructor TVendasService.Create;
begin
  inherited Create;
  vendasItemDao := TVendaItemDao.Create;
  vendasDao := TVendaDao.Create;
  clientesDao := TClienteDao.Create;
end;

function TVendasService.efetivar(const id: integer): string;
begin
  Result := vendasDao.efetivar(id);
end;

function TVendasService.excluirVenda(const id: integer): String;
begin
  Result := validaExclusao(id);
  if Result <> EmptyStr then
    exit;

  try
    Result := vendasItemDao.excluirItensDaVenda(id);

    if Result = EmptyStr then
      exit;
    Result := vendasDao.excluirVenda(id);
  except
    on E: Exception do
    begin
      Result := 'Falha ao excluir a venda: ' + E.Message;
    end;
  end;
end;

function TVendasService.geararId: integer;
begin
  Result := vendasDao.geararId;
end;

function TVendasService.InserirVenda(venda: tVenda): String;
var
  vendasItem: TVendaitem;
begin

  Result := ValidarVenda(venda);

  if Result <> EmptyStr then
    exit;
  try
    venda.id := vendasDao.geararId;
    Result := vendasDao.InserirVenda(venda);
    if Result <> EmptyStr then
      exit;
    for vendasItem in venda.listVendasItem.listaVendasItem do
    begin
      Result := vendasItemDao.inserirVendaItem(vendasItem);
      if Result <> EmptyStr then
        break;
    end;

  except
    on E: Exception do
    begin
      Result := 'Falha ao inserir a venda: ' + E.Message;
    end;

  end;

end;

function TVendasService.listarVendas: TListVendas;
var
  venda: tVenda;
begin
  Result := vendasDao.listarVendas;
  for venda in Result.listVendas do
  begin
    venda.listVendasItem := vendasItemDao.listarVendaItem(venda.id);
    venda.cliente := clientesDao.buscarClientePorId(venda.cliente.id.ToString)
      .listaCliente[0];
  end;
end;

function TVendasService.relatorioVendasPorCliente(const idCliente: integer)
  : TListVendas;
var
  venda: tVenda;
begin
  Result := vendasDao.listarVendas;
  for venda in Result.listVendas do
  begin
    venda.listVendasItem := vendasItemDao.listarVendaItem(venda.id);
    venda.cliente := clientesDao.buscarClientePorId(venda.cliente.id.ToString)
      .listaCliente[0];
  end;
end;

function TVendasService.validaCliente(venda: tVenda): string;
var
  clienteservice: TClienteService;
  listCliente: TlistCliente;
begin
  Result := EmptyStr;
  if venda.cliente.id = 0 then
  begin
    Result := 'Não foi informado um cliente para a venda';
    exit;
  end;

  clienteservice := TClienteService.Create;
  try
    listCliente := clienteservice.buscarClientePorId(venda.cliente.id.ToString);
    if listCliente.listaCliente.Count = 0 then
    begin
      Result := 'O cliente não está cadastrado';
      exit;
    end;

    if listCliente.listaCliente[0].status <> 'Ativo' then
    begin
      Result := 'O cliente não está ativo';
      exit;
    end;

  finally
    clienteservice.Free;
  end;

end;

function TVendasService.validaExclusao(idVenda: integer): String;
var
  listVenda: TListVendas;
begin
  Result := EmptyStr;
  if idVenda = 0 then
  begin
    Result := 'nenhuma venda informda';
    exit;
  end;

  listVenda := vendasDao.buscarVendaPorId(idVenda.ToString);

  if listVenda.listVendas.Count = 0 then
  begin
    Result := 'venda não localizada';
    exit;
  end;

  if listVenda.listVendas[0].status = 'efetivada' then
  begin
    Result := 'A venda esta efetivada e não pode ser excluida';
    exit;
  end;


end;

function TVendasService.validarProdutos(venda: tVenda): string;
var
  listProduto: tListProduto;
  listProdutoValidado: TStringList;
  produtoService: TProdutoService;
  itemVenda: TVendaitem;
  listRetorno: TStringList;
begin
  Result := EmptyStr;

  if venda.listVendasItem.listaVendasItem.Count = 0 then
  begin
    Result := 'nenhum produto informado para a venda';
    exit;
  end;

  produtoService := TProdutoService.Create;
  listProdutoValidado := TStringList.Create;
  listRetorno := TStringList.Create;
  try

    for itemVenda in venda.listVendasItem.listaVendasItem do
    begin
      listProduto := produtoService.BuscarProdutoPorId
        (itemVenda.produto.id.ToString);
      if listProduto.listProduto.Count = 0 then
      begin
        if not listRetorno.IndexOf('Existem produtos não cadatrados') >= 0 then
          listRetorno.add('Existem produtos não cadatrados');
      end;

      if itemVenda.valorTotal = 0 then
        listRetorno.add('O Produto ' + listProduto.listProduto[0].descricao +
          ' está com o valor zerado');

      if listProduto.listProduto[0].status <> 'Ativo' then
        listRetorno.add('O Produto ' + listProduto.listProduto[0].descricao +
          ' está com o valor zerado');

      if listProdutoValidado.IndexOf(itemVenda.produto.id.ToString) >= 0 then
        listRetorno.add('O Produto ' + listProduto.listProduto[0].descricao +
          ' contem mais de um registro no pedido ');

      listProdutoValidado.add(itemVenda.produto.id.ToString);
    end;

    if listRetorno.Count > 0 then
      Result := listRetorno.Text;

  finally
    produtoService.Free;
  end;
end;

function TVendasService.ValidarVenda(venda: tVenda): string;
begin
  Result := EmptyStr;

  if venda.listVendasItem.listaVendasItem.Count = 0 then
  begin
    Result := 'nenhum item informado para o pedido';
    exit;
  end;

  Result := validaCliente(venda);

  if Result <> EmptyStr then
    exit;

  Result := validarProdutos(venda);

  if Result <> EmptyStr then
    exit;
end;

end.
