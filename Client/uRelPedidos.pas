unit uRelPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, cliente, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    cdspedidos: TClientDataSet;
    cdsItensPedido: TClientDataSet;
    dsrpedidos: TDataSource;
    dsrItenspedidos: TDataSource;
    cdspedidosidVenda: TIntegerField;
    cdspedidoshora: TDateTimeField;
    cdsItensPedidoidVenda: TIntegerField;
    cdsItensPedidoidProduto: TIntegerField;
    cdsItensPedidodescricao: TStringField;
    cdsItensPedidovalorUnitario: TFloatField;
    cdsItensPedidovalorTotal: TFloatField;
    cdspedidosvalorTotal: TFloatField;
    cdspedidosstatus: TStringField;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Código: TLabel;
    edtCodigo: TEdit;
    btnConsultaCliente: TButton;
    Nome: TLabel;
    edtNome: TEdit;
    Button1: TButton;
    procedure btnConsultaClienteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure popularCliente(cliente: tCliente);
  public
    { Public declarations }
    procedure Consultar;
    procedure CarregarRsultado;

  end;

var
  Form2: TForm2;

implementation

uses  frmConsultaPessoa, listVendas, listVendasItem, restRequestSingleton, rest.Types, vendas,
rest.Json, vendaitem;

{$R *.dfm}

{ TForm2 }

procedure TForm2.btnConsultaClienteClick(Sender: TObject);
var
 cliente: tCliente;
begin
  Application.CreateForm(TfrmConsultaCliente, frmConsultaCliente);
  frmConsultaCliente.ShowModal;
//  if frmConsultaCliente.ModalResult = mrOk then
     cliente := frmConsultaCliente.getClienteResultado;

  popularCliente(cliente);

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/cliente';
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmGET;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      CarregarRsultado;
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

procedure TForm2.CarregarRsultado;
var
  listVendas: TListVendas;
  venda: tVenda;
  vendaItem: tVendaItem;

begin

  cdspedidos.EmptyDataSet;
  cdsItensPedido.EmptyDataSet;
  listVendas := TJson.JsonToObject<TListVendas>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listVendas.listVendas.Count = 0 then
    exit;

    for venda in listVendas.listVendas do
    begin
      cdspedidos.Append;
      cdspedidos.FieldByName('idvenda').AsInteger := venda.id;
      cdspedidos.FieldByName('hora').AsDateTime := venda.hora;
      cdsPedidos.FieldByName('valorTotal').AsFloat := venda.valorTotal;
      cdspedidos.FieldByName('status').AsString := venda.status;
      cdspedidos.Post;

      for vendaItem in venda.listVendasItem.listaVendasItem do
      begin
        cdsItensPedido.append;
        cdsItensPedido.FieldByname('idVenda').AsInteger := vendaItem.idPedido;
        cdsItensPedido.FieldByName('idProduto').AsInteger := vendaItem.produto.id;
        cdsItensPedido.FieldByName('descricao').AsString := vendaitem.produto.descricao;
        cdsItensPedido.FieldByName('valorUnitario').AsFloat := vendaitem.valorUnitario;
        cdsItensPedido.FieldByName('valorTotal').AsFloat := vendaItem.valorTotal;
      end;

    end;
end;

procedure TForm2.Consultar;
begin

end;

procedure TForm2.popularCliente(cliente: tCliente);
begin
 if cliente.Id = 0 then
    exit;

  edtCodigo.Text := cliente.Id.ToString;
  edtNome.Text := cliente.nome;
end;

end.
