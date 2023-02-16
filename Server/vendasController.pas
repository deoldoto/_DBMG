unit vendasController;

interface

uses
  vendasService, vendas, listVendas;

type
  TVendaController = class
    private
      vendasservice: TVendasService;
    public
      function InserirVenda(venda: TVenda): String;
      function listarVendas(): TListVendas;
      function buscarVendaPorId(const id: String): TListVendas;
      function alterarvenda(venda: TVenda): String;
      function excluirVenda(const id: integer): String;
      function efetivar(const id: integer): string;
      constructor Create;
  end;

implementation

{ TVendaController }

function TVendaController.alterarvenda(venda: TVenda): String;
begin
  result := vendasService.alterarvenda(venda);
end;

function TVendaController.buscarVendaPorId(const id: String): TListVendas;
begin
  Result := vendasservice.buscarVendaPorId(id);
end;

constructor TVendaController.Create;
begin
  inherited Create;
  vendasservice := TVendasService.Create;
end;

function TVendaController.efetivar(const id: integer): string;
begin
  Result := vendasservice.efetivar(id);
end;

function TVendaController.excluirVenda(const id: integer): String;
begin
  Result := vendasservice.excluirVenda(id);
end;

function TVendaController.InserirVenda(venda: TVenda): String;
begin
  Result := vendasservice.InserirVenda(venda);
end;

function TVendaController.listarVendas: TListVendas;
begin
  Result := vendasservice.listarVendas;
end;

end.
