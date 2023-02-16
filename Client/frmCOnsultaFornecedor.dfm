object frmConsultaDeFornecedor: TfrmConsultaDeFornecedor
  Left = 0
  Top = 0
  Caption = 'frmConsultaDeFornecedor'
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
        Title.Caption = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Nome'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_pessoa'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cpf_cnpj'
        Title.Caption = 'CPF'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nomeFantasia'
        Title.Caption = 'Nome Fantasia'
        Width = 197
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'status'
        Title.Caption = 'Status'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 24
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
  object cdsResultadoCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 112
    object cdsResultadoClienteid: TIntegerField
      DisplayLabel = 'Id.'
      FieldName = 'id'
    end
    object cdsResultadoClienteid_pessoa: TIntegerField
      FieldName = 'id_pessoa'
      Visible = False
    end
    object cdsResultadoClientenome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object cdsResultadoClientecpf_cnpj: TStringField
      FieldName = 'cpf_cnpj'
    end
    object cdsResultadoClientestatus: TStringField
      FieldName = 'status'
    end
    object cdsResultadoClientenomeFantasia: TStringField
      FieldName = 'nomeFantasia'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsResultadoCliente
    Left = 112
    Top = 112
  end
end
