unit pessoaService;

interface

uses UPessoa, pessoaDao, System.JSON, listPessoa, system.Generics.Collections, system.Sysutils;
type
  TPessoaService = class
    private

    public
    function InserirPessoa(Pessoa: TPessoa): String;

    function ListarPessoas(): tListPessoa;
    function BuscarPessoaPorId(const id: String): tListPessoa;
    function alterarPessoa(pessoa: TPessoa): String;
    function excluirPessoa(const id: integer): String;


  end;
implementation

{ TPessoaService }

function TPessoaService.alterarPessoa(pessoa: TPessoa): String;
var
  pessoaDao: TPessoaDAO;
begin
    pessoaDao := TPessoaDAO.Create;
  try
    Result := pessoaDao.alterarPessoa(Pessoa);
  finally
    pessoaDao.Free;
    writeLn('Pessoa alterada');

  end;


end;

function TPessoaService.BuscarPessoaPorId(const id: String): tListPessoa;
var
  pessoaDao: TPessoaDAO;
begin
    pessoaDao := TPessoaDAO.Create;
  try
    Result := pessoaDao.BuscarPessoaPorId(id);
  finally
    pessoaDao.Free;
    writeLn('Pessoa Cadastrada');

  end;

end;

function TPessoaService.excluirPessoa(const id: integer): String;
var
  pessoaDao: TPessoaDAO;
begin
    pessoaDao := TPessoaDAO.Create;
  try
    Result := pessoaDao.excluirPessoa(id);
  finally
    pessoaDao.Free;
    writeLn('Pessoa excluida');
  end;

end;

function TPessoaService.InserirPessoa(Pessoa: TPessoa): String;
var
  pessoaDao: TPessoaDAO;
begin
    pessoaDao := TPessoaDAO.Create;
  try
    if pessoaDao.buscarPessoaPorCPf(pessoa.cpf_cnpj).listPessoas.Count > 0 then
    begin
      Result := 'Já existe uma pessoa com o CPF/CNPJ informado';
      exit;
    end;

    pessoa.idPessoa := pessoaDao.GerarID;
    if pessoa.idPessoa = 0 then
    begin
      result := 'Falha ao gerar o id sequencial de pessoa.';
      exit;
    end;

    Result := pessoaDao.inserirPessoa(Pessoa);
    result := EmptyStr
  finally
    pessoaDao.Free;
    writeLn('Pessoa Cadastrada');

  end;
end;

function TPessoaService.ListarPessoas: tListPessoa;
var
  pessoaDao: TPessoaDAO;
begin
    pessoaDao := TPessoaDAO.Create;
  try
    Result := pessoaDao.ListarPessoas;
  finally
    pessoaDao.Free;
    writeLn('Pessoa Cadastrada');

  end;

end;

end.
