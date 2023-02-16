unit listProduto;

interface
uses
  produto, system.Generics.Collections;

  type
    TListProduto= class
  private
    FlistProduto: TList<tProduto>;
    procedure SetlistProduto(const Value: TList<tProduto>);
    public
    property listProduto: TList<tProduto> read FlistProduto write SetlistProduto;
    constructor Create;

  end;

implementation

{ TListFornecedor }


{ TListProduto }

constructor TListProduto.Create;
begin
  inherited;
  listProduto := TList<tProduto>.Create;
end;

procedure TListProduto.SetlistProduto(const Value: TList<tProduto>);
begin
  FlistProduto := Value;
end;

end.
