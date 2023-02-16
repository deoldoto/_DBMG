object FrmCadstroDeFornecedor: TFrmCadstroDeFornecedor
  Left = 0
  Top = 0
  Caption = 'FrmCadstroDeFornecedor'
  ClientHeight = 299
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Nome: TLabel
    Left = 68
    Top = 54
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label1: TLabel
    Left = 64
    Top = 147
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object Label4: TLabel
    Left = 22
    Top = 116
    Width = 71
    Height = 13
    Caption = 'Nome Fantasia'
  end
  object Label3: TLabel
    Left = 76
    Top = 85
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object lblCodigo: TLabel
    Left = 60
    Top = 26
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object edtCodigo: TEdit
    Left = 119
    Top = 21
    Width = 50
    Height = 21
    TabOrder = 0
  end
  object btnConsultaFornecedor: TButton
    Left = 175
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 1
    OnClick = btnConsultaFornecedorClick
  end
  object edtNome: TEdit
    Left = 119
    Top = 48
    Width = 186
    Height = 21
    TabOrder = 2
  end
  object edtCPF: TMaskEdit
    Left = 119
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 3
    Text = ''
  end
  object cbbStatus: TComboBox
    Left = 119
    Top = 144
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 4
    Text = 'Ativo'
    Items.Strings = (
      'Ativo'
      'Inativo')
  end
  object btnNovo: TButton
    Left = 61
    Top = 179
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 5
    OnClick = btnNovoClick
  end
  object btnSalvar: TButton
    Left = 142
    Top = 179
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = btnSalvarClick
  end
  object btnExcluir: TButton
    Left = 223
    Top = 179
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 7
    OnClick = btnExcluirClick
  end
  object edtNomeFantasia: TEdit
    Left = 119
    Top = 112
    Width = 186
    Height = 21
    TabOrder = 8
  end
end
