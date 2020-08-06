object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1050#1072#1088#1090#1080#1085#1082#1086'-'#1091#1078#1080#1084#1072#1090#1086#1088' 0.2b'
  ClientHeight = 642
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 407
    Top = 37
    Width = 593
    Height = 332
    Proportional = True
  end
  object Label1: TLabel
    Left = 407
    Top = 18
    Width = 20
    Height = 13
    Caption = '-----'
  end
  object Label3: TLabel
    Left = 900
    Top = 448
    Width = 12
    Height = 13
    Caption = '85'
  end
  object Label2: TLabel
    Left = 754
    Top = 417
    Width = 86
    Height = 13
    Caption = 'JPEG '#1050#1086#1084#1087#1088#1077#1089#1089#1080#1103
  end
  object Label4: TLabel
    Left = 418
    Top = 417
    Width = 90
    Height = 13
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1088#1072#1079#1084#1077#1088':'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1087#1082#1091
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 63
    Width = 393
    Height = 571
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object Button2: TButton
    Left = 894
    Top = 487
    Width = 106
    Height = 41
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100' '#1074#1089#1077
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 183
    Top = 10
    Width = 218
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 505
    Top = 448
    Width = 37
    Height = 21
    TabOrder = 4
    Text = '50'
  end
  object RadioButton1: TRadioButton
    Left = 415
    Top = 436
    Width = 68
    Height = 17
    Caption = #1055#1080#1082#1089#1077#1083#1080
    TabOrder = 5
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 415
    Top = 459
    Width = 68
    Height = 17
    Caption = #1055#1088#1086#1094#1077#1085#1090#1099
    Checked = True
    TabOrder = 6
    TabStop = True
    OnClick = RadioButton2Click
  end
  object TrackBar1: TTrackBar
    Left = 747
    Top = 436
    Width = 147
    Height = 45
    LineSize = 10
    Max = 100
    PageSize = 10
    Frequency = 10
    Position = 85
    TabOrder = 7
    TickMarks = tmBoth
    OnChange = TrackBar1Change
  end
  object ProgressBar1: TProgressBar
    Left = 407
    Top = 383
    Width = 593
    Height = 17
    TabOrder = 8
  end
  object Button3: TButton
    Left = 295
    Top = 37
    Width = 106
    Height = 20
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100' '#1101#1090#1086#1090
    TabOrder = 9
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 176
    Top = 37
    Width = 113
    Height = 21
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1086#1095#1077#1088#1077#1076#1080
    TabOrder = 10
    OnClick = Button4Click
  end
  object RadioGroup1: TRadioGroup
    Left = 556
    Top = 417
    Width = 185
    Height = 71
    Caption = #1057#1078#1080#1084#1072#1090#1100' '#1087#1086':'
    ItemIndex = 1
    Items.Strings = (
      #1055#1086' '#1074#1099#1089#1086#1090#1077
      #1055#1086' '#1096#1080#1088#1080#1085#1077
      #1055#1086' '#1073#1086#1083#1100#1096#1077' '#1089#1090#1086#1088#1086#1085#1077)
    TabOrder = 11
    Visible = False
  end
  object Button5: TButton
    Left = 61
    Top = 37
    Width = 113
    Height = 22
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 12
    OnClick = Button5Click
  end
  object Memo1: TMemo
    Left = 407
    Top = 534
    Width = 593
    Height = 101
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 13
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = #1042#1089#1077
        FileMask = '*.*'
      end>
    Options = [fdoPickFolders]
    Left = 32
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 72
    Top = 72
    object File1: TMenuItem
      Caption = #1060#1072#1081#1083
      object Open1: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091
        OnClick = Open1Click
      end
      object Exit1: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = Exit1Click
      end
    end
    object About1: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object About2: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = About2Click
      end
    end
  end
end
