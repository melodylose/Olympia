unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UGrapSplitter, ComCtrls, StdCtrls, UGlobal, UDM, UreEditor,
  ADODB, UModel, StrUtils, Math, DB, Generics.Defaults, Generics.Collections,
  Buttons, ToolWin, UMainEvent, xmldom, XMLIntf, msxmldom, XMLDoc, ComObj;

type
  TfmMain = class(TMainForm)
    pback: TPanel;
    Splitter1: TSplitter;
    pLeft: TPanel;
    Splitter2: TSplitter;
    pContent: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    RichEdit: TRichEdit;
    TabSheet2: TTabSheet;
    lbTitle: TLabel;
    lbMainMenuTitle: TLabel;
    pTop: TPanel;
    lbExam: TLabel;
    btPrint: TButton;
    lbSub01: TLabel;
    lbSub02: TLabel;
    cbSub01: TComboBox;
    cbSub02: TComboBox;
    cbExam_No: TComboBox;
    lbSub_No: TLabel;
    cbSubNo01: TComboBox;
    cbSubNo02: TComboBox;
    btImportGradeName: TButton;
    btImportGrade: TButton;
    btInputAwards: TButton;
    lbImage: TLabel;
    edImagePath: TEdit;
    btOpenFile: TButton;
    pContentRight: TPanel;
    pContentMain: TPanel;
    gridPanel: TGridPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btAnswerAnaly: TButton;
    RichEdit1: TRichEdit;
    fpDock1: TFlowPanel;
    lbCheckAwards: TLabel;
    fpDock2: TFlowPanel;
    lbStrucName: TLabel;
    fpDock4: TFlowPanel;
    fpDock5: TFlowPanel;
    fpDock3: TFlowPanel;
    lbStrucImport: TLabel;
    Label9: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    btRichEditTitle: TButton;
    pREdit: TPanel;
    btRichEdit: TButton;
    lbGrade: TLabel;
    pEditMenu: TPanel;
    Label6: TLabel;
    XMLDocument1: TXMLDocument;
    procedure FormCreate(Sender: TObject);
//    procedure btImportGradeClick(Sender: TObject);

  {$region 'CoustomDefineMethod'}
  private
    { Private declarations }
  public
    LStudent: TList;
    LSubScore: TList;
    PageCnt: Integer;
    LStudentDetail: TList;
    LoadTitleImage: string;
    stream: TMemoryStream;
    CheckMem: Boolean;
    streamTitle: TMemoryStream;
    sTYear, sTerm, sPath, sUser, sPW:string;
//    procedure LabelClick(Sender: TObject);
//    procedure cbSubChange(Sender: TObject);
//    function RepeatSubName(Sender: TObject): Boolean;
//    function AnsReturn(AnsString: string): String;
//    function CheckAwardsImport(Exam_No: string): Boolean;
//    function CheckStrucName: Boolean;
//    function CheckStrucImport(Exam_No: string): Boolean;
//    procedure XMLSave(XMLDoc : TXMLDocument; Attribute: TStringList);
  { Public declarations }
  {$endregion}
  end;

var
  fmMain: TfmMain;
const
  MainWidth = 705;

implementation

uses UDBSetUp, IQueryList;

{$R *.dfm}


procedure TfmMain.FormCreate(Sender: TObject);
var
  I: Integer;
  tempstring: string;
begin
  stream:= TMemoryStream.Create;
  streamTitle:= TMemoryStream.Create;
  LStudent:= TList.Create;
  LSubScore:= TList.Create;
  LStudentDetail:= TList.Create;
  Attribute:= TStringList.Create;
  try
    tempstring:=ChangeFileExt(ParamStr(0),'.XML');
    if NOT FileExists(ChangeFileExt(ParamStr(0),'.XML')) then
      Application.MessageBox('設定檔不存在','訊息',MB_OK or MB_ICONHAND)
    else
      XMLTree(XMLDocument1);

    edImagePath.Text:= ExtractFileName(Attribute.Values['ImagePath']);

    sPath:= ExtractFilePath(Application.ExeName);
    sTYear:= '101';
    sTerm:= '1';

    if FileExists(sPath+'Sys.mdb') then
    begin
      fmDBSetUp:=TfmDBSetUp.Create(Application);
      fmDBSetUp.Caption := '登入資料庫';
      fmDBSetUp.ShowModal;
      fmDBSetUp.Free;
    end
    else
    begin
      MessageBoxW(Handle, '請確認系統資料庫是否存在', '訊息', MB_OK + MB_ICONSTOP +
          MB_TOPMOST);
      Exit;
    end;
  finally

  end;

  SpeedButtonClick(SpeedButton2);

  for I := 0 to pLeft.ControlCount - 1 do
  begin
    if pLeft.Controls[I].Hint= '5' then
    begin
      TSpeedButton(pLeft.Controls[I]).OnClick:= SpeedButtonClick;
    end;
  end;

  cbExam_No.OnChange:= cbExam_NoChange;
  cbSub01.OnChange:= cbSubChange;
  cbSub02.OnChange:= cbSubChange;
  btImportGradeName.OnClick:= btImportGradeNameClick;
  btInputAwards.OnClick:= btInputAwardsClick;
  btImportGrade.OnClick:= btImportGradeClick;
  btOpenFile.OnClick:= btOpenFileClick;
  btPrint.OnClick:= btPrintClick;
  btAnswerAnaly.OnClick:= btAnswerAnalyClick;


  for I := 0 to PageControl1.Pages[1].ControlCount - 1 do
  begin
    if PageControl1.Pages[1].Controls[I].Tag = 5 then
    begin
      SendMessage(GetWindow((PageControl1.Pages[1].Controls[I] as TComboBox).Handle, GW_CHILD),
       EM_SETREADONLY, 1, 0);
    end;
  end;

  if FileExists(sPath+RichEdit1.Name+'.txt') then
    RichEdit1.Lines.LoadFromFile(sPath+RichEdit1.Name+'.txt');
  if FileExists(sPath+RichEdit.Name+'.txt') then
    RichEdit.Lines.LoadFromFile(sPath+RichEdit.Name+'.txt');
  btRichEditTitle.OnClick:= RichEditDblClick;
  btRichEdit.OnClick:= RichEditDblClick;
end;

end.
