unit fornecedorDao;

interface

uses
  Fornecedor, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, listFornecedor;

  type
  TFornecedorDao = class(tObject)

  public
    function inserirFornecedor(fornecedor: TFornecedor): String;
    function listarFornecedor(): tListFornecedor;
    function buscarFornecedorPorId(const id: String): tListFornecedor;
    function alterarFornecedor(Fornecedor: TFornecedor): String;
    function excluirFornecedor(const id: integer): String;
    function GerarID(): Integer;

  private
    function consultarFornecedor(const SQL: String): tListFornecedor;
  end;

implementation

uses uBancoDados;

{ TFornecedorDao }

function TFornecedorDao.alterarFornecedor(Fornecedor: TFornecedor): String;
var
  sql: string;
  query: TZQuery;
begin
  Sql := 'update fornecedores set  ' +
          ' nome_fantasia = :nome_fantasia,  ' +
          ' status = :status ' +
          'where' +
          'id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('nome_fantasia').AsString:= Fornecedor.nomeFantasia;
      query.ParamByName('status').AsString := fornecedor.status;
      query.ParamByName('id').AsInteger := fornecedor.idPessoa;
      query.Connection.Commit;
    except on E: Exception do
      query.Connection.Rollback;
    end;
  finally
    query.free;
  end;
end;

function TFornecedorDao.buscarFornecedorPorId(
  const id: String): tListFornecedor;
var
  sql : string;
begin
  sql := 'select  fornecedores.id, ' +
         '         fornecedores.id_pessoa, ' +
         '         fornecedores.nome_fantasia, ' +
         '         fornecedores.status, ' +
	       '        pessoa.nome, pessoa.cpf_cnpj ' +
         'from fornecedores ' +
         '	left join pessoa on fornecedores.id_pessoa = pessoa.id ' +
         'where ' +
		     '  fornecedores.id = ' + id;
  Result := consultarFornecedor(sql);

end;

function TFornecedorDao.consultarFornecedor(const SQL: String): tListFornecedor;
var   query : TZQuery;
  fornecedor: TFornecedor;
begin
  Result := TListFornecedor.Create;
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    query.Open;
    query.First;
    while not query.Eof do
    begin
      fornecedor := TFornecedor.Create;
      fornecedor.idPessoa := query.FieldByName('id_pessoa').AsInteger;
      fornecedor.nome := query.FieldByName('nome').AsString;
      fornecedor.cpf_cnpj := query.fieldByName('cpf_cnpj').AsString;
      fornecedor.status:= query.FieldByName('status').AsString;
      fornecedor.nomeFantasia:=query.FieldByName('nome_fantasia').AsString; //query.FieldByName('data_nascimento').AsDatetime;
      fornecedor.id:= query.FieldByName('id').AsInteger;
      Result.listaFornecedor.Add(fornecedor);
      query.Next;
    end;

  finally
    query.Connection.Commit;
  end;


end;

function TFornecedorDao.excluirFornecedor(const id: integer): String;
var
  sql: String;
  query: TZQuery;
begin
  sql := 'delete from fornecedores where id = :id';
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

function TFornecedorDao.GerarID: Integer;
var sql: String;
    query: TZQuery;
begin
  sql := 'select coalesce(max(id),0) + 1 as id from fornecedores';
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

function TFornecedorDao.inserirFornecedor(fornecedor: TFornecedor): String;
var cSql: String;
  query: TZQuery;
begin
   cSql := 'insert into fornecedores(id, id_pessoa, status, nome_fantasia)' +
    ' values(:id, :id_pessoa, :status, :nome_fantasia)';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(cSql);
  try
    query.ParamByName('id').AsInteger := fornecedor.id;
    query.paramByName('id_pessoa').Asinteger:= fornecedor.idPessoa;
    query.ParamByName('status').AsString := fornecedor.Status;
    query.paramByname('nome_fantasia').AsString := fornecedor.nomeFantasia;
    query.ExecSQL;
    query.Connection.Commit;
  except on E: Exception do
    Result := 'Falha ao executar a consulta : ' +
      query.SQL.Text;
  end;
  result := EmptyStr;

end;

function TFornecedorDao.listarFornecedor: tListFornecedor;
var
  sql: string;
begin
  sql := 'select  fornecedores.id, ' +
         '        fornecedores.id_pessoa, ' +
         '        fornecedores.nome_fantasia, ' +
         '        fornecedores.status, ' +
	       '        pessoa.nome, pessoa.cpf_cnpj ' +
         'from fornecedores' +
         '	left join pessoa on fornecedores.id_pessoa = pessoa.id ';
  Result := consultarFornecedor(sql);
end;

end.
