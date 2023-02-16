unit produto;

interface

  uses
    fornecedor;

type tProduto = class
  private
    Fvalor: double;
    Fdescricao: string;
    Fid: Integer;
    Fstatus: string;
    Fidfornecedor: Integer;
    procedure Setdescricao(const Value: string);
    procedure Setid(const Value: Integer);
    procedure Setstatus(const Value: string);
    procedure Setvalor(const Value: double);
    procedure Setidfornecedor(const Value: Integer);

  public
  property id: Integer read Fid write Setid;
  property descricao: string read Fdescricao write Setdescricao;
  property valor: double read Fvalor write Setvalor;
  property status: string read Fstatus write Setstatus;
  property idfornecedor: Integer read Fidfornecedor write Setidfornecedor;
end;

implementation

{ tProduto }

procedure tProduto.Setdescricao(const Value: string);
begin
  Fdescricao := Value;
end;

procedure tProduto.Setid(const Value: Integer);
begin
  Fid := Value;
end;


procedure tProduto.Setidfornecedor(const Value: Integer);
begin
  Fidfornecedor := Value;
end;

procedure tProduto.Setstatus(const Value: string);
begin
  Fstatus := Value;
end;

procedure tProduto.Setvalor(const Value: double);
begin
  Fvalor := Value;
end;

end.
