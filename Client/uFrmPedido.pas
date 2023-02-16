unit uFrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, cliente, frmConsultaPessoa,
  produto, listVendasItem,
  vendaItem, Vcl.Mask, vendas;

type
  TfrmPedido = class(TForm)
    btnCliente: TButton;
    edtIdCliente: TEdit;
    edtNomeCliente: TEdit;
    edtId: TEdit;
    dtDataHoraPedido: TDateTimePicker;
    cdsItensPedido: TClientDataSet;
    cdsItensPedidoidProdudo: TIntegerField;
    cdsItensPedidoquantidade: TFloatField;
    cdsItensPedidovalor_unitario: TFloatField;
    cdsItensPedidovalor_total: TFloatField;
    cdsItensPedidodescricao: TStringField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    brnAdicionar: TButton;
    btnExcluir: TButton;
    edtValorTotal: TMaskEdit;
    lblSituacao: TLabel;
    btnNovo: TButton;
    btnSalvar: TButton;
    Button1: TButton;
    btnFaturar: TButton;
    brnConsultaPedido: TButton;
    procedure btnClienteClick(Sender: TObject);
    procedure brnAdicionarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure brnConsultaPedidoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFaturarClick(Sender: TObject);
  private
    { Private declarations }
    procedure populaInformacaoCliente(cliente: TCliente);
    procedure adicionarProdutoAGrid(produto: tProduto);
    procedure limparCampos;
    function gerarListaDeProdutos(): TListaVendasItem;
    function gerarVenda(): TVenda;
    procedure salvar;
    procedure tratarMensagemDeErro;
    procedure CarregarResultado;
    procedure calculaValorTotal;
    procedure ConsultaVendaPorID(idPedido: Integer);
  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

uses uFrmConsultaProduto, restRequestSingleton, REST.Json, REST.Types, ufrmconsultapedido,
  listVendas;

procedure TfrmPedido.adicionarProdutoAGrid(produto: tProduto);
begin
  if produto.id = 0 then
    exit;

  cdsItensPedido.Append;
  cdsItensPedido.FieldByName('idProduto').AsInteger := produto.id;
  cdsItensPedido.FieldByName('quantidade').AsFloat := 1;
  cdsItensPedido.FieldByName('valor_unitario').AsFloat := produto.valor;
  cdsItensPedido.FieldByName('valor_total').AsFloat :=
    cdsItensPedido.FieldByName('quantidade').AsFloat *
    cdsItensPedido.FieldByName('valor_unitario').AsFloat;
  cdsItensPedido.FieldByName('descricao').AsString := produto.descricao;
  edtValorTotal.Text := (strtofloatDef(edtValorTotal.Text, 0) +
    cdsItensPedido.FieldByName('valor_total').AsFloat).ToString;
  cdsItensPedido.Post;
end;

procedure TfrmPedido.brnAdicionarClick(Sender: TObject);
var
  produto: tProduto;
begin
  Application.CreateForm(TfrmConsultaProduto, frmConsultaProduto);
  frmConsultaProduto.ShowModal;
  // if frmConsultaCliente.ModalResult = mrOk then
  produto := frmConsultaProduto.getProdutoResultado;

  adicionarProdutoAGrid(produto);
end;

procedure TfrmPedido.brnConsultaPedidoClick(Sender: TObject);
 var
 venda: TVenda;
begin
  Application.CreateForm(TfrmConsultaPedido, frmConsultaPedido);
  frmConsultaPedido.ShowModal;
  venda := frmConsultaPedido.getVendaResultado;
//  populaInformacaoCliente(cliente);
end;

procedure TfrmPedido.btnClienteClick(Sender: TObject);
var
  cliente: TCliente;
begin
  Application.CreateForm(TfrmConsultaCliente, frmConsultaCliente);
  frmConsultaCliente.ShowModal;
  cliente := frmConsultaCliente.getClienteResultado;
  populaInformacaoCliente(cliente);

end;

procedure TfrmPedido.btnExcluirClick(Sender: TObject);
begin
  cdsItensPedido.Delete;
end;

procedure TfrmPedido.btnFaturarClick(Sender: TObject);
var
  venda: TVenda;

