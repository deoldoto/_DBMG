unit vendas;

interface

uses
  cliente, listVendasItem;

  type
    TVenda = class
  private
    Fhora: TDateTime;
    Fcliente: TCliente;
    Fid: Integer;
    Fstatus: String;
    FvalorTotal: Double;
    FlistVendasItem: TListaVendasItem;
    procedure Setcliente(const Value: TCliente);
    procedure Sethora(const Value: TDateTime);
    procedure Setid(const Value: Integer);
    procedure Setstatus(const Value: String);
    procedure SetvalorTotal(const Value: Double);
    procedure SetlistVendasItem(const Value: TListaVendasItem);
  public
    property id: Integer read Fid write Setid;
    property cliente: TCliente read Fcliente write Setcliente;
    property hora: TDateTime read Fhora write Sethora;
    property valorTotal: Double read FvalorTotal write SetvalorTotal;
    property status: String read Fstatus write Setstatus;
    property listVendasItem: TListaVendasItem read FlistVendasItem write SetlistVendasItem;
    constructor create;
  end;

implementation

{ TVenda }

constructor TVenda.create;
begin
  inherited;
  cliente := TCliente.create;
  listVendasItem := TListaVendasItem.Create;
end;

procedure TVenda.Setcliente(const Value: TCliente);
begin
  Fcliente := Value;
end;

procedure TVenda.Sethora(const Value: TDateTime);
begin
  Fhora := Value;
end;

procedure TVenda.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TVenda.SetlistVendasItem(const Value: TListaVendasItem);
begin
  FlistVendasItem := Value;
end;

procedure TVenda.Setstatus(const Value: String);
begin
  Fstatus := Value;
end;

procedure TVenda.SetvalorTotal(const Value: Double);
begin
  FvalorTotal := Value;
end;

end.
