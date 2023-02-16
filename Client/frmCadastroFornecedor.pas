unit frmCadastroFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, fornecedor;

type
  TFrmCadstroDeFornecedor = class(TForm)
    edtCodigo: TEdit;
    btnConsultaFornecedor: TButton;
    edtNome: TEdit;
    edtCPF: TMaskEdit;
    Nome: TLabel;
    Label1: TLabel;
    cbbStatus: TComboBox;
    btnNovo: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    Label4: TLabel;
    Label3: TLabel;
    lblCodigo: TLabel;
    edtNomeFantasia: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultaFornecedorClick(Sender: TObject);
  private
    { Private declarations }
    procedure limparcampos;
    procedure salvar;
    procedure popularFornecedor(var fornecedor: tFornecedor);
    procedure tratarMensagemDeErro;
    procedure excluir;
    procedure popularTela(fornecedor: tFornecedor);
  public
    { Public declarations }
  end;

var
  FrmCadstroDeFornecedor: TFrmCadstroDeFornecedor;

implementation
uses listFornecedor, restRequestSingleton,  REST.Types, rest.Json, frmConsultaFornecedor;

{$R *.dfm}

{ TForm2 }

procedure TFrmCadstroDeFornecedor.btnConsultaFornecedorClick(Sender: TObject);
var
  forncedor: tfornecedor;
begin
  Application.CreateForm(TfrmConsultaDeFornecedor, frmConsultadeFornecedor);
  frmConsultadefornecedor.ShowModal;

     forncedor := frmConsultaDeFornecedor.getFornecedorResultado;

  popularTela(forncedor);

end;

procedure TFrmCadstroDeFornecedor.btnExcluirClick(Sender: TObject);
begin
  excluir;
end;

procedure TFrmCadstroDeFornecedor.btnNovoClick(Sender: TObject);
begin
  limparcampos;
end;

procedure TFrmCadstroDeFornecedor.btnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TFrmCadstroDeFornecedor.excluir;
var
  fornecedor: Tfornecedor;

begin
  fornecedor := TFornecedor.create;
  PopularFornecedor(fornecedor);
  if fornecedor.Id = 0 then
  begin
    showMessage('nenehum cliente selecionado');
    exit;
  end;

  try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/fornecedor/'+fornecedor.id.ToString;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmDELETE;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      edtCodigo.Text := fornecedor.id.ToString;
      showMessage('O fornecedor foi deletadocom sucesso.');
    end
    else
    begin
      tratarMensagemDeErro;
    end;
 finally

end;


end;

procedure TFrmCadstroDeFornecedor.limparcampos;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  edtCPF.Clear;
  edtNomeFantasia.Clear;
  cbbStatus.ItemIndex := 0;
end;

procedure TFrmCadstroDeFornecedor.popularFornecedor(var fornecedor: TFornecedor);
begin
  if not Assigned(fornecedor) then
    fornecedor := TFornecedor.create;

  fornecedor.Id := StrToIntDef(edtCodigo.Text,0);
  fornecedor.idPessoa := 0;
  fornecedor.nome := edtNome.Text;
  fornecedor.nomeFantasia := edtNomeFantasia.Text;
  fornecedor.cpf_cnpj := edtCPF.Text;
  fornecedor.status := cbbStatus.Text;
end;


procedure TFrmCadstroDeFornecedor.popularTela(fornecedor: tFornecedor);
begin
  limparCampos;

  if fornecedor.Id = 0 then
    exit;

  edtCodigo.Text := fornecedor.Id.ToString;
  edtNome.Text := fornecedor.nome;
  edtCpf.Text := fornecedor.cpf_cnpj;
  edtNomeFantasia.Text:= fornecedor.nomeFantasia;
  cbbStatus.ItemIndex := cbbStatus.Items.IndexOf(fornecedor.status);

end;

procedure TFrmCadstroDeFornecedor.salvar;
var
  fornecedor: TFornecedor;

begin
  fornecedor:= tfornecedor.create;
  popularFornecedor(fornecedor);
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/fornecedor';
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmPOST;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Params.AddItem('param', TJson.ObjectToJsonString(fornecedor),pkGETorPOST,[],ctAPPLICATION_JSON);
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      fornecedor := TJson.JsonToObject<TFornecedor>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
      edtCodigo.Text := fornecedor.id.ToString;
      showMessage('O fornecedor foi salvo com sucesso.');
    end
    else
    begin
      tratarMensagemDeErro;
    end;
 finally

end;

end;

procedure TFrmCadstroDeFornecedor.tratarMensagemDeErro;
begin
  showMessage('Falha ao executar a operação: ' +
  TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode.ToString + ' - ' +
  TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);

end;

end.
