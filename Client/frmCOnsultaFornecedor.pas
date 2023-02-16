unit frmCOnsultaFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, fornecedor;

type
  TfrmConsultaDeFornecedor = class(TForm)
    DBGrid1: TDBGrid;
    cdsResultadoCliente: TClientDataSet;
    cdsResultadoClienteid: TIntegerField;
    cdsResultadoClienteid_pessoa: TIntegerField;
    cdsResultadoClientenome: TStringField;
    cdsResultadoClientecpf_cnpj: TStringField;
    cdsResultadoClientestatus: TStringField;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    cdsResultadoClientenomeFantasia: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    fornecedorRetorno: tFornecedor;
    procedure consultar;
    procedure carregarResultado;
    procedure carregarFornecedorResultado;
  public
    { Public declarations }
  function getFornecedorResultado: TFornecedor;
  end;

var
  frmConsultaDeFornecedor: TfrmConsultaDeFornecedor;

implementation

uses  restRequestSingleton, rest.Json, rest.Types, listFornecedor;

{$R *.dfm}

procedure TfrmConsultaDeFornecedor.Button1Click(Sender: TObject);
begin
  consultar;
end;

procedure TfrmConsultaDeFornecedor.Button2Click(Sender: TObject);
begin
  carregarFornecedorResultado;
  Self.ModalResult := mrYes;
  self.Close;

end;

procedure TfrmConsultaDeFornecedor.carregarFornecedorResultado;
begin
  if cdsResultadoCliente.IsEmpty then
    exit;

  fornecedorRetorno.Id := cdsResultadoCliente.FieldByName('id').AsInteger;
  fornecedorRetorno.nome := cdsResultadoCliente.FieldByName('nome').AsString;
  fornecedorRetorno.idPessoa := cdsResultadoCliente.FieldByName('id_pessoa').AsInteger;
  fornecedorRetorno.cpf_cnpj:= cdsResultadoCliente.FieldByName('cpf_cnpj').AsString;
  fornecedorRetorno.nomeFantasia:= cdsResultadoCliente.FieldByName('nomeFantasia').AsString;
  fornecedorRetorno.status := cdsResultadoCliente.FieldByName('status').AsString;


end;

procedure TfrmConsultaDeFornecedor.carregarResultado;
var
  listFornecedor: TListFornecedor;
  fornecedor : TFornecedor;
begin

  cdsResultadoCliente.EmptyDataSet;
  listFornecedor := TJson.JsonToObject<TListfornecedor>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listFornecedor.listaFornecedor.Count = 0 then
    exit;

  for fornecedor in listFornecedor.listaFornecedor do
  begin
    cdsResultadoCliente.Append;
    cdsResultadoCliente.FieldByName('id').AsInteger := fornecedor.Id;
    cdsResultadoCliente.FieldByName('nome').AsString := fornecedor.nome;
    cdsResultadoCliente.FieldByName('id_pessoa').AsInteger := fornecedor.idPessoa;
    cdsResultadoCliente.FieldByName('cpf_cnpj').AsString := fornecedor.cpf_cnpj;
    cdsResultadoCliente.FieldByName('nomeFantasia').AsString:= fornecedor.nomeFantasia;
    cdsResultadoCliente.FieldByName('status').AsString := fornecedor.status;
  end;



end;

procedure TfrmConsultaDeFornecedor.consultar;
var
  listFornecedor: TListFornecedor;
  texto: string;

begin
  listFornecedor:= TListFornecedor.create;
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/fornecedor';
    TRestRequestSingleton.obterInstancia.obterRequisicao.Method := rmGET;
    TRestRequestSingleton.obterInstancia.obterRequisicao.Execute;
    if (TRestRequestSingleton.obterInstancia.obterRequisicao.Response.StatusCode) = 200 then
    begin
      carregarResultado
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

procedure TfrmConsultaDeFornecedor.FormCreate(Sender: TObject);
begin
  cdsResultadoCliente.CreateDataSet;
  fornecedorRetorno := TFornecedor.create;
end;

function TfrmConsultaDeFornecedor.getFornecedorResultado: TFornecedor;
begin
    Result := fornecedorRetorno;

end;

end.
