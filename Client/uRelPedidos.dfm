object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 465
  ClientWidth = 852
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
    Left = 22
    Top = 24
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Nome: TLabel
    Left = 28
    Top = 54
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 272
    Width = 817
    Height = 120
    DataSource = dsrItenspedidos
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 122
    Width = 817
    Height = 120
    DataSource = dsrpedidos
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object edtCodigo: TEdit
    Left = 79
    Top = 21
    Width = 50
    Height = 21
    TabOrder = 2
  end
  object btnConsultaCliente: TButton
    Left = 135
    Top = 20
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 3
    OnClick = btnConsultaClienteClick
  end
  object edtNome: TEdit
    Left = 79
    Top = 51
    Width = 186
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 64
    Top = 91
    Width = 201
    Height = 25
    Caption = 'ConsultarPedidos'
    TabOrder = 5
    OnClick = Button1Click
  end
  object cdspedidos: TClientDataSet
    PersistDataPacket.Data = {
      650000009619E0BD010000001800000004000000000003000000650007696456
      656E6461040001000000000004686F726108000800000000000A76616C6F7254
      6F74616C08000400000000000673746174757301004900000001000557494454
      48020002000A000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 648
    Top = 16
    object cdspedidosidVenda: TIntegerField
      FieldName = 'idVenda'
    end
    object cdspedidoshora: TDateTimeField
      FieldName = 'hora'
    end
    object cdspedidosvalorTotal: TFloatField
      FieldName = 'valorTotal'
    end
    object cdspedidosstatus: TStringField
      FieldName = 'status'
      Size = 10
    end
  end
  object cdsItensPedido: TClientDataSet
    PersistDataPacket.Data = {
      830000009619E0BD010000001800000005000000000003000000830007696456
      656E6461040001000000000009696450726F6475746F04000100000000000964
      657363726963616F01004900000001000557494454480200020014000D76616C
      6F72556E69746172696F08000400000000000A76616C6F72546F74616C080004
      00000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 696
    Top = 16
    object cdsItensPedidoidVenda: TIntegerField
      FieldName = 'idVenda'
    end
    object cdsItensPedidoidProduto: TIntegerField
      FieldName = 'idProduto'
    end
    object cdsItensPedidodescricao: TStringField
      FieldName = 'descricao'
    end
    object cdsItensPedidovalorUnitario: TFloatField
      FieldName = 'valorUnitario'
    end
    object cdsItensPedidovalorTotal: TFloatField
      FieldName = 'valorTotal'
    end
  end
  object dsrpedidos: TDataSource
    DataSet = cdspedidos
    Left = 656
    Top = 56
  end
  object dsrItenspedidos: TDataSource
    DataSet = cdsItensPedido
    Left = 704
    Top = 64
  end
end
