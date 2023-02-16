unit listCliente;

interface
uses
  Cliente, system.Generics.Collections;

  type
    TListCliente = class
  private
    FlistaCliente: TList<TCliente>;
    procedure SetlistaCliente(const Value: TList<TCliente>);
    public
    property listaCliente: TList<TCliente> read FlistaCliente write SetlistaCliente;
    constructor Create;

  end;

implementation

{ TLisTCliente }

constructor TListCliente.Create;
begin
  inherited;
  listaCliente := TList<TCliente>.Create;;
end;

procedure TListCliente.SetlistaCliente(
  const Value: TList<TCliente>);
begin
  FlistaCliente := Value;
end;

end.
