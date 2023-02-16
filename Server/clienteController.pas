unit clienteController;

interface

uses clienteService, cliente,  System.SysUtils, listCliente;
 type TClienteController = class

  private
  clienteService: TClienteService;

  public
  function InserirCliente(cliente: TCliente): String;

  function ListarCliente(): tListCliente;
  function BuscarClientePorId(const id: String): tListCliente;
  function alterarCliente(cliente: TCliente): String;
  function excluirCliente(const id: integer): String;
 function buscarClientesAtivos(): TListCliente;
  constructor Create;

  end;
implementation

{ TClienteController }

function TClienteController.alterarCliente(cliente: TCliente): String;
begin
  Result := clienteService.alterarCliente(cliente);
end;

function TClienteController.BuscarClientePorId(const id: String): tListCliente;
begin
  result := clienteService.BuscarclientePorId(id);
end;

function TClienteController.buscarClientesAtivos: TListCliente;
begin
  Result := clienteService.buscarClientesAtivos;
end;

constructor TClienteController.Create;
begin
  Inherited;
  clienteService := TClienteService.Create;
end;

function TClienteController.excluirCliente(const id: integer): String;
begin
  Result := clienteService.excluirCliente(id);
end;

function TClienteController.InserirCliente(cliente: TCliente): String;
var
  clienteService: TClienteService;
begin
  clienteService := TClienteService.Create;
  try
    try
      result := clienteService.Inserircliente(cliente);
    except on E: Exception do
      begin
        result := 'erro ao salvar cliente: ' + e.Message;
        WriteLn(result);
      end;
    end;
  finally
    clienteService.Free;
  end;

end;

function TClienteController.ListarCliente: tListCliente;
begin
  result := clienteService.ListarCliente;
end;

end.
