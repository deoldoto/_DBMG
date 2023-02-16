unit produtoController;

interface
uses produtoService, produto,  System.SysUtils, listProduto;

type
  TProdutoController = class
    private
    produtoService: TProdutoService;

    public
    function InserirProduto(produto: tProduto): String;
    function ListarProduto(): TListProduto;
    function BuscarProdutoPorId(const id: String): TListProduto;
    function alterarProduto(produto: TProduto): String;
    function excluirProduto(const id: integer): String;
    constructor Create();
  end;

implementation

{ TProdutoController }

function TProdutoController.alterarProduto(produto: TProduto): String;
begin
  Result := produtoService.alterarProduto(produto);
end;

function TProdutoController.BuscarProdutoPorId(const id: String): TListProduto;
begin
  Result := produtoService.BuscarProdutoPorId(id);
end;

constructor TProdutoController.Create;
begin
  inherited;
  produtoService := TProdutoService.Create;
end;

function TProdutoController.excluirProduto(const id: integer): String;
begin
  Result := produtoService.excluirProduto(Id);
end;

function TProdutoController.InserirProduto(produto: tProduto): String;
begin
  Result := produtoService.InserirProduto(Produto);
end;

function TProdutoController.ListarProduto: TListProduto;
begin
  Result := produtoService.ListarProduto;
end;

end.
