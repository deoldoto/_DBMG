unit listVendasItem;

interface

uses
  vendaItem, system.Generics.Collections;

  type
    TListaVendasItem = class
      private
    FlistaVendasItem: TList<TvendaItem>;
    procedure SetlistaVendasItem(const Value: TList<TvendaItem>);

      public
        property listaVendasItem: TList<TvendaItem> read FlistaVendasItem write SetlistaVendasItem;
        constructor Create;
    end;

implementation

{ TListaVendasItem }

constructor TListaVendasItem.Create;
begin
  inherited;
  listaVendasItem := TList<TVendaItem>.Create;
end;

procedure TListaVendasItem.SetlistaVendasItem(const Value: TList<TvendaItem>);
begin
  FlistaVendasItem := Value;
end;

end.
