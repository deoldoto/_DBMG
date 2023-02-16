object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'frmPedido'
  ClientHeight = 357
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    571
    357)
  PixelsPerInch = 96
  TextHeight = 13
  object lblSituacao: TLabel
    Left = 376
    Top = 26
    Width = 103
    Height = 30
    Caption = 'Pendente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnCliente: TButton
    Left = 88
    Top = 59
    Width = 75
    Height = 25
    Caption = 'Cliente'
    TabOrder = 0
    OnClick = btnClienteClick
  end
  object edtIdCliente: TEdit
    Left = 88
    Top = 90
    Width = 49
    Height = 21
    TabOrder = 1
  end
  object edtNomeCliente: TEdit
    Left = 143
    Top = 90
    Width = 193
    Height = 21
    TabOrder = 2
  end
  object edtId: TEdit
    Left = 88
    Top = 26
    Width = 49
    Height = 21
    TabOrder = 3
  end
  object dtDataHoraPedido: TDateTimePicker
    Left = 183
    Top = 59
    Width = 153
    Height = 21
    Date = 44972.000000000000000000
    Time = 0.478170243055501500
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 162
    Width = 555
    Height = 120
    Anchors = [akLeft, akTop, akRight]
    DataSource = DataSource1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'idProdudo'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 208
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Caption = 'Quantidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_unitario'
        Title.Caption = 'Valor Unit'#225'rio'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        ReadOnly = True
        Title.Caption = 'Valor Total'
        Visible = True
      end>
  end
  object brnAdicionar: TButton
    Left = 88
    Top = 124
    Width = 75
    Height = 26
    Caption = 'Adicionar'
    TabOrder = 6
    OnClick = brnAdicionarClick
  end
  object btnExcluir: TButton
    Left = 169
    Top = 124
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 7
    OnClick = btnExcluirClick
  end
  object edtValorTotal: TMaskEdit
    Left = 88
    Top = 288
    Width = 121
    Height = 21
    TabOrder = 8
    Text = ''
  end
  object btnNovo: TButton
    Left = 85
    Top = 323
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 9
    OnClick = btnNovoClick
  end
  object btnSalvar: TButton
    Left = 166
    Top = 324
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 10
    OnClick = btnSalvarClick
  end
  object Button1: TButton
    Left = 247
    Top = 323
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 11
  end
  object btnFaturar: TButton
    Left = 334
    Top = 323
    Width = 75
    Height = 25
    Caption = 'Faturar'
    TabOrder = 12
    OnClick = btnFaturarClick
  end
  object brnConsultaPedido: TButton
    Left = 143
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Consulta'
    TabOrder = 13
    OnClick = brnConsultaPedidoClick
  end
  object cdsItensPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 160
    object cdsItensPedidoidProdudo: TIntegerField
      FieldName = 'idProduto'
    end
    object cdsItensPedidoquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object cdsItensPedidovalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object cdsItensPedidovalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object cdsItensPedidodescricao: TStringField
      FieldName = 'descricao'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsItensPedido
    Left = 232
    Top = 176
  end
end
