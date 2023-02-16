unit listVendas;

interface

uses
  vendas, system.Generics.Collections;

  type TListVendas = class
  private
    FlistVendas: TList<TVenda>;
    procedure SetlistVendas(const Value: TList<TVenda>);

    public
      property listVendas: TList<TVenda> read FlistVendas write SetlistVendas;
      constructor Create;

  end;

implementation

{ TListVendas }

constructor TListVendas.Create;
begin
  inherited;
  listVendas := TList<TVenda>.Create;
end;

procedure TListVendas.SetlistVendas(const Value: TList<TVenda>);
begin
  FlistVendas := Value;
end;

end.
