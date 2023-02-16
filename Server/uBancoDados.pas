unit uBancoDados;

interface

uses
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, System.SysUtils;

type
  TBancoDadosSingleton = class(tobject)
    private
      conexao: TZConnection;
      constructor create;
    public
      class function obterInstancia: TBancoDadosSingleton;
      class function NewInstance: TObject; override;
      function ObterConexao: TZConnection;
      function obterConsulta(const cSql: String) : TZQuery;


  end;

implementation
var
  Instancia: TBancoDadosSingleton;

{ TBancoDadosSincleton }


{ TBancoDadosSingleton }

constructor TBancoDadosSingleton.create;
begin
  conexao := TZConnection.Create(Nil);
  conexao.AutoCommit := false;
  conexao.Database := 'BDMG';
  conexao.hostname := 'localhost';
  conexao.LibraryLocation :=  'C:\ZEOS\DLL\x86\libsybdb-5.dll';
  writeLn(conexao.LibraryLocation);
  conexao.Name := 'conexaoSQLServer';
  conexao.Password := 'T12619801c';
  conexao.Port := 1433;
  conexao.Protocol := 'FreeTDS_MsSQL-2000';
  conexao.User := 'user';
  conexao.Connect;
end;

class function TBancoDadosSingleton.NewInstance: TObject;
begin
  if not Assigned(Instancia) then
  begin

    Instancia := TBancoDadosSingleton(inherited NewInstance);
  end;

  result := Instancia;
end;

function TBancoDadosSingleton.ObterConexao: TZConnection;
begin
  result := conexao;
end;

function TBancoDadosSingleton.obterConsulta(const cSql: String): TZQuery;
var query : TZQuery;
begin
  query := TZQuery.Create(nil);
  query.Connection := conexao;
  query.SQL.Add(cSql);
  Result := query;

end;

class function TBancoDadosSingleton.obterInstancia: TBancoDadosSingleton;
begin
  result :=  TBancoDadosSingleton.create;
end;

end.
