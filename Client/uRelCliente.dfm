object frmRelCliente: TfrmRelCliente
  Left = 0
  Top = 0
  Caption = 'frmRelCliente'
  ClientHeight = 410
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 72
    Width = 734
    Height = 338
    Align = alBottom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 48
    Top = 24
    Width = 105
    Height = 25
    Caption = 'Consultar Clientes'
    TabOrder = 1
    OnClick = Button1Click
  end
  object cdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 72
    object cdsClientesid: TIntegerField
      FieldName = 'id'
    end
    object cdsClientesnome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object cdsClientesstatus: TStringField
      FieldName = 'status'
      Size = 10
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsClientes
    Left = 112
    Top = 80
  end
end
