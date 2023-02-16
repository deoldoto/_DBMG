object frmConsultaProduto: TfrmConsultaProduto
  Left = 0
  Top = 0
  Caption = 'frmConsultaProduto'
  ClientHeight = 299
  ClientWidth = 852
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
    AlignWithMargins = True
    Left = 3
    Top = 72
    Width = 846
    Height = 224
    Align = alBottom
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Descri'#231#227'o'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor'
        Title.Caption = 'Valor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_fornecedor'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'status'
        Title.Caption = 'Status'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 31
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 112
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Selecionar'
    TabOrder = 2
    OnClick = Button2Click
  end
  object cdsResultadoPesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 112
    object cdsResultadoPesquisaid: TIntegerField
      FieldName = 'id'
    end
    object cdsResultadoPesquisadescricao: TStringField
      FieldName = 'descricao'
      Size = 50
    end
    object cdsResultadoPesquisavalor: TFloatField
      FieldName = 'valor'
    end
    object cdsResultadoPesquisaid_fornecedor: TIntegerField
      FieldName = 'id_fornecedor'
    end
    object cdsResultadoPesquisastatus: TStringField
      FieldName = 'status'
      Size = 10
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsResultadoPesquisa
    Left = 112
    Top = 112
  end
end
