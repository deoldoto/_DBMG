unit uFrmConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, produto, listProduto, rest.Types, rest.Json;

type
  TfrmConsultaProduto = class(TForm)
    DBGrid1: TDBGrid;
    cdsResultadoPesquisa: TClientDataSet;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    cdsResultadoPesquisaid: TIntegerField;
    cdsResultadoPesquisadescricao: TStringField;
    cdsResultadoPesquisavalor: TFloatField;
    cdsResultadoPesquisaid_fornecedor: TIntegerField;
    cdsResultadoPesquisastatus: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    produtoRetorno: tProduto;
    procedure consultar;
    procedure carregarResultado;
    procedure carregarProdutoResultado;
  public
    { Public declarations }
  function getProdutoResultado: TProduto;

  end;

var
  frmConsultaProduto: TfrmConsultaProduto;

implementation

uses
  restRequestSingleton;

{$R *.dfm}

{ TForm2 }

procedure TfrmConsultaProduto.Button1Click(Sender: TObject);
begin
  consultar;
end;

procedure TfrmConsultaProduto.Button2Click(Sender: TObject);
begin
  carregarProdutoResultado;
  self.ModalResult := mrYes;
  self.Close;
end;

procedure TfrmConsultaProduto.carregarProdutoResultado;
begin
  if cdsResultadoPesquisa.IsEmpty then
    exit;

  produtoRetorno.id := cdsResultadoPesquisa.fieldByName('id').AsInteger;
  produtoRetorno.descricao := cdsResultadoPesquisa.FieldByName('descricao').AsString;
  produtoRetorno.valor := cdsResultadoPesquisa.FieldByname('valor').AsFloat;
  produtoRetorno.idfornecedor := cdsResultadoPesquisa.FieldByName('id_fornecedor').AsInteger;
  produtoRetorno.status := cdsResultadoPesquisa.FieldByName('status').AsString
end;

procedure TfrmConsultaProduto.carregarResultado;
var
  listProduto: TListProduto;
  produto : tProduto;
begin

  cdsResultadoPesquisa.EmptyDataSet;
  listProduto:= TJson.JsonToObject<TListProduto>(TRestRequestSingleton.obterInstancia.obterRequisicao.Response.Content);
  if  listProduto.listProduto.Count = 0 then
    exit;

  for produto in listProduto.listProduto do
  begin
    cdsResultadoPesquisa.Append;
    cdsResultadoPesquisa.FieldByName('id').AsInteger := produto.id;
    cdsResultadoPesquisa.FieldByName('descricao').AsString := produto.descricao;
    cdsResultadoPesquisa.FieldByName('valor').AsFloat := produto.valor;
    cdsResultadoPesquisa.FieldByName('id_fornecedor').AsInteger := produto.idfornecedor;
    cdsResultadoPesquisa.FieldByName('status').AsString := produto.status;
    cdsResultadoPesquisa.Post;

  end;

end;

procedure TfrmConsultaProduto.consultar;
var
  listProduto: TListProduto;
  texto: string;

begin
  listProduto := TListProduto.create;
 try
    TRestRequestSingleton.obterInstancia.limparRequisicao;
    TRestRequestSingleton.obterInstancia.obterClient.BaseURL := 'http://localhost:9000/produto';
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

procedure TfrmConsultaProduto.FormCreate(Sender: TObject);
begin
  produtoRetorno := tProduto.Create;
  cdsResultadoPesquisa.CreateDataSet;
end;

function TfrmConsultaProduto.getProdutoResultado: TProduto;
begin
  result := produtoRetorno;
end;

end.
