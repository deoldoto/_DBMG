unit produtoDao;

interface

uses
  Fornecedor, Produto, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  listProduto;

type
  TProdutoDao = class(tObject)

  public
    function inserirProduto(Produto: TProduto): String;
    function listarProdutos(): tListProduto;
    function buscarProdutoPorId(const id: String): tListProduto;
    function alterarProduto(Produto: TProduto): String;
    function excluirProduto(const id: integer): String;
    function efetivar(const id: integer): string;
    function GerarID(): integer;

  private
    function consultarProduto(const SQL: String): tListProduto;
  end;

implementation

uses
  uBancoDados;

{ TProdutoDao }

function TProdutoDao.alterarProduto(Produto: TProduto): String;
var
  SQL: string;
  query: TZQuery;
begin
  SQL := 'update produtos set  ' + ' descricao = :descricao,  ' +
    ' status = :status, ' + ' id_fornecedor = :id_fornecedor,' +
    ' valor = :valor' + 'where' + 'id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(SQL);
  try
    try
      query.ParamByName('descricao').AsString := Produto.descricao;
      query.ParamByName('status').AsString := Produto.status;
      query.ParamByName('valor').AsFloat := Produto.valor;
      query.ParamByName('id_fornecedor').AsInteger := Produto.idfornecedor;
      query.ParamByName('id').AsInteger := Produto.id;
      query.Connection.Commit;
    except
      on E: Exception do
        query.Connection.Rollback;
    end;
  finally
    query.free;
  end;

end;

function TProdutoDao.buscarProdutoPorId(const id: String): tListProduto;
var
  SQL: String;
begin
  SQL := 'select  produtos.id, ' + '        produtos.id_fornecedor, ' +
    '        produtos.descricao, ' + '        produtos.status, ' +
    '        produto.valor, ' + 'from produtos ' + 'where produtos.id = ' + id;
  Result := consultarProduto(SQL);

end;

function TProdutoDao.consultarProduto(const SQL: String): tListProduto;
var
  query: TZQuery;
  Produto: TProduto;
begin
  Result := tListProduto.Create;
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(SQL);
  try
    query.Open;
    query.First;
    while not query.Eof do
    begin
      Produto := TProduto.Create;
      Produto.id := query.FieldByName('id').AsInteger;
      Produto.descricao := query.FieldByName('descricao').AsString;
      Produto.valor := query.FieldByName('valor').AsFloat;
      Produto.idfornecedor := query.FieldByName('id_fornecedor').AsInteger;
      Produto.status := query.FieldByName('status').AsString;
      Result.listProduto.Add(Produto);
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
  SQL: String;
  query: TZQuery;
begin
  SQL := 'delete from produtos where id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(SQL);
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

function TProdutoDao.GerarID: integer;
var
  SQL: String;
  query: TZQuery;
begin
  SQL := 'select coalesce(max(id),0) + 1 as id from produtos';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(SQL);
  try
    try
      query.Open;

      Result := query.FieldByName('id').AsInteger;
    except
      on E: Exception do
      begin
        writeln('Falha ao executar a consulta : ' + query.SQL.Text);
        Result := 0;
        query.Connection.Rollback;
      end;
    end;
  finally
    query.Connection.Commit;
  end;

end;

function TProdutoDao.inserirProduto(Produto: TProduto): String;
var
  cSql: String;
  query: TZQuery;
begin
  cSql := 'insert into produtos(id, descricao, valor, id_fornecedor, status)' +
    ' values(:id, :descricao, :valor, :id_fornecedor, :status)';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(cSql);
  try
    query.ParamByName('id').AsInteger := Produto.id;
    query.ParamByName('descricao').AsString := Produto.descricao;
    query.ParamByName('status').AsString := Produto.status;
    query.ParamByName('valor').AsFloat := Produto.valor;
    query.ParamByName('id_fornecedor').AsInteger := Produto.idfornecedor;
    query.ExecSQL;
    query.Connection.Commit;
  except
    on E: Exception do
      Result := 'Falha ao executar a consulta : ' + query.SQL.Text;
  end;
  Result := EmptyStr;

end;

function TProdutoDao.listarProdutos: tListProduto;
var
  SQL: string;
begin
  SQL := 'select  produtos.id, ' + '        produtos.id_fornecedor, ' +
    '        produtos.descricao, ' + '        produtos.status, ' +
    '        produtos.valor ' + 'from produtos ';
  Result := consultarProduto(SQL);
end;

end.
