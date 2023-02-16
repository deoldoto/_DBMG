unit vendaItem;

interface

uses
  produto;

type
  TvendaItem = class
  private
    Fproduto: tProduto;
    FvalorUnitario: double;
    Fquantidade: double;
    FidPedido: integer;
    FvalorTotal: real;
    procedure SetidPedido(const Value: integer);
    procedure Setproduto(const Value: tProduto);
    procedure Setquantidade(const Value: double);
    procedure SetvalorUnitario(const Value: double);
    procedure SetvalorTotal(const Value: real);
  public
    property idPedido: integer read FidPedido write SetidPedido;
    property produto: tProduto read Fproduto write Setproduto;
    property quantidade: double read Fquantidade write Setquantidade;
    property valorUnitario: double read FvalorUnitario write SetvalorUnitario;
    property valorTotal: real read FvalorTotal write SetvalorTotal;
    constructor Create;

  end;

implementation

{ TvendaItem }

constructor TvendaItem.Create;
begin
  produto := tProduto.Create;
end;

procedure TvendaItem.SetidPedido(const Value: integer);
begin
  FidPedido := Value;
end;

procedure TvendaItem.Setproduto(const Value: tProduto);
begin
  Fproduto := Value;
end;

procedure TvendaItem.Setquantidade(const Value: double);
begin
  Fquantidade := Value;
end;

procedure TvendaItem.SetvalorTotal(const Value: real);
begin
  FvalorTotal := Value;
end;

procedure TvendaItem.SetvalorUnitario(const Value: double);
begin
  FvalorUnitario := Value;
end;

end.
