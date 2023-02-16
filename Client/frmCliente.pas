unit frmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, cliente,
  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, System.JSON, rest.Json;


type
  TfrmCadastroCliente = class(TForm)
    Código: TLabel;
    Nome: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtDataNascimento: TDateTimePicker;
    Label1: TLabel;
    edtCPF: TMaskEdit;
    cbbStatus: TComboBox;
    btnSalvar: TButton;
    btnConsultaCliente: TButton;
    btnExcluir: TButton;
    btnNovo: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnConsultaClienteClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
    procedure PopularCliente(var cliente: TCliente);
    procedure salvar();
    procedure excluir();
    procedure trataMensagemErro();
    procedure limparCampos;
    procedure popularTela(cliente: TCliente);
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses restRequestSingleton, frmConsultaPessoa;

{$R *.dfm}

{ TForm1 }

procedure TfrmCadastroCliente.btnConsultaClienteClick(Sender: TObject);
var
  cliente: tCliente;
begin
  Application.CreateForm(TfrmConsultaCliente, frmConsultaCliente);
  frmConsultaCliente.ShowModal;
//  if frmConsultaCliente.ModalResult = mrOk then
     cliente := frmConsultaCliente.getClienteResultado;

  popularTela(cliente);

end;

procedure TfrmCadastroCliente.btnExcluirClick(Sender: TObject);
begin
  excluir;
end;

procedure TfrmCadastroCliente.btnNovoClick(Sender: TObject);
begin
  limparCampos;
end;

procedure TfrmCadastroCliente.btnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TfrmCadastroCliente.excluir;
var
  cliente: TCliente;

begin
  cliente := tcliente.create;
  PopularCliente(cliente);
  if cliente.Id = 0 then
  begin
    showMessage('nenehum cliente selecionado');
    exit;
  end;

  try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/cliente/'+cliente.id.ToString;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmDELETE;
  //  TRestRequestSingleton.obterInstancia.obterRequisicao.Params.AddItem('param', TJson.ObjectToJsonString(cliente),pkGETorPOST,[],ctAPPLICATION_JSON);
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      edtCodigo.Text := cliente.id.ToString;
      showMessage('O cliente foi salvo com sucesso.');
    end
    else
    begin
      trataMensagemErro
    end;
 finally

end;

end;

procedure TfrmCadastroCliente.limparCampos;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  edtCPF.Clear;
  edtDataNascimento.DateTime := now;
  cbbStatus.ItemIndex := 0;
end;

procedure TfrmCadastroCliente.PopularCliente(var cliente: TCliente);
begin
  if not Assigned(cliente) then
    cliente := TCliente.create;

  cliente.Id := StrToIntDef(edtCodigo.Text,0);
  cliente.idPessoa := 0;
  cliente.nome := edtNome.Text;
  cliente.dataNascimento := edtDataNascimento.Date;
  cliente.cpf_cnpj := edtCPF.Text;
  cliente.status := cbbStatus.Text;
end;

procedure TfrmCadastroCliente.popularTela(cliente: TCliente);
begin
  limparCampos;

  if cliente.Id = 0 then
    exit;

  edtCodigo.Text := cliente.Id.ToString;
  edtNome.Text := cliente.nome;
  edtCpf.Text := cliente.cpf_cnpj;
  edtDataNascimento.Date := cliente.dataNascimento;
  cbbStatus.ItemIndex := cbbStatus.Items.IndexOf(cliente.status);
end;

procedure TfrmCadastroCliente.salvar;
var
  cliente: TCliente;

begin
  cliente := tcliente.create;
  PopularCliente(cliente);
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/cliente';
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmPOST;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Params.AddItem('param', TJson.ObjectToJsonString(cliente),pkGETorPOST,[],ctAPPLICATION_JSON);
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
    cliente := TJson.JsonToObject<TCliente>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
      edtCodigo.Text := cliente.id.ToString;
      showMessage('O cliente foi salvo com sucesso.');
    end
    else
    begin
      trataMensagemErro
    end;
 finally

end;

end;

procedure TfrmCadastroCliente.trataMensagemErro;
begin
  showMessage('Falha ao executar a operação: ' +
  TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode.ToString + ' - ' +
  TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
end;

end.
