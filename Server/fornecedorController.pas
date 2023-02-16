unit fornecedorController;

interface
uses fornecedorService, fornecedor,  System.SysUtils, listFornecedor;
 type TFornecedorController = class

  private
  fornecedorService: TFornecedorService;

  public
  function InserirFornecedor(fornecedor: Tfornecedor): String;

  function ListarFornecedor(): TListFornecedor;
  function BuscarFornecedorPorId(const id: String): tListFornecedor;
  function alterarFornecedor(fornecedor: TFornecedor): String;
  function excluirFornecedor(const id: integer): String;
  constructor Create;

  end;

implementation

{ TFornecedorController }

function TFornecedorController.alterarFornecedor(
  fornecedor: TFornecedor): String;
begin
  Result := fornecedorService.alterarFornecedor(fornecedor);
end;

function TFornecedorController.BuscarFornecedorPorId(
  const id: String): tListFornecedor;
begin
  Result := fornecedorService.BuscarFornecedorPorId(id);
end;

constructor TFornecedorController.Create;
begin
  inherited;
  fornecedorService := TFornecedorService.Create;
end;

function TFornecedorController.excluirFornecedor(const id: integer): String;
begin
  Result := fornecedorService.excluirFornecedor(id);
end;

function TFornecedorController.InserirFornecedor(
  fornecedor: Tfornecedor): String;
begin
  Result := fornecedorService.InserirFornecedor(fornecedor);
end;

function TFornecedorController.ListarFornecedor: TListFornecedor;
begin
  Result := fornecedorService.ListarFornecedor;
end;

end.
