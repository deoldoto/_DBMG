unit vendaItemDAO;

interface

uses
  vendaItem, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, listVendasItem;

type
  TVendaItemDao = class
    public
      function inserirVendaItem(vendaItem: TvendaItem): String;
      function listarVendaItem(const idVenda: Integer): TListaVendasItem;
      function buscarVendaItemPorId(const idVenda, idProduto: integer): TListaVendasItem;
      function AlterarvendaItem(vendaItem: TvendaItem): string;
      function excluirVendaItem(const idVenda, idProduto: integer): string;
      function excluirItensDaVenda(const idVenda: integer): string;
    private
      function consultarVendaItens(sql: String): TListaVendasItem;
  end;

implementation

uses uBancoDados;

{ TVendaItemDao }


{ TVendaItemDao }

function TVendaItemDao.AlterarvendaItem(vendaItem: TvendaItem): string;
var
  sql: string;
  query: TZQuery;
begin
  Sql := 'update vendaItens set  ' +
          ' quantidade = :quantidade,  ' +
          ' valor_unitario = :valor_unitario,  ' +
          ' valor_total = :valor_total,  ' +
          'where' +
          'id_pedido = :id_pedido and ' +
          'id_produto = id_produto';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('quantidade').AsFloat:= vendaItem.quantidade;
      query.ParamByName('valor_unitario').AsFloat:= vendaItem.valorUnitario;
      query.ParamByName('valor_total').AsFloat:= vendaItem.valorTotal;
      query.ParamByName('id_pedido').AsInteger:= vendaItem.idPedido;
      query.ParamByName('id_produto').AsInteger:= vendaItem.produto.id;
      query.Connection.Commit;
    except on E: Exception do
      query.Connection.Rollback;
    end;
  finally
    query.free;
  end;

end;

function TVendaItemDao.buscarVendaItemPorId(const idVenda,
  idProduto: integer): TListaVendasItem;
var
  sql: string;
begin
  sql := 'select  vendaItens.id_pedido, ' +
         '        vendaItens.id_produto, ' +
         '        vendaItens.quantidade, ' +
         '        vendaItens.valor_unitario, ' +
	       '        vendaItens.valor_total' +
         'from vendaItens ' +
         'where id_pedido = ' + idVenda.ToString +
         'and id_produto = ' + idProduto.ToString;
  Result := consultarVendaItens(sql);

end;

function TVendaItemDao.consultarVendaItens(sql: String): TListaVendasItem;
var   query : TZQuery;
  vendaItem: TvendaItem;
begin
  Result := TListaVendasItem.Create;
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    query.Open;
    query.First;
    while not query.Eof do
    begin
      vendaItem := TvendaItem.Create;
      vendaItem.idPedido := query.FieldByName('id_pedido').AsInteger;
      vendaItem.produto.id:= query.FieldByName('id_produto').AsInteger;
      vendaItem.quantidade:= query.fieldByName('quantidade').AsFloat;
      vendaItem.valorUnitario:= query.FieldByName('valor_unitario').AsFloat;
      vendaItem.valorTotal :=query.FieldByName('valor_total').AsFloat;
      Result.listaVendasItem.Add(vendaItem);
      query.Next;
    end;

  finally
    query.Connection.Commit;
  end;
end;

function TVendaItemDao.excluirItensDaVenda(const idVenda: integer): string;
var
  sql: String;
  query: TZQuery;
begin
  sql := 'delete from vendaItens where id_pedido = :id_pedido';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id_pedido').AsInteger := idVenda;
      query.ExecSQL;
      query.Connection.Commit;
    except on E: Exception do
       query.Connection.Rollback;
    end;

  finally
    query.Free;
  end;


end;

function TVendaItemDao.excluirVendaItem(const idVenda,
  idProduto: integer): string;
var
  sql: String;
  query: TZQuery;
begin
  sql := 'delete from vendaItens where id_pedido = :id_pedido and id_produto = :id_produto';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id_pedido').AsInteger := idVenda;
      query.ParamByName('id_produto').AsInteger := idProduto;
      query.ExecSQL;
      query.Connection.Commit;
    except on E: Exception do
       query.Connection.Rollback;
    end;

  finally
    query.Free;
  end;

end;

function TVendaItemDao.inserirVendaItem(vendaItem: TvendaItem): String;
var
  sql: String;
  query: TZQuery;
begin

 sql := 'insert into vendaitens(id_pedido, id_produto, quantidade, valor_unitario, valor_total)'  +
                               ' values (:id_pedido, :id_produto, :quantidade, :valor_unitario, :valor_total)';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id_pedido').AsInteger := vendaItem.idPedido;
      query.ParamByName('id_produto').AsInteger := vendaItem.produto.id;
      query.parambyname('quantidade').AsFloat := vendaItem.quantidade;
      query.ParamByName('valor_unitario').AsFloat := vendaItem.valorUnitario;
      query.ParamByName('valor_total').AsFloat := vendaItem.valorTotal;
      query.ExecSQL;
      query.Connection.Commit;
    except on E: Exception do
       query.Connection.Rollback;
    end;

  finally
    query.Free;
  end;


end;

function TVendaItemDao.listarVendaItem(
  const idVenda: Integer): TListaVendasItem;
var
  sql: string;
begin
  sql := 'select  vendaItens.id_pedido, ' +
         '        vendaItens.id_produto, ' +
         '        vendaItens.quantidade, ' +
         '        vendaItens.valor_unitario, ' +
	       '        vendaItens.valor_total' +
         'from vendaItens ' +
         'where id_pedido = ' + idVenda.ToString;
  Result := consultarVendaItens(sql);
end;

{ TVendaItemDao }


end.
