unit ufrmConsultaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, vendas;

type
  TfrmConsultaPedido = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    cdsResultadoPesquisa: TClientDataSet;
    DataSource1: TDataSource;
    cdsResultadoPesquisaid: TIntegerField;
    cdsResultadoPesquisacliente: TStringField;
    cdsResultadoPesquisahora: TDateTimeField;
    cdsResultadoPesquisavalor_total: TFloatField;
    cdsResultadoPesquisastatus: TStringField;
    cdsResultadoPesquisaidCliente: TIntegerField;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    vendaResultado: TVenda;
    procedure Consultar;
    procedure CarregarRsultado;
    procedure carregarVendaResultado;
  public
    function getVendaResultado: TVenda;

  end;

var
  frmConsultaPedido: TfrmConsultaPedido;

implementation

uses listVendas, rest.Json, rest.Types, restRequestSingleton;

{$R *.dfm}

{ TfrmConsultaPedido }

procedure TfrmConsultaPedido.Button1Click(Sender: TObject);
begin
  Consultar;
end;

procedure TfrmConsultaPedido.CarregarRsultado;
var
  listVendas: TListVendas;
  venda: TVenda;
begin

  cdsResultadoPesquisa.EmptyDataSet;
  listVendas:= TJson.JsonToObject<TListVendas>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listVendas.listVendas.Count = 0 then
    exit;

    for venda in listVendas.listVendas do
    begin
      cdsResultadoPesquisa.Append;
      cdsResultadoPesquisa.FieldByName('id').AsInteger := venda.Id;
      cdsResultadoPesquisa.FieldByName('nome').AsString := venda.cliente.nome;
      cdsResultadoPesquisa.FieldByName('hora').AsDateTime := venda.hora;
      cdsResultadoPesquisa.FieldByName('valor_total').AsFloat := venda.valorTotal;
      cdsResultadoPesquisa.FieldByName('status').AsString := venda.status;
      cdsResultadoPesquisa.FieldByName('idCliente').AsInteger := venda.cliente.Id;
      cdsResultadoPesquisa.Post
    end;
end;

procedure TfrmConsultaPedido.carregarVendaResultado;
var
  listVendas: TListVendas;
  venda: TVenda;
begin

  cdsResultadoPesquisa.EmptyDataSet;
  listVendas:= TJson.JsonToObject<TListVendas>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listVendas.listVendas.Count = 0 then
    exit;

    for venda in listVendas.listVendas do
    begin
      cdsResultadoPesquisa.Append;
      cdsResultadoPesquisa.FieldByName('id').AsInteger := venda.Id;
      cdsResultadoPesquisa.FieldByName('nome').AsString := venda.cliente.nome;
      cdsResultadoPesquisa.FieldByName('hora').AsDateTime := venda.hora;
      cdsResultadoPesquisa.FieldByName('valor_total').AsFloat := venda.valorTotal;
      cdsResultadoPesquisa.FieldByName('status').AsString := venda.status;
      cdsResultadoPesquisa.FieldByName('idCliente').AsInteger := venda.cliente.Id;
      cdsResultadoPesquisa.Post
    end;
end;

procedure TfrmConsultaPedido.Consultar;
var
  listCliente: TListVendas;
  texto: string;

begin
  listCliente := TListVendas.create;
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/venda';
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

function TfrmConsultaPedido.getVendaResultado: TVenda;
begin
  Result := vendaResultado;
end;

end.
