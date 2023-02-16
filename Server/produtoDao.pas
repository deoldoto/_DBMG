unit produtoDao;

interface
uses
  Fornecedor, Produto, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, listProduto;

type
  TProdutoDao = class(tObject)

  public
    function inserirProduto(produto: TProduto): String;
    function listarProdutos(): tListProduto;
    function buscarProdutoPorId(const id: String): TListProduto;
    function alterarProduto(produto: TProduto): String;
    function excluirProduto(const id: integer): String;
    function efetivar(const id: integer): string;
    function GerarID(): Integer;

  private
    function consultarProduto(const SQL: String): TListProduto;
  end;


implementation
uses
  uBancoDados;

{ TProdutoDao }

function TProdutoDao.alterarProduto(produto: TProduto): String;
var
  sql: string;
  query: TZQuery;
begin
  Sql := 'update produtos set  ' +
          ' descricao = :descricao,  ' +
          ' status = :status, ' +
          ' id_fornecedor = :id_fornecedor,' +
          ' valor = :valor' +
          'where' +
          'id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('descricao').AsString:= produto.descricao;
      query.ParamByName('status').AsString := produto.status;
      query.ParamByName('valor').AsFloat := produto.valor;
      query.ParamByName('id_fornecedor').AsInteger := produto.idfornecedor;
      query.ParamByName('id').AsInteger := produto.id;
      query.Connection.Commit;
    except on E: Exception do
      query.Connection.Rollback;
    end;
  finally
    query.free;
  end;


end;

function TProdutoDao.buscarProdutoPorId(const id: String): TListProduto;
var
  sql: String;
begin
  sql := 'select  produtos.id, ' +
         '        produtos.id_fornecedor, ' +
         '        produtos.descricao, ' +
         '        produtos.status, ' +
	       '        produto.valor, '+
         'from produtos ' +
         'where produtos.id = ' + id;
  Result := consultarProduto(sql);

end;

function TProdutoDao.consultarProduto(const SQL: String): TListProduto;
var   query : TZQuery;
  produto: tProduto;
begin
  Result := tListProduto.Create;
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    query.Open;
    query.First;
    while not query.Eof do
    begin
      produto := TProduto.Create;
      produto.id:= query.FieldByName('id').AsInteger;
      produto.descricao:= query.FieldByName('descricao').AsString;
      produto.valor:= query.fieldByName('valor').AsFloat;
      produto.idFornecedor:= query.FieldByName('id_fornecedor').AsInteger;
      produto.status:= query.fieldByName('status').AsString;
      Result.listProduto.Add(produto);
      query.Next;
    end;

  finally
    query.Connection.Commit;
  end;


end;

function TProdutoDao.efetivar(const id: integer): string;
begin

end;

function TProdutoDao.excluirProduto(const id: integer): String;
var
  sql: String;
  query: TZQuery;
begin
  sql := 'delete from produtos where id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id').AsInteger := id;
      query.ExecSQL;
      query.Connection.Commit;
    except on E: Exception do
       query.Connection.Rollback;
    end;

  finally
    query.Free;
  end;
end;

function TProdutoDao.GerarID: Integer;
var sql: String;
    query: TZQuery;
begin
  sql := 'select coalesce(max(id),0) + 1 as id from produtos';
    query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.open;

      Result := query.FieldByName('id').AsInteger;
    except
       on E: Exception do
    begin
      writeln( 'Falha ao executar a consulta : ' +
      query.SQL.Text);
      result := 0;
      query.Connection.Rollback;
    end;
  end;
  finally
    query.Connection.Commit;
  end;



end;

function TProdutoDao.inserirProduto(produto: TProduto): String;
var cSql: String;
  query: TZQuery;
begin
   cSql := 'insert into produtos(id, descricao, valor, id_fornecedor, status)' +
    ' values(:id, :descricao, :valor, :id_fornecedor, :status)';
    query := TBancoDadosSingleton.obterInstancia.obterConsulta(cSql);
  try
    query.ParamByName('id').AsInteger := produto.id;
    query.paramByName('descricao').AsString:= produto.descricao;
    query.ParamByName('status').AsString := produto.status;
    query.paramByname('valor').Asfloat:= produto.valor;
    query.paramByname('id_fornecedor').AsInteger := produto.idfornecedor;
    query.ExecSQL;
    query.Connection.Commit;
  except on E: Exception do
    Result := 'Falha ao executar a consulta : ' +
      query.SQL.Text;
  end;
  result := EmptyStr;


end;

function TProdutoDao.listarProdutos: tListProduto;
var
  sql: string;
begin
  sql := 'select  produtos.id, ' +
         '        produtos.id_fornecedor, ' +
         '        produtos.descricao, ' +
         '        produtos.status, ' +
	       '        produtos.valor '+
         'from produtos ';
  Result := consultarProduto(sql);
end;

end.
