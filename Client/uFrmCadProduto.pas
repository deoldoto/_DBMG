unit uFrmCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, fornecedor, produto, listProduto;

type
  TfrmCadProduto = class(TForm)
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    edtValor: TMaskEdit;
    edtIdFornecedor: TEdit;
    edtNomeFornecedor: TEdit;
    btnNovo: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnConsultaCliente: TButton;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbbStatus: TComboBox;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultaClienteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure limparCampos;
    procedure salvar;
    procedure popularProduto(var produto: tProduto);
    procedure tratarMensagemDeErro;
    procedure excluir;
    procedure popularTela(produto: tProduto);
    function ConsultaFornecedorPorID(idFornecedor: Integer): TFornecedor;
    procedure popularInformacaoFornecedor(fornecedor: TFornecedor);

  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation
uses restRequestSingleton, rest.Types, rest.Json, listFornecedor, uFrmConsultaProduto, frmConsultaFornecedor;

{$R *.dfm}

procedure TfrmCadProduto.btnConsultaClienteClick(Sender: TObject);
var
  produto: tProduto;
begin
  Application.CreateForm(TfrmConsultaProduto, frmConsultaProduto);
  frmConsultaProduto.ShowModal;
//  if frmConsultaCliente.ModalResult = mrOk then
     produto := frmConsultaProduto.getProdutoResultado;

  popularTela(produto);


end;

procedure TfrmCadProduto.btnExcluirClick(Sender: TObject);
begin
  excluir;
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  limparCampos;
end;

procedure TfrmCadProduto.btnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TfrmCadProduto.Button1Click(Sender: TObject);
var
  forencedorItem: tfornecedor;
begin
  Application.CreateForm(TfrmConsultaDeFornecedor, frmConsultadeFornecedor);
  frmConsultadefornecedor.ShowModal;
//  if frmConsultaCliente.ModalResult = mrOk then
  forencedorItem := frmConsultaDeFornecedor.getFornecedorResultado;
  popularInformacaoFornecedor(forencedorItem);

end;

function TfrmCadProduto.ConsultaFornecedorPorID(
  idFornecedor: Integer): TFornecedor;
var
  listFornecedor: TListFornecedor;
  texto: string;

begin
  result := TFornecedor.create;
  if idFornecedor = 0 then
    exit;

  listFornecedor:= TListFornecedor.create;
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/fornecedor/'+idFornecedor.ToString;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmGET;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      listFornecedor := TJson.JsonToObject<TListfornecedor>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
      if listFornecedor.listaFornecedor.Count = 0 then
        exit;
      Result := listFornecedor.listaFornecedor[0];
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

procedure TfrmCadProduto.excluir;
var
  produto: tProduto;

begin
  produto := tProduto.create;
  PopularProduto(produto);
  if produto.Id = 0 then
  begin
    showMessage('nenehum produto selecionado');
    exit;
  end;

  try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/produto/'+produto.id.ToString;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmDELETE;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      showMessage('O fornecedor foi deletadocom sucesso.');
    end
    else
    begin
      tratarMensagemDeErro;
    end;
 finally

end;


end;

procedure TfrmCadProduto.limparCampos;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtValor.Clear;
  edtIdFornecedor.Clear;
  edtNomeFornecedor.Clear;
  cbbStatus.ItemIndex := 0;
end;

procedure TfrmCadProduto.popularInformacaoFornecedor(fornecedor: TFornecedor);
begin
  edtIdFornecedor.Clear;
  edtNomeFornecedor.Clear;
  if fornecedor.id = 0 then
    exit;
  edtIdFornecedor.Text := fornecedor.id.ToString;
  edtNomeFornecedor.Text := fornecedor.nome;
end;

procedure TfrmCadProduto.popularProduto(var produto: tProduto);
var fornecedor: tFornecedor;
begin

  if not assigned(produto) then
    produto := tProduto.Create;

    produto.id := StrToIntDef(edtCodigo.Text,0);
    produto.descricao := edtDescricao.Text;
    produto.valor := strToFloatDef(edtValor.Text, 0);
    produto.idfornecedor := StrToIntDef(edtIdFornecedor.Text, 0);
    produto.status := cbbStatus.Text;
    fornecedor := ConsultaFornecedorPorID(produto.idfornecedor);
    if fornecedor.id = 0 then
    begin
      edtIdFornecedor.clear;
      edtNomeFornecedor.Clear;
      exit;
    end;

    edtIdFornecedor.Text := fornecedor.id.ToString;
    edtNomeFornecedor.Text := fornecedor.nome;
end;


procedure TfrmCadProduto.popularTela(produto: tProduto);
begin
  edtCodigo.Text := produto.id.ToString;
  edtDescricao.Text := produto.descricao;
  edtValor.Text := produto.valor.ToString;
  cbbStatus.ItemIndex := cbbStatus.Items.IndexOf(produto.status);


end;

procedure TfrmCadProduto.salvar;
var
  produto: tProduto;

begin
  produto:= tProduto.create;
  popularProduto(produto);
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/produto';
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmPOST;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Params.AddItem('param', TJson.ObjectToJsonString(produto),pkGETorPOST,[],ctAPPLICATION_JSON);
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      produto := TJson.JsonToObject<tProduto>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
      edtCodigo.Text := produto.id.ToString;
      showMessage('O produto foi salvo com sucesso.');
    end
    else
    begin
      tratarMensagemDeErro;
    end;
 finally

end;

end;

procedure TfrmCadProduto.tratarMensagemDeErro;
begin
  showMessage('Falha ao executar a operação: ' +
  TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode.ToString + ' - ' +
  TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
end;

end.
