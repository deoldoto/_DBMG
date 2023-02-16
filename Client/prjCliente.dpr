program prjCliente;

uses
  Vcl.Forms,
  unMenuPrincipal in 'unMenuPrincipal.pas' {Form3},
  cliente in '..\Classes\cliente.pas',
  fornecedor in '..\Classes\fornecedor.pas',
  listCliente in '..\Classes\listCliente.pas',
  listFornecedor in '..\Classes\listFornecedor.pas',
  listPessoa in '..\Classes\listPessoa.pas',
  listProduto in '..\Classes\listProduto.pas',
  listVendas in '..\Classes\listVendas.pas',
  listVendasItem in '..\Classes\listVendasItem.pas',
  produto in '..\Classes\produto.pas',
  uPessoa in '..\Classes\uPessoa.pas',
  vendaItem in '..\Classes\vendaItem.pas',
  vendas in '..\Classes\vendas.pas',
  frmCliente in 'frmCliente.pas' {frmCadastroCliente},
  restRequestSingleton in 'restRequestSingleton.pas',
  baseConsulta in 'baseConsulta.pas' {Form1},
  frmConsultaPessoa in 'frmConsultaPessoa.pas' {frmConsultaCliente},
  frmCadastroFornecedor in 'frmCadastroFornecedor.pas' {FrmCadstroDeFornecedor},
  frmCOnsultaFornecedor in 'frmCOnsultaFornecedor.pas' {frmConsultaDeFornecedor},
  uFrmCadProduto in 'uFrmCadProduto.pas' {frmCadProduto},
  uFrmConsultaProduto in 'uFrmConsultaProduto.pas' {frmConsultaProduto},
  uFrmPedido in 'uFrmPedido.pas' {frmPedido},
  ufrmConsultaPedido in 'ufrmConsultaPedido.pas' {frmConsultaPedido},
  uRelCliente in 'uRelCliente.pas' {frmRelCliente},
  uRelPedidos in 'uRelPedidos.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmConsultaCliente, frmConsultaCliente);
  Application.CreateForm(TFrmCadstroDeFornecedor, FrmCadstroDeFornecedor);
  Application.CreateForm(TfrmConsultaDeFornecedor, frmConsultaDeFornecedor);
  Application.CreateForm(TfrmCadProduto, frmCadProduto);
  Application.CreateForm(TfrmConsultaProduto, frmConsultaProduto);
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.CreateForm(TfrmConsultaPedido, frmConsultaPedido);
  Application.CreateForm(TfrmRelCliente, frmRelCliente);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
