unit listFornecedor;

interface

uses
  Fornecedor, system.Generics.Collections;

  Type
    TListFornecedor= class
  private
    FlistaFornecedor: TList<TFornecedor>;
    procedure SetlistaFornecedor(const Value: TList<TFornecedor>);

    public
      property  listaFornecedor: TList<TFornecedor> read FlistaFornecedor write SetlistaFornecedor;
      constructor Create;
    end;

implementation

{ TListFornecedor }


{ TListaFornecedo }

constructor TListFornecedor.Create;
begin
  inherited;
  listaFornecedor := TList<TFornecedor>.Create;
end;

procedure TListFornecedor.SetlistaFornecedor(const Value: TList<TFornecedor>);
begin
  FlistaFornecedor := Value;
end;

end.
