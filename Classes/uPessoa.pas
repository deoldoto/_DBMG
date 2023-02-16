unit uPessoa;

interface

type
  TPessoa = class

  private
    FidPessoa: Integer;
    Fnome: String;
    Fcpf_cnpj: String;

    public
    procedure SetidPessoa(const Value: Integer);
    procedure Setnome(const Value: String);
    procedure Setcpf_cnpj(const Value: String);
    property idPessoa: Integer read FidPessoa write SetidPessoa;
    property nome: String read Fnome write Setnome;
    property cpf_cnpj: String read Fcpf_cnpj write Setcpf_cnpj;
  end;
implementation


{ TPessoa }

procedure TPessoa.Setcpf_cnpj(const Value: String);
begin
  Fcpf_cnpj := Value;
end;

procedure TPessoa.SetidPessoa(const Value: Integer);
begin
  FidPessoa := Value;
end;

procedure TPessoa.Setnome(const Value: String);
begin
  Fnome := Value;
end;

end.
