unit pessoaDao;

interface


uses
  uPessoa, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, listPessoa;

type
  TPessoaDAO = class(tObject)

  public
    function inserirPessoa(pessoa: TPessoa): String;
    function listarPessoas(): tListPessoa;
    function buscarPessoaPorId(const id: String): tListPessoa;
    function alterarPessoa(pessoa: TPessoa): String;
    function excluirPessoa(const id: integer): String;
    function buscarPessoaPorCPf(const CPF: String): TListPessoa;
    function GerarID(): Integer;


  private
    function consultarPessoa(const SQL: String): tListPessoa;

  end;

implementation

uses uBancoDados;

{ TPessoaDAO }

function TPessoaDAO.inserirPessoa(pessoa: TPessoa): String;
var cSql: String;
  query: TZQuery;
begin
   cSql := 'insert into pessoa(id, nome, cpf_cnpj)' +
    ' values(:id, :nome, :cpf_cnpj)';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(cSql);
  try
    query.ParamByName('id').AsInteger := pessoa.idPessoa;
    query.paramByName('nome').AsString := pessoa.nome;
    query.ParamByName('cpf_cnpj').AsString := pessoa.cpf_cnpj;
    query.ExecSQL;
    query.Connection.Commit;
  except on E: Exception do
    Result := 'Falha ao executar a consulta : ' +
      query.SQL.Text;
  end;
  result := EmptyStr;
end;

function TPessoaDAO.alterarPessoa(pessoa: TPessoa): String;
var
  sql: String;
  query: TZQuery;
begin
    sql := 'update pessoa set nome = :nome, cpf_cnpj = :cpf_cnpj  where id = :id';
    query := TBancoDadosSingleton.obterInstancia.obterConsulta(Sql);
  try
    query.ParamByName('id').AsInteger := pessoa.idPessoa;
    query.paramByName('nome').AsString := pessoa.nome;
    query.ParamByName('cpf_cnpj').AsString := pessoa.cpf_cnpj;
    query.ExecSQL;
    query.Connection.Commit;
  except on E: Exception do
    Result := 'Falha ao executar a consulta : ' +
      query.SQL.Text;
  end;
  result := EmptyStr;
end;

function TPessoaDAO.buscarPessoaPorCPf(const CPF: String): TListPessoa;
var sql : String;
begin
  sql := 'select id, nome, cpf_cnpj from pessoa where cpf_cnpj = ' + CPF;
  Result := consultarPessoa(sql);

end;

function TPessoaDAO.BuscarPessoaPorId(const id: String): tListPessoa;
var sql : String;
begin
  sql := 'select id, nome, cpf_cnpj from pessoa where id = ' + id;
  Result := consultarPessoa(sql);

end;

function TPessoaDAO.ListarPessoas: tListPessoa;
var
  sql : string;
begin
  sql := 'select id, nome, cpf_cnpj from pessoa';
  Result := consultarPessoa(sql);

end;


function TPessoaDAO.consultarPessoa(const SQL: String): tListPessoa;
var   query : TZQuery;
  pessoa: tPessoa;
begin
  Result := tListPessoa.Create;
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    query.Open;
    query.First;
    while not query.Eof do
    begin
      pessoa := TPessoa.Create;
      pessoa.idPessoa := query.FieldByName('id').AsInteger;
      pessoa.nome := query.FieldByName('nome').AsString;
      pessoa.cpf_cnpj := query.fieldByName('cpf_cnpj').AsString;
      Result.listPessoas.Add(pessoa);
      query.Next;
    end;

  finally
    query.Connection.Commit;
  end;
end;

function TPessoaDAO.excluirPessoa(const id: integer): String;
var sql: String;
    query: TZQuery;
begin
  sql := 'delete from pessoa where id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(sql);
  try
    try
      query.ParamByName('id').AsString := id.ToString;
      query.ExecSQL;
    except
       on E: Exception do
    begin
      Result := 'Falha ao executar a consulta : ' +
      query.SQL.Text;
//     query.Connection.Rollback;
    end;
  end;
  finally
    query.Connection.Commit;
  end;
end;


function TPessoaDAO.GerarID: Integer;
var sql: String;
    query: TZQuery;
begin
  sql := 'select coalesce(max(id),0) + 1 as id from pessoa';
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

end.
