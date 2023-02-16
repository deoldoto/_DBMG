unit clienteService;

interface

uses cliente, clientesDAO, listCliente, system.Generics.Collections,
  system.Sysutils,
  pessoaService;

type
  TClienteService = class
  private
    clienteDao: tclienteDao;

  public
    function InserirCliente(cliente: TCliente): String;
    function ListarCliente(): tListCliente;
    function BuscarclientePorId(const id: String): tListCliente;
    function alterarCliente(cliente: TCliente): String;
    function excluirCliente(const id: integer): String;
    function buscarClientesAtivos(): tListCliente;
    constructor Create();
  end;

implementation

{ TPessoaService }

function TClienteService.alterarCliente(cliente: TCliente): String;
var
  pessoaService: TPessoaService;
  retornoPessoa: String;
begin
  pessoaService := TPessoaService.Create;
  try
    try
      retornoPessoa := pessoaService.alterarPessoa(cliente);
      if retornoPessoa <> EmptyStr then
      begin
        Result := retornoPessoa;
        exit;
      end;

      clienteDao.alterarCliente(cliente);

    except
      on E: Exception do
    end;
  finally
    pessoaService.Create;
  end;
end;

function TClienteService.BuscarclientePorId(const id: String): tListCliente;
begin
  Result := clienteDao.BuscarclientePorId(id);
end;

function TClienteService.buscarClientesAtivos: tListCliente;
begin
  Result := clienteDao.buscarClientesAtivos;
end;

constructor TClienteService.Create;
begin
  inherited;
  clienteDao := tclienteDao.Create;
end;

function TClienteService.excluirCliente(const id: integer): String;
var
  cliente: TCliente;
  listCliente: tListCliente;
begin
  listCliente := clienteDao.BuscarclientePorId(id.ToString);
  if listCliente.listaCliente.Count = 0 then
  begin
    Result := 'Cliente não localizado para exclsão';
    exit;
  end;
  cliente := listCliente.listaCliente[0];
  { TODO -oOwner -cGeneral : Ajsutar remoção de cliente }
  clienteDao.excluirCliente(cliente);
end;

function TClienteService.InserirCliente(cliente: TCliente): String;
var
  pessoaService: TPessoaService;
  idCliente: integer;
  retornoPessoa: String;
begin
  pessoaService := TPessoaService.Create;
  try
    try

      idCliente := clienteDao.GerarID;
      if idCliente = 0 then
      begin
        Result := 'Falha ao gerar o id co cliente.';
        exit;
      end;
      retornoPessoa := pessoaService.InserirPessoa(cliente);

      if cliente.idPessoa = 0 then
      begin
        Result := retornoPessoa;
        exit;
      end;
      cliente.id := idCliente;
      Result := clienteDao.InserirCliente(cliente);

    except
      on E: Exception do
      begin
        Result := 'falha ao inserir cliente:' + E.Message;
        writeLn(Result);
      end;
    end;
  finally
    pessoaService.Free;
  end;

end;

function TClienteService.ListarCliente: tListCliente;
begin
  Result := clienteDao.ListarCliente;
end;

end.
