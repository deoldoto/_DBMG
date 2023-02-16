unit unMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, frmCliente, frmCadastroFornecedor, uFrmCadProduto;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses uFrmPedido, uRelCliente, uRelPedidos;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  frmCadastroCliente.ShowModal;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadstroDeFornecedor, FrmCadstroDeFornecedor);
  FrmCadstroDeFornecedor.ShowModal;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCadProduto, frmCadProduto);
  frmCadProduto.ShowModal;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPedido, frmPedido);
  frmPedido.ShowModal;

end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  Application.CreateForm(TfrmRelCliente, frmRelCliente);
  frmRelCliente.ShowModal;
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
  Application.CreateForm(TfrmRelPedidos, frmRelPedidos);
  frmRelPedidos.ShowModal;

end;

end.
