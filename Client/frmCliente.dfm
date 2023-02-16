object frmCadastroCliente: TfrmCadastroCliente
  Left = 0
  Top = 0
  Caption = 'frmCadastroCliente'
  ClientHeight = 221
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Código: TLabel
    Left = 62
    Top = 24
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Nome: TLabel
    Left = 68
    Top = 54
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 76
    Top = 85
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object Label4: TLabel
    Left = 14
    Top = 116
    Width = 81
    Height = 13
    Caption = 'Data Nascimento'
  end
  object Label1: TLabel
    Left = 64
    Top = 147
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object edtCodigo: TEdit
    Left = 119
    Top = 21
    Width = 50
    Height = 21
    TabOrder = 0
  end
  object edtNome: TEdit
    Left = 119
    Top = 51
    Width = 186
    Height = 21
    TabOrder = 1
  end
  object edtDataNascimento: TDateTimePicker
    Left = 119
    Top = 113
    Width = 186
    Height = 21
    Date = 44969.000000000000000000
    Time = 0.707538090275193100
    TabOrder = 2
  end
  object edtCPF: TMaskEdit
    Left = 119
    Top = 78
    Width = 121
    Height = 21
    TabOrder = 3
    Text = ''
  end
  object cbbStatus: TComboBox
    Left = 119
    Top = 140
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 4
    Text = 'Ativo'
    Items.Strings = (
      'Ativo'
      'Inativo')
  end
  object btnSalvar: TButton
    Left = 142
    Top = 179
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object btnConsultaCliente: TButton
    Left = 175
    Top = 20
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 6
    OnClick = btnConsultaClienteClick
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
  object btnNovo: TButton
    Left = 61
    Top = 179
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 8
    OnClick = btnNovoClick
  end
end