begin
  if edtid.Text = EmptyStr then
  begin
    ShowMessage('nenhum pedido carregado');
    exit;
  end;
  venda := TVenda.Create;
  venda := gerarVenda;
  try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL :=
      'http://localhost:9000/efetivarvenda' + edtId.ToString;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmput;

    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.
      StatusCode) = 200 then
    begin
      venda := TJson.JsonToObject<TVenda>
        (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
      edtId.Text := venda.id.ToString;
      showMessage('A venda foi salvo com sucesso.');
    end
    else
    begin
      tratarMensagemDeErro;
    end;
  finally

  end;

end;

procedure TfrmPedido.btnNovoClick(Sender: TObject);
begin
  limparCampos
end;

procedure TfrmPedido.btnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TfrmPedido.calculaValorTotal;
begin
  if not(cdsItensPedido.state in [dsEdit]) then
    cdsItensPedido.edit;
  cdsItensPedido.FieldByName('valor_total').AsFloat :=
    cdsItensPedido.FieldByName('quantidade').AsFloat *
    cdsItensPedido.FieldByName('valor_unitario').AsFloat;
  edtValorTotal.Text := (strtofloatDef(edtValorTotal.Text, 0) +
    cdsItensPedido.FieldByName('valor_total').AsFloat).ToString;
  cdsItensPedido.Post;
end;

procedure TfrmPedido.CarregarResultado;
var
  listVendas: TListVendas;
  venda: TVenda;
  itemVenda: TvendaItem;
begin

  limparCampos;
  listVendas:= TJson.JsonToObject<TListVendas>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listVendas.listVendas.Count = 0 then
    exit;

  venda := listVendas.listVendas[0];
  edtId.Text := venda.id.ToString;
  edtIdCliente.Text := venda.cliente.id.ToString;
  edtNomeCliente.Text := venda.cliente.nome;
  lblSituacao.Caption := venda.status;
  dtDataHoraPedido.DateTime := venda.hora;
  edtValorTotal.Text := venda.valorTotal.ToString;
  for itemVenda in  venda.listVendasItem.listaVendasItem do
  begin
    cdsItensPedido.Append;
    cdsItensPedido.fieldByname('idProduto').AsInteger := itemVenda.produto.id;
    cdsItensPedido.FieldByName('quantidade').AsFloat := itemVenda.quantidade;
    cdsItensPedido.FieldByName('valor_unitario').AsFloat := itemVenda.valorUnitario;
    cdsItensPedido.FieldByName('valor_total').AsFloat := itemVenda.valorTotal;
    cdsItensPedido.fieldByName('descricao').AsString := itemVenda.produto.descricao;
    cdsItensPedido.Post;
  end;
end;

procedure TfrmPedido.ConsultaVendaPorID(idPedido: Integer);
var
  listVendas: TListVendas;
  texto: string;

begin
  listVendas:= TListVendas.create;
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/venda/' + idpedido.ToString;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmGET;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      CarregarResultado;
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

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  cdsItensPedido.CreateDataSet;
end;

procedure TfrmPedido.tratarMensagemDeErro;
begin
  showMessage('Falha ao executar a operação: ' +
    TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode.
    ToString + ' - ' + TRestRequestSingleton.obterInstancia.obterRequisicao.
    Response.Content);
end;

function TfrmPedido.gerarListaDeProdutos: TListaVendasItem;
var
  itemVenda: TvendaItem;
begin

  result := TListaVendasItem.Create;
  if cdsItensPedido.IsEmpty then
    exit;

  cdsItensPedido.First;
  while not cdsItensPedido.Eof do
  begin
    itemVenda := TvendaItem.Create;
    itemVenda.produto.id := cdsItensPedido.FieldByName('idProduto').AsInteger;
    itemVenda.quantidade := cdsItensPedido.FieldByName('quantidade').AsFloat;
    itemVenda.valorUnitario := cdsItensPedido.FieldByName
      ('valor_unitario').AsFloat;
    itemVenda.valorTotal := cdsItensPedido.FieldByName('valor_total').AsFloat;
    result.listaVendasItem.Add(itemVenda);
    cdsItensPedido.Next;
  end;
end;

function TfrmPedido.gerarVenda: TVenda;
begin
  result := TVenda.Create;
  result.id := strtointdef(edtId.Text, 0);
  result.cliente.id := strtointdef(edtIdCliente.Text, 0);
  result.status := lblSituacao.Caption;
  result.hora := dtDataHoraPedido.DateTime;
  result.valorTotal := strtofloatDef(edtValorTotal.Text, 0);
  result.listVendasItem := gerarListaDeProdutos;
end;

procedure TfrmPedido.limparCampos;
begin
  lblSituacao.Caption := 'Pendente';
  edtId.Clear;
  dtDataHoraPedido.DateTime := now;
  edtIdCliente.Clear;
  cdsItensPedido.EmptyDataSet;
  edtValorTotal.Clear;
end;

procedure TfrmPedido.populaInformacaoCliente(cliente: TCliente);
begin
  edtIdCliente.Clear;
  edtNomeCliente.Clear;
  if cliente.id = 0 then
    exit;
  edtIdCliente.Text := cliente.id.ToString;
  edtNomeCliente.Text := cliente.nome
end;

procedure TfrmPedido.salvar;
var
  venda: TVenda;

begin
  venda := TVenda.Create;
  venda := gerarVenda;
  try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL :=
      'http://localhost:9000/venda';
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmPOST;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Params.AddItem('param',
      TJson.ObjectToJsonString(venda), pkGETorPOST, [], ctAPPLICATION_JSON);
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.
      StatusCode) = 200 then
    begin
      venda := TJson.JsonToObject<TVenda>
        (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
      edtId.Text := venda.id.ToString;
      showMessage('A venda foi salvo com sucesso.');
    end
    else
    begin
      tratarMensagemDeErro;
    end;
  finally

  end;

end;

end.
