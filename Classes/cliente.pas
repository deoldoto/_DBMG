unit cliente;

interface
uses uPessoa;

type
  TCliente = class(tPessoa)
  private
    FdataNascimento: tDate;
    Fativa: string;
    FId: integer;
    procedure Setativa(const Value: string);
    procedure SetdataNascimento(const Value: tDate);
    procedure Setpessoa(const Value: tPessoa);
    procedure SetId(const Value: integer);


  public
  constructor create;
    property status: string read Fativa write Setativa;
    property dataNascimento: tDate read FdataNascimento write SetdataNascimento;
    property Id: integer read FId write SetId;
  end;
implementation

{ TCliente }

constructor TCliente.create;
begin
  inherited;
end;

procedure TCliente.Setativa(const Value: string);
begin
  Fativa := Value;
end;

procedure TCliente.SetdataNascimento(const Value: tDate);
begin
  FdataNascimento := Value;
end;

procedure TCliente.SetId(const Value: integer);
begin
    FId := Value;
end;

procedure TCliente.Setpessoa(const Value: tPessoa);
begin

end;

end.
