unit produtoService;

interface
uses produto, produtoDAO, listProduto, system.Generics.Collections, system.Sysutils,
  fornecedorService, listFornecedor;
type
  TProdutoService = class
    private
    produtoDao: TProdutoDao;
    function validaProduto(produto: tProduto): String;

    public
    function InserirProduto(produto: tProduto): String;
    function ListarProduto(): TListProduto;
    function BuscarProdutoPorId(const id: String): TListProduto;
    function alterarProduto(produto: TProduto): String;
    function excluirProduto(const id: integer): String;
    constructor Create();
  end;

implementation

{ TProdutoService }

function TProdutoService.alterarProduto(produto: TProduto): String;

begin
  Result := validaProduto(produto);
  if not Result.IsEmpty then
    exit;

  Result := produtoDao.alterarProduto(produto);
end;

function TProdutoService.BuscarProdutoPorId(const id: String): TListProduto;
begin
  Result := produtoDao.buscarProdutoPorId(id);
end;

constructor TProdutoService.Create;
begin
  inherited;
  produtoDao := TProdutoDao.Create;
end;

function TProdutoService.excluirProduto(const id: integer): String;
begin
  produtoDao.excluirProduto(id);
end;

function TProdutoService.InserirProduto(produto: tProduto): String;
var
  idProduto: integer;
begin
  Result := validaProduto(produto);
  if not Result.IsEmpty then
    exit;

  try
    idProduto := produtoDao.GerarID;
    produto.id := idProduto;
    Result := produtoDao.inserirProduto(Produto);

  except on E: Exception do
  begin
    result := 'falha ao incluir o produto:' + e.Message;
  end;
  end;
end;

function TProdutoService.ListarProduto: TListProduto;
begin
  Result := produtoDao.listarProdutos;
end;

function TProdutoService.validaProduto(produto: tProduto): String;
var
  fornecedorService : TFornecedorService;
  listfornecedor: TListFornecedor;
begin
  Result := EmptyStr;
  if produto.valor = 0 then
  begin
    Result := 'O produto não pode ter o valor zerado';
    exit;
  end;

  fornecedorService := TFornecedorService.Create;
  try
    listfornecedor := fornecedorService.BuscarFornecedorPorId(produto.idfornecedor.ToString);
    if listfornecedor.listaFornecedor.Count = 0 then
    begin
      Result := 'O fonrecedor não está cadastrado.';
      exit;
    end;

    if listfornecedor.listaFornecedor[0].Status <> 'Ativo' then
    begin
      result := 'O fornecedor não está ativo';
      exit;
    end;

  finally
    fornecedorService.Free;
  end;



end;

end.
