unit uRelCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.StdCtrls;

type
  TfrmRelCliente = class(TForm)
    cdsClientes: TClientDataSet;
    cdsClientesid: TIntegerField;
    cdsClientesnome: TStringField;
    cdsClientesstatus: TStringField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Consultar;
    procedure CarregarRsultado;

  end;

var
  frmRelCliente: TfrmRelCliente;

implementation

uses
  listCliente, restRequestSingleton, cliente, rest.Types, rest.Json;

{$R *.dfm}

{ TfrmRelCliente }

procedure TfrmRelCliente.Button1Click(Sender: TObject);
begin
  Consultar;
end;

procedure TfrmRelCliente.CarregarRsultado;
var
  listCliente: TListCliente;
  texto: string;

begin
  listCliente := TListCliente.create;
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/clientesativos';
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmGET;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      CarregarRsultado
    end
    else
    begin
       showMessage('Falha ao consutlar os clientes. ' +
      TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode.ToString + ' - ' +
      TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
    end;
 finally

end;


end;

procedure TfrmRelCliente.Consultar;
var
  listCliente: TListCliente;
  cliente : TCliente;
begin

  cdsClientes.EmptyDataSet;
  listCliente := TJson.JsonToObject<TListCliente>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listCliente.listaCliente.Count = 0 then
    exit;

    for cliente in listCliente.listaCliente do
    begin
      cdsClientes.Append;
      cdsClientes.FieldByName('id').AsInteger := cliente.Id;
      cdsClientes.FieldByName('nome').AsString := cliente.nome;
      cdsClientes.FieldByName('status').AsString := cliente.status;
      cdsClientes.Post;
    end;

end;

procedure TfrmRelCliente.FormCreate(Sender: TObject);
begin
  cdsClientes.CreateDataSet;
end;

end.
