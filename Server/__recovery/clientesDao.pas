unit clientesDao;

interface

uses
  Cliente, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  listCliente;

type
  TClienteDao = class(tObject)

  public
    function inserirCliente(pessoa: TCliente): String;
    function listarCliente(): tListCliente;
    function buscarClientePorId(const id: String): tListCliente;
    function alterarCliente(Cliente: TCliente): String;
    function excluirCliente(Cliente: TCliente): String;
    function GerarID(): Integer;
    function buscarClientesAtivos(): tListCliente;
  private
    function consultarCliente(const SQL: String): tListCliente;
  end;

implementation

uses uBancoDados, pessoaDAO;

{ TPessoaFisicaDAO }

function TClienteDao.alterarCliente(Cliente: TCliente): String;
var
  SQL: string;
  query: TZQuery;
begin
  SQL := 'update clientes set  ' + ' data_nascimento = :data_nascimento,  ' +
    ' status = :status ' + 'where' + 'id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(SQL);
  try
    try
      query.ParamByName('data_nascimento').AsDate := Cliente.dataNascimento;
      query.ParamByName('status').AsString := Cliente.status;
      query.ParamByName('id').AsInteger := Cliente.id;
      query.Connection.Commit;
    except
      on E: Exception do
        query.Connection.Rollback;
    end;
  finally
    query.free;
  end;

end;

function TClienteDao.buscarClientePorId(const id: String): tListCliente;
var
  SQL: string;
begin
  SQL := 'select  clientes.id, ' + '         clientes.id_pessoa, ' +
    '         clientes.data_nascimento, ' + '         clientes.status, ' +
    '        pessoa.nome, pessoa.cpf_cnpj ' + 'from clientes ' +
    '	left join pessoa on clientes.id_pessoa = pessoa.id ' + 'where ' +
    '  clientes.id = ' + id;
  Result := consultarCliente(SQL);

end;

function TClienteDao.buscarClientesAtivos: tListCliente;
var
  SQL: string;
begin
  SQL := 'select  clientes.id, ' + '         clientes.id_pessoa, ' +
    '         clientes.data_nascimento, ' + '         clientes.status, ' +
    '        pessoa.nome, pessoa.cpf_cnpj ' + 'from clientes ' +
    '	left join pessoa on clientes.id_pessoa = pessoa.id ' + 'where ' +
    '  clientes.status = ' + QuotedStr('Ativo');
  Result := consultarCliente(SQL);

end;

function TClienteDao.consultarCliente(const SQL: String): tListCliente;
var
  query: TZQuery;
  Cliente: TCliente;
begin
  Result := tListCliente.Create;
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(SQL);
  try
    query.Open;
    query.First;
    while not query.Eof do
    begin
      Cliente := TCliente.Create;
      Cliente.idPessoa := query.FieldByName('id_pessoa').AsInteger;
      Cliente.nome := query.FieldByName('nome').AsString;
      Cliente.cpf_cnpj := query.FieldByName('cpf_cnpj').AsString;
      Cliente.status := query.FieldByName('status').AsString;
      Cliente.dataNascimento := now;
      // query.FieldByName('data_nascimento').AsDatetime;
      Cliente.id := query.FieldByName('id').AsInteger;
      Result.listaCliente.Add(Cliente);
      query.Next;
    end;

  finally
    query.Connection.Commit;
  end;

end;

function TClienteDao.excluirCliente(Cliente: TCliente): String;
var
  SQL: String;
  query: TZQuery;
begin
  Result := EmptyStr;
  SQL := 'delete from clientes where id = :id';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(SQL);
  query.Connection.Commit;
  // query.Connection.StartTransaction;
  try
    try
      query.ParamByName('id').AsInteger := Cliente.id;
      query.ExecSQL;
      // Result :=  pessoaDAO.excluirPessoa(cliente.idPessoa);
      if Result <> EmptyStr then
      begin
        query.Connection.Rollback;
        exit;
      end;
      query.Connection.Commit;
    except
      on E: Exception do
      begin
        Result := 'falha ao excluir o cliente: ' + E.Message;
        query.Connection.Rollback;
      end;
    end;

  finally
    query.free;
  end;
end;

function TClienteDao.GerarID: Integer;
var
  SQL: String;
  query: TZQuery;
begin
  SQL := 'select coalesce(max(id),0) + 1 as id from clientes';
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

function TClienteDao.inserirCliente(pessoa: TCliente): String;
var
  cSql: String;
  query: TZQuery;
begin
  Result := EmptyStr;
  cSql := 'insert into clientes(id, id_pessoa, status, data_nascimento)' +
    ' values(:id, :id_pessoa, :status, :data_Nascimento)';
  query := TBancoDadosSingleton.obterInstancia.obterConsulta(cSql);
  try
    query.ParamByName('id').AsInteger := pessoa.id;
    query.ParamByName('id_pessoa').AsInteger := pessoa.idPessoa;
    query.ParamByName('status').AsString := pessoa.status;
    query.ParamByName('data_nascimento').AsDate := pessoa.dataNascimento;
    query.ExecSQL;
    query.Connection.Commit;
  except
    on E: Exception do
      Result := 'Falha ao executar a consulta : ' + query.SQL.Text;
  end;
  Result := EmptyStr;

end;

function TClienteDao.listarCliente: tListCliente;
var
  SQL: string;
begin
  SQL := 'select  clientes.id, ' + '         clientes.id_pessoa, ' +
    '         clientes.data_nascimento, ' + '         clientes.status, ' +
    '        pessoa.nome, pessoa.cpf_cnpj ' + 'from clientes ' +
    '	left join pessoa on clientes.id_pessoa = pessoa.id ';
  Result := consultarCliente(SQL);

end;

end.
