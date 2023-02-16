unit listPessoa;

interface

uses uPessoa, system.Generics.Collections;

type
  tListPessoa = class
  private
    FlistPessoas: TList<TPessoa>;
    procedure SetlistPessoas(const Value: TList<TPessoa>);
  public
    property  listPessoas: TList<TPessoa> read FlistPessoas write SetlistPessoas;
    constructor create;
  end;

implementation

{ tListPessoa }

constructor tListPessoa.create;
begin
  inherited;
  listPessoas := tList<Tpessoa>.create;

end;

procedure tListPessoa.SetlistPessoas(const Value: TList<TPessoa>);
begin
  FlistPessoas := Value;
end;

end.
