object frmCadProduto: TfrmCadProduto
  Left = 0
  Top = 0
  Caption = 'frmCadProduto'
  ClientHeight = 264
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 33
    Top = 11
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 20
    Top = 41
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel
    Left = 42
    Top = 72
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object Label4: TLabel
    Left = 11
    Top = 133
    Width = 55
    Height = 13
    Caption = 'Fornecedor'
  end
  object Label5: TLabel
    Left = 35
    Top = 163
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object edtCodigo: TEdit
    Left = 72
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtDescricao: TEdit
    Left = 72
    Top = 38
    Width = 202
    Height = 21
    TabOrder = 1
  end
  object edtValor: TMaskEdit
    Left = 72
    Top = 69
    Width = 121
    Height = 21
    TabOrder = 2
    Text = ''
  end
  object edtIdFornecedor: TEdit
    Left = 72
    Top = 130
    Width = 49
    Height = 21
    TabOrder = 3
  end
  object edtNomeFornecedor: TEdit
    Left = 127
    Top = 130
    Width = 193
    Height = 21
    TabOrder = 4
  end
  object btnNovo: TButton
    Left = 72
    Top = 191
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 5
    OnClick = btnNovoClick
  end
  object btnSalvar: TButton
    Left = 153
    Top = 191
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = btnSalvarClick
  end
  object btnExcluir: TButton
    Left = 234
    Top = 191
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 7
    OnClick = btnExcluirClick
  end
  object btnConsultaCliente: TButton
    Left = 199
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 8
    OnClick = btnConsultaClienteClick
  end
  object Button1: TButton
    Left = 72
    Top = 99
    Width = 75
    Height = 25
    Caption = 'Fornecedor'
    TabOrder = 9
    OnClick = Button1Click
  end
  object cbbStatus: TComboBox
    Left = 72
    Top = 160
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 10
    Text = 'Ativo'
    Items.Strings = (
      'Ativo'
      'Inativo')
  end
end
