object fmStrucAnaly: TfmStrucAnaly
  Left = 0
  Top = 0
  Caption = 'fmStrucAnaly'
  ClientHeight = 583
  ClientWidth = 890
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pContent: TPanel
    Left = 0
    Top = 0
    Width = 890
    Height = 583
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 192
    ExplicitTop = 152
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pContentStruc: TPanel
      Left = 16
      Top = 104
      Width = 425
      Height = 401
      TabOrder = 0
      object StrucTable: TStringGrid
        Left = 1
        Top = 1
        Width = 423
        Height = 399
        Align = alClient
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        ExplicitLeft = 48
        ExplicitTop = 64
        ExplicitWidth = 320
        ExplicitHeight = 120
      end
    end
    object pContentAnser: TPanel
      Left = 447
      Top = 104
      Width = 425
      Height = 401
      TabOrder = 1
      object ReadTable: TStringGrid
        Left = 1
        Top = 1
        Width = 423
        Height = 399
        Align = alClient
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        ExplicitLeft = 24
        ExplicitTop = 80
        ExplicitWidth = 320
        ExplicitHeight = 120
      end
    end
    object btExit: TButton
      Left = 796
      Top = 536
      Width = 75
      Height = 25
      Caption = 'Exit'
      TabOrder = 2
    end
    object btCalculate: TButton
      Left = 17
      Top = 536
      Width = 75
      Height = 25
      Caption = 'btCalculate'
      TabOrder = 3
    end
  end
end
