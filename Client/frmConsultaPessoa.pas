unit frmConsultaPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, cliente;

type
  TfrmConsultaCliente = class(TForm)
    DBGrid1: TDBGrid;
    cdsResultadoCliente: TClientDataSet;
    cdsResultadoClienteid: TIntegerField;
    cdsResultadoClienteid_pessoa: TIntegerField;
    cdsResultadoClientestatus: TStringField;
    cdsResultadoClientedata_nascimento: TDateField;
    cdsResultadoClientenome: TStringField;
    cdsResultadoClientecpf_cnpj: TStringField;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    clienteResutlado: TCliente;
    procedure Consultar;
    procedure CarregarRsultado;
    procedure carregarPessoaResultado;
  public
    function getClienteResultado: tCliente;
    { Public declarations }
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

uses restRequestSingleton, listCliente, rest.Types, rest.Json;

{$R *.dfm}

procedure TfrmConsultaCliente.Button1Click(Sender: TObject);
begin
  Consultar;
end;

procedure TfrmConsultaCliente.Button2Click(Sender: TObject);
begin
  carregarPessoaResultado;
  Self.ModalResult := mrYes;
  self.Close;
end;

procedure TfrmConsultaCliente.carregarPessoaResultado;
begin
  if cdsResultadoCliente.IsEmpty then
    exit;

  clienteResutlado.Id := cdsResultadoCliente.FieldByName('id').AsInteger;
  clienteResutlado.nome := cdsResultadoCliente.FieldByName('nome').AsString;
  clienteResutlado.idPessoa := cdsResultadoCliente.FieldByName('id_pessoa').AsInteger;
  clienteResutlado.cpf_cnpj:= cdsResultadoCliente.FieldByName('cpf_cnpj').AsString;
  clienteResutlado.dataNascimento:= cdsResultadoCliente.FieldByName('data_nascimento').AsDateTime;
  clienteResutlado.status := cdsResultadoCliente.FieldByName('status').AsString;

end;

procedure TfrmConsultaCliente.CarregarRsultado;
var
  listCliente: TListCliente;
  cliente : TCliente;
begin

  cdsResultadoCliente.EmptyDataSet;
  listCliente := TJson.JsonToObject<TListCliente>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listCliente.listaCliente.Count = 0 then
    exit;

    for cliente in listCliente.listaCliente do
    begin
      cdsResultadoCliente.Append;
      cdsResultadoCliente.FieldByName('id').AsInteger := cliente.Id;
      cdsResultadoCliente.FieldByName('nome').AsString := cliente.nome;
      cdsResultadoCliente.FieldByName('id_pessoa').AsInteger := cliente.idPessoa;
      cdsResultadoCliente.FieldByName('cpf_cnpj').AsString := cliente.cpf_cnpj;
      cdsResultadoCliente.FieldByName('data_nascimento').AsDateTime := cliente.dataNascimento;
      cdsResultadoCliente.FieldByName('status').AsString := cliente.status;
    end;

end;

procedure TfrmConsultaCliente.Consultar;
var
  listCliente: TListCliente;
  texto: string;

begin
  listCliente := TListCliente.create;
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/cliente';
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

procedure TfrmConsultaCliente.FormCreate(Sender: TObject);
begin
  cdsResultadoCliente.CreateDataSet;
  clienteResutlado := TCliente.create;
end;

function TfrmConsultaCliente.getClienteResultado: tCliente;
begin
  Result := clienteResutlado;
end;

end.
