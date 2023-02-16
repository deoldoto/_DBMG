unit vendasDao;

interface

uses
  vendas, cliente, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  listVendas;

type
  TVendaDao = class(TObject)

  public
    function InserirVenda(venda: TVenda): String;
    function listarVendas(): TListVendas;
    function buscarVendaPorId(const id: String): TListVendas;
    function alterarvenda(venda: TVenda): String;
    function excluirVenda(const id: integer): String;
    function geararId(): integer;
    function efetivar(const id: integer): string;
    function relatorioVendasPorCliente(const idCliente: integer): TListVendas;

  private
    function consultarVenda(const sql: String): TListVendas;
  end;

implementation

uses
  uBancoDados;

{ TVendaDao }

function TVendaDao.alterarvenda(venda: TVenda): String;
var
  sql: string;
  query: TZQuery;
begin

  sql := 'update vendas set  ' + ' id_cliente = :id_cliente,  ' +
    ' status = :status, ' + ' hora= :hora,' + ' valor_total= :valor_total' +
    'where' + 'id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id_cliente').AsInteger := venda.cliente.id;
      query.ParamByName('status').AsString := venda.status;
      query.ParamByName('hora').AsDateTime := venda.hora;
      query.ParamByName('valor_total').AsFloat := venda.valorTotal;
      query.ParamByName('id').AsInteger := venda.id;
      query.Connection.Commit;
    except
      on E: Exception do
      begin

        query.Connection.Rollback;
      end;
    end;
  finally
    query.free;
  end;
end;

function TVendaDao.buscarVendaPorId(const id: String): TListVendas;
var
  sql: String;
begin
  sql := 'select ' + '  vendas.id, ' + '	vendas.hora, ' +
    '	vendas.valor_total, ' + ' 	vendas.status ' + '  vendas.id_cliente ' +
    'from vendas ' + 'where vendas.id = ' + id;
  Result := consultarVenda(sql);

end;

function TVendaDao.consultarVenda(const sql: String): TListVendas;
var
  query: TZQuery;
  venda: TVenda;
begin
  Result := TListVendas.Create;
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    query.Open;
    query.First;
    while not query.Eof do
    begin
      venda := TVenda.Create;
      venda.id := query.FieldByName('id').AsInteger;
      venda.cliente.id := query.FieldByName('id_cliente').AsInteger;
      venda.valorTotal := query.FieldByName('valor_total').AsFloat;
      venda.hora := query.FieldByName('hora').AsDateTime;
      venda.status := query.FieldByName('status').AsString;
      Result.listVendas.Add(venda);
      query.Next;
    end;

  finally
    query.Connection.Commit;
  end;

end;

function TVendaDao.efetivar(const id: integer): string;
var
  sql: string;
  query: TZQuery;
begin

  sql := 'update vendas set ' +
    ' status = ' + QuotedStr('efetivada') +
    'where' + 'id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id').AsInteger := id;
      query.Connection.Commit;
    except
      on E: Exception do
      begin

        query.Connection.Rollback;
      end;
    end;
  finally
    query.free;
  end;
end;

function TVendaDao.excluirVenda(const id: integer): String;
var
  sql: String;
  query: TZQuery;
begin
  sql := 'delete from vendas where id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id').AsInteger := id;
      query.ExecSQL;
      query.Connection.Commit;
    except
      on E: Exception do
        query.Connection.Rollback;
    end;

  finally
    query.free;
  end;

end;

function TVendaDao.geararId: integer;
var
  sql: String;
  query: TZQuery;
begin
  sql := 'select coalesce(max(id),0) + 1 as id from vendas';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.Open;

      Result := query.FieldByName('id').AsInteger;
    except
      on E: Exception do
      begin
        writeln('Falha ao executar a consulta : ' + query.sql.Text);
        Result := 0;
        query.Connection.Rollback;
      end;
    end;
  finally
    query.Connection.Commit;
  end;
end;

function TVendaDao.InserirVenda(venda: TVenda): String;
var
  cSql: String;
  query: TZQuery;
begin

  cSql := 'insert into vendas(id, hora, valor_total, id_cliente, status)' +
    ' values(:id, :hora, :valor_total, :id_cliente, :status)';

  query := TBancoDadosSingleton.obterInstancia.obterConsulta(cSql);
  try
    query := TBancoDadosSingleton.obterInstancia.obterConsulta(cSql);
    query.ParamByName('id').AsInteger := venda.id;
    query.ParamByName('hora').AsDate := venda.hora;
    query.ParamByName('valor_total').AsFloat := venda.valorTotal;
    query.ParamByName('id_cliente').AsInteger := venda.cliente.id;
    query.ParamByName('status').AsString := venda.status;
    query.ExecSQL;
    query.Connection.Commit;
  except
    on E: Exception do
      Result := 'Falha ao executar a consulta : ' + query.sql.Text;
  end;
  Result := EmptyStr;

end;

function TVendaDao.listarVendas: TListVendas;
var
  sql: String;
begin
  sql := 'select ' + '  vendas.id, ' + '	vendas.hora, ' +
    '	vendas.valor_total, ' + ' 	vendas.status ' + '  vendas.id_cliente ' +
    'from vendas ';
  Result := consultarVenda(sql);
end;

function TVendaDao.relatorioVendasPorCliente(
  const idCliente: integer): TListVendas;
var
  sql: String;
begin
  sql := 'select ' + '  vendas.id, ' + '	vendas.hora, ' +
    '	vendas.valor_total, ' + ' 	vendas.status ' + '  vendas.id_cliente ' +
    'from vendas ' + 'where vendas.id_cliente = ' + idCliente.ToString +
    'and status = ' + QuotedStr('efetivada') +
    'order by hora';
  Result := consultarVenda(sql);

end;

end.
