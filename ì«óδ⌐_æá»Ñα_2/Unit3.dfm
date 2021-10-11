object AboutBox: TAboutBox
  Left = 200
  Top = 108
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1089#1072#1087#1077#1088'2 - '#1054' '#1080#1075#1088#1077
  ClientHeight = 168
  ClientWidth = 285
  Color = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 1
    Top = -3
    Width = 281
    Height = 132
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProductName: TLabel
      Left = 8
      Top = 16
      Width = 123
      Height = 19
      Caption = #1053#1086#1074#1099#1081' '#1057#1072#1087#1105#1088' 2'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Copyright: TLabel
      Left = 8
      Top = 80
      Width = 96
      Height = 18
      Caption = 'Vlad23.my1.ru'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      IsControl = True
    end
    object Comments: TLabel
      Left = 8
      Top = 105
      Width = 259
      Height = 18
      Caption = #1048#1075#1088#1091' '#1089#1086#1079#1076#1072#1083' '#1051#1086#1082#1090#1080#1086#1085#1086#1074' '#1042#1083#1072#1076#1080#1089#1083#1072#1074
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      IsControl = True
    end
  end
  object OKButton: TButton
    Left = 252
    Top = 135
    Width = 30
    Height = 25
    Caption = #1054#1050
    Default = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
end
