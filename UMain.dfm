object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #21015#21360#22577#34920
  ClientHeight = 456
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pback: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 456
    Align = alClient
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 121
      Top = 1
      Width = 0
      Height = 454
    end
    object pLeft: TPanel
      Left = 1
      Top = 1
      Width = 120
      Height = 454
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = -1
        Top = 48
        Width = 120
        Height = 35
        Hint = '5'
        GroupIndex = 99
        Caption = #25104#32318#21934#26684#24335#35373#23450
        Flat = True
      end
      object SpeedButton2: TSpeedButton
        Tag = 1
        Left = -1
        Top = 104
        Width = 120
        Height = 35
        Hint = '5'
        GroupIndex = 99
        Caption = #25104#32318#21934#36039#26009#35373#23450
        Flat = True
      end
      object SpeedButton3: TSpeedButton
        Tag = 2
        Left = -1
        Top = 161
        Width = 120
        Height = 35
        Hint = '5'
        GroupIndex = 99
        Caption = #38626#38283
        Flat = True
      end
    end
    object pContent: TPanel
      Left = 121
      Top = 1
      Width = 567
      Height = 454
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pContentRight: TPanel
        Left = 405
        Top = 0
        Width = 162
        Height = 454
        Align = alRight
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 0
        Visible = False
        object gridPanel: TGridPanel
          Left = 0
          Top = 0
          Width = 162
          Height = 454
          Align = alClient
          BevelOuter = bvNone
          ColumnCollection = <
            item
              Value = 33.333333333333340000
            end
            item
              Value = 66.666666666666660000
            end>
          ControlCollection = <
            item
              Column = 0
              Control = Label1
              Row = 0
            end
            item
              Column = 0
              Control = Label2
              Row = 1
            end
            item
              Column = 0
              Control = Label3
              Row = 2
            end
            item
              Column = 0
              Control = Label4
              Row = 4
            end
            item
              Column = 0
              Control = Label5
              Row = 3
            end
            item
              Column = 1
              Control = fpDock1
              Row = 0
            end
            item
              Column = 1
              Control = fpDock2
              Row = 1
            end
            item
              Column = 1
              Control = fpDock4
              Row = 3
            end
            item
              Column = 1
              Control = fpDock5
              Row = 4
            end
            item
              Column = 1
              Control = fpDock3
              Row = 2
            end>
          Padding.Left = 5
          Padding.Top = 5
          Padding.Right = 5
          Padding.Bottom = 5
          RowCollection = <
            item
              SizeStyle = ssAbsolute
              Value = 90.000000000000000000
            end
            item
              SizeStyle = ssAbsolute
              Value = 90.000000000000000000
            end
            item
              SizeStyle = ssAbsolute
              Value = 90.000000000000000000
            end
            item
              SizeStyle = ssAbsolute
              Value = 90.000000000000000000
            end
            item
              SizeStyle = ssAbsolute
              Value = 90.000000000000000000
            end>
          TabOrder = 0
          DesignSize = (
            162
            454)
          object Label1: TLabel
            Left = 24
            Top = 39
            Width = 11
            Height = 21
            Anchors = []
            Caption = '1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitTop = 41
          end
          object Label2: TLabel
            Left = 24
            Top = 129
            Width = 11
            Height = 21
            Anchors = []
            Caption = '2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitTop = 132
          end
          object Label3: TLabel
            Left = 24
            Top = 219
            Width = 11
            Height = 21
            Anchors = []
            Caption = '3'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitTop = 224
          end
          object Label4: TLabel
            Left = 24
            Top = 399
            Width = 11
            Height = 21
            Anchors = []
            Caption = '5'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitTop = 408
          end
          object Label5: TLabel
            Left = 24
            Top = 309
            Width = 11
            Height = 21
            Anchors = []
            Caption = '4'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitTop = 316
          end
          object fpDock1: TFlowPanel
            Left = 60
            Top = 39
            Width = 88
            Height = 55
            Align = alCustom
            BevelOuter = bvNone
            FlowStyle = fsTopBottomLeftRight
            FullRepaint = False
            TabOrder = 0
            DesignSize = (
              88
              55)
            object btInputAwards: TButton
              Left = 0
              Top = 0
              Width = 86
              Height = 25
              Anchors = []
              Caption = #23416#29983#29518#38917#21295#20837
              TabOrder = 0
            end
            object lbCheckAwards: TLabel
              Left = 0
              Top = 26
              Width = 86
              Height = 23
              Alignment = taCenter
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = #26032#32048#26126#39636
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
            end
          end
          object fpDock2: TFlowPanel
            Left = 60
            Top = 129
            Width = 88
            Height = 55
            Align = alCustom
            BevelOuter = bvNone
            FlowStyle = fsTopBottomLeftRight
            FullRepaint = False
            TabOrder = 1
            DesignSize = (
              88
              55)
            object btImportGradeName: TButton
              Left = 0
              Top = 0
              Width = 86
              Height = 25
              Anchors = []
              Caption = #25351#27161#21517#31281#21295#20837
              TabOrder = 0
            end
            object lbStrucName: TLabel
              Left = 0
              Top = 26
              Width = 86
              Height = 23
              Alignment = taCenter
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = #26032#32048#26126#39636
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
            end
          end
          object fpDock4: TFlowPanel
            Left = 60
            Top = 309
            Width = 88
            Height = 55
            Align = alCustom
            BevelOuter = bvNone
            FlowStyle = fsTopBottomLeftRight
            FullRepaint = False
            TabOrder = 2
            DesignSize = (
              88
              55)
            object btAnswerAnaly: TButton
              Left = 0
              Top = 0
              Width = 86
              Height = 25
              Anchors = []
              Caption = #31572#23565#29575#20998#26512
              TabOrder = 0
            end
            object Label9: TLabel
              Left = 0
              Top = 26
              Width = 86
              Height = 23
              Alignment = taCenter
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = #26032#32048#26126#39636
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
            end
          end
          object fpDock5: TFlowPanel
            Left = 60
            Top = 399
            Width = 88
            Height = 55
            Align = alCustom
            BevelOuter = bvNone
            FlowStyle = fsTopBottomLeftRight
            FullRepaint = False
            TabOrder = 3
            object btPrint: TButton
              Left = 0
              Top = 0
              Width = 86
              Height = 25
              Caption = #21015#21360
              TabOrder = 0
            end
          end
          object fpDock3: TFlowPanel
            Left = 60
            Top = 219
            Width = 88
            Height = 55
            Align = alCustom
            BevelOuter = bvNone
            FlowStyle = fsTopBottomLeftRight
            FullRepaint = False
            TabOrder = 4
            DesignSize = (
              88
              55)
            object btImportGrade: TButton
              Left = 0
              Top = 0
              Width = 86
              Height = 25
              Anchors = []
              Caption = #25351#27161#32080#27083#21295#20837
              TabOrder = 0
            end
            object lbStrucImport: TLabel
              Left = 0
              Top = 26
              Width = 86
              Height = 23
              Alignment = taCenter
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = #26032#32048#26126#39636
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
            end
          end
        end
      end
      object pContentMain: TPanel
        Left = 0
        Top = 0
        Width = 405
        Height = 454
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Splitter1: TSplitter
          Left = 0
          Top = 28
          Width = 405
          Height = 0
          Cursor = crVSplit
          Align = alTop
        end
        object PageControl1: TPageControl
          Left = 0
          Top = 28
          Width = 405
          Height = 426
          ActivePage = TabSheet1
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          MultiLine = True
          ParentFont = False
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = 'TabSheet1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabVisible = False
            object lbTitle: TLabel
              Left = 8
              Top = 62
              Width = 96
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = #25104#32318#21934#27161#38988#35373#23450#65306
            end
            object lbImage: TLabel
              Left = 13
              Top = 14
              Width = 99
              Height = 13
              Alignment = taRightJustify
              Caption = #27161' '#38988' '#22294' '#27284' '#36335' '#24465#65306
            end
            object Label6: TLabel
              Left = 8
              Top = 232
              Width = 96
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = #25104' '#32318' '#21934' '#20633' '#35387#65306
            end
            object pREdit: TPanel
              Left = 114
              Top = 229
              Width = 257
              Height = 160
              Align = alCustom
              BevelOuter = bvNone
              TabOrder = 0
              object RichEdit: TRichEdit
                Left = 0
                Top = 0
                Width = 257
                Height = 119
                Align = alClient
                Font.Charset = CHINESEBIG5_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                ScrollBars = ssBoth
                TabOrder = 0
              end
              object pEditMenu: TPanel
                Left = 0
                Top = 119
                Width = 257
                Height = 41
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 1
                object btRichEdit: TButton
                  Left = 180
                  Top = 8
                  Width = 75
                  Height = 25
                  Caption = #32232#36655
                  TabOrder = 0
                end
              end
            end
            object edImagePath: TEdit
              Left = 122
              Top = 11
              Width = 145
              Height = 21
              TabOrder = 1
            end
            object btOpenFile: TButton
              Left = 281
              Top = 9
              Width = 75
              Height = 25
              Caption = #28687#35261'...'
              TabOrder = 2
            end
            object RichEdit1: TRichEdit
              Left = 114
              Top = 59
              Width = 255
              Height = 125
              Font.Charset = CHINESEBIG5_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              ScrollBars = ssBoth
              TabOrder = 3
            end
            object btRichEditTitle: TButton
              Left = 296
              Top = 190
              Width = 75
              Height = 25
              Caption = #32232#36655
              TabOrder = 4
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'TabSheet2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ImageIndex = 1
            ParentFont = False
            TabVisible = False
            object lbExam: TLabel
              Left = 27
              Top = 15
              Width = 96
              Height = 13
              Alignment = taRightJustify
              Caption = #32771#12288#35430#12288#20195#12288#30908#65306
            end
            object lbSub01: TLabel
              Left = 27
              Top = 53
              Width = 96
              Height = 13
              Alignment = taRightJustify
              Caption = #31532#19968#31680#32771#35430#31185#30446#65306
            end
            object lbSub02: TLabel
              Left = 27
              Top = 93
              Width = 96
              Height = 13
              Alignment = taRightJustify
              Caption = #31532#20108#31680#32771#35430#31185#30446#65306
            end
            object lbSub_No: TLabel
              Left = 299
              Top = 34
              Width = 48
              Height = 13
              Caption = #31185#30446#20195#30908
              Visible = False
            end
            object lbGrade: TLabel
              Left = 291
              Top = 15
              Width = 3
              Height = 13
            end
            object cbSub01: TComboBox
              Tag = 5
              Left = 133
              Top = 50
              Width = 145
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = 'cbSub01'
            end
            object cbSub02: TComboBox
              Tag = 5
              Left = 133
              Top = 90
              Width = 145
              Height = 21
              ItemHeight = 13
              TabOrder = 1
              Text = 'cbSub02'
            end
            object cbExam_No: TComboBox
              Tag = 5
              Left = 133
              Top = 12
              Width = 145
              Height = 21
              ItemHeight = 13
              TabOrder = 2
              Text = 'cbExam_No'
            end
            object cbSubNo01: TComboBox
              Tag = 5
              Left = 299
              Top = 50
              Width = 50
              Height = 21
              ItemHeight = 13
              TabOrder = 3
              Text = 'cbSubNo01'
              Visible = False
            end
            object cbSubNo02: TComboBox
              Tag = 5
              Left = 299
              Top = 90
              Width = 50
              Height = 21
              ItemHeight = 13
              TabOrder = 4
              Text = 'cbSubNo02'
              Visible = False
            end
          end
        end
        object pTop: TPanel
          Left = 0
          Top = 0
          Width = 405
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object lbMainMenuTitle: TLabel
            Left = 12
            Top = -1
            Width = 144
            Height = 21
            Caption = #22577#34920#39023#31034#38917#30446#35373#23450
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 32
    Top = 408
    DOMVendorDesc = 'MSXML'
  end
end
