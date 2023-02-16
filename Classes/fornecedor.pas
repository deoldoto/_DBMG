unit fornecedor;

interface

uses
  upessoa;
type TFornecedor = class(tPessoa)
  private
    Fid: integer;
    FStatus: String;
    FnomeFantasia: String;
    procedure Setid(const Value: integer);
    procedure SetnomeFantasia(const Value: String);
    procedure SetStatus(const Value: String);

  public
  property id: integer read Fid write Setid;
  property nomeFantasia: String read FnomeFantasia write SetnomeFantasia;
  property Status: String read FStatus write SetStatus;

  constructor create;

  end;

implementation

{ TFornecedor }

constructor TFornecedor.create;
begin

end;

procedure TFornecedor.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TFornecedor.SetnomeFantasia(const Value: String);
begin
  FnomeFantasia := Value;
end;

procedure TFornecedor.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

end.
