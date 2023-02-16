unit fornecedorService;

interface
uses fornecedor, fornecedorDAO, listfornecedor, system.Generics.Collections, system.Sysutils,
    pessoaService;
type
  TFornecedorService = class
    private
    fornecedorDao: TFornecedorDao;

    public
    function InserirFornecedor(fornecedor: TFornecedor): String;
    function ListarFornecedor(): TListFornecedor;
    function BuscarFornecedorPorId(const id: String): TListFornecedor;
    function alterarFornecedor(fornecedor: TFornecedor): String;
    function excluirFornecedor(const id: integer): String;
    constructor Create();
  end;

implementation

{ TClienteService }

function TFornecedorService.alterarFornecedor(fornecedor: TFornecedor): String;
var
  pessoaService: TPessoaService;
  retornoPessoa: String;
begin
  pessoaService := TPessoaService.Create;
  try
    try
      retornoPessoa := pessoaService.alterarPessoa(fornecedor);
      if retornoPessoa <> EmptyStr then
      begin
        Result := retornoPessoa;
        exit;
      end;
      fornecedorDao.alterarFornecedor(fornecedor);
    except on E: Exception do
    end;
  finally
    pessoaService.Create;
  end;

end;

function TFornecedorService.BuscarFornecedorPorId(
  const id: String): TListFornecedor;
begin
  Result := fornecedorDao.buscarFornecedorPorId(id);
end;

constructor TFornecedorService.Create;
begin
  inherited;
  fornecedorDao := TFornecedorDao.Create;
end;

function TFornecedorService.excluirFornecedor(const id: integer): String;
begin
  Result := fornecedorDao.excluirFornecedor(id);
  if Result <> EmptyStr then
    exit;
  fornecedorDao.excluirFornecedor(id);

end;

function TFornecedorService.InserirFornecedor(fornecedor: TFornecedor): String;
var
  pessoaService: TPessoaService;
  idFornecedor: integer;
begin
  pessoaService := TPessoaService.Create;
  try
    try
      idFornecedor:= fornecedorDao.GerarID;
      if idFornecedor= 0 then
      begin
        result := 'Falha ao gerar o id do fornecedor.';
        exit;
      end;
      pessoaService.InserirPessoa(fornecedor);

      if fornecedor.idPessoa = 0 then
      begin
        Result := 'Falha ao inserir pessoa do cliente';
        exit;
      end;
      fornecedor.id := idFornecedor;
      fornecedorDao.inserirFornecedor(fornecedor);


    except on E: Exception do
      begin
        result := 'falha ao inserir Fornecedor:' + E.Message;
        writeLn(Result);
      end;
    end;
  finally
    pessoaService.Free;
  end;
end;

function TFornecedorService.ListarFornecedor: TListFornecedor;
begin
  Result := fornecedorDao.listarFornecedor;
end;

end.
