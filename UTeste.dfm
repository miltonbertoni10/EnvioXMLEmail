object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 306
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label8: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label9: TLabel
    Left = 504
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Identidade'
  end
  object Label10: TLabel
    Left = 8
    Top = 56
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object Label11: TLabel
    Left = 128
    Top = 56
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object Label12: TLabel
    Left = 248
    Top = 56
    Width = 24
    Height = 13
    Caption = 'Email'
  end
  object edtNome: TEdit
    Left = 8
    Top = 27
    Width = 471
    Height = 21
    TabOrder = 0
  end
  object edtEmail: TEdit
    Left = 248
    Top = 75
    Width = 377
    Height = 21
    TabOrder = 4
  end
  object FormatedGroupBox1: TFormatedGroupBox
    Left = 8
    Top = 114
    Width = 633
    Height = 143
    Caption = 'Endere'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Label1: TLabel
      Left = 137
      Top = 24
      Width = 22
      Height = 16
      Caption = 'Rua'
    end
    object Label2: TLabel
      Left = 468
      Top = 24
      Width = 14
      Height = 16
      Caption = 'N'#186
    end
    object Label3: TLabel
      Left = 534
      Top = 24
      Width = 79
      Height = 16
      Caption = 'Complemento'
    end
    object Label4: TLabel
      Left = 16
      Top = 76
      Width = 34
      Height = 16
      Caption = 'Bairro'
    end
    object Label5: TLabel
      Left = 422
      Top = 76
      Width = 38
      Height = 16
      Caption = 'Estado'
    end
    object Label6: TLabel
      Left = 282
      Top = 77
      Width = 39
      Height = 16
      Caption = 'Cidade'
    end
    object Label7: TLabel
      Left = 496
      Top = 77
      Width = 23
      Height = 16
      Caption = 'Pais'
    end
    object Label13: TLabel
      Left = 16
      Top = 24
      Width = 22
      Height = 16
      Caption = 'CEP'
    end
    object edtBairro: TEdit
      Left = 16
      Top = 99
      Width = 241
      Height = 24
      TabOrder = 3
    end
    object edtCidade: TEdit
      Left = 282
      Top = 99
      Width = 121
      Height = 24
      TabOrder = 4
    end
    object edtComplemento: TEdit
      Left = 534
      Top = 46
      Width = 83
      Height = 24
      TabOrder = 2
    end
    object edtEstado: TEdit
      Left = 422
      Top = 99
      Width = 49
      Height = 24
      TabOrder = 5
    end
    object edtLogradouro: TEdit
      Left = 137
      Top = 46
      Width = 308
      Height = 24
      TabOrder = 0
    end
    object edtNumero: TEdit
      Left = 468
      Top = 46
      Width = 44
      Height = 24
      TabOrder = 1
    end
    object edtPais: TEdit
      Left = 496
      Top = 99
      Width = 121
      Height = 24
      TabOrder = 6
    end
    object msCep: TMaskEdit
      Left = 16
      Top = 46
      Width = 97
      Height = 24
      EditMask = '00000\-999;1;_'
      MaxLength = 9
      TabOrder = 7
      Text = '     -   '
      OnExit = msCepExit
    end
  end
  object msCpf: TMaskEdit
    Left = 8
    Top = 75
    Width = 100
    Height = 21
    EditMask = '###.###.###-##;1;_'
    MaxLength = 14
    TabOrder = 2
    Text = '   .   .   -  '
  end
  object edtIdentidade: TEdit
    Left = 504
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object msTelefone: TMaskEdit
    Left = 128
    Top = 75
    Width = 97
    Height = 21
    EditMask = '!\(99\)0000-0000;1;_'
    MaxLength = 13
    TabOrder = 3
    Text = '(  )    -    '
  end
  object btnGravar: TButton
    Left = 270
    Top = 273
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 6
    OnClick = btnGravarClick
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 576
    Top = 24
  end
end
