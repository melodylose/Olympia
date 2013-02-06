unit UreEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, ImgList, Menus, StdActns, ExtActns, ComCtrls,
  ToolWin, RichEdit, ExtCtrls, Buttons, PlatformDefaultStyleActnCtrls, ActnMan,
  XPStyleActnCtrls;

type
  TfmEditor = class(TForm)
    commandIcon: TImageList;
    mmMenu: TMainMenu;
    btFile: TMenuItem;
    btEdit: TMenuItem;
    ToolBar1: TToolBar;
    tbSaveFile: TToolButton;
    btNewFile: TMenuItem;
    tbNewFile: TToolButton;
    sbStatus: TStatusBar;
    btSaveFile: TMenuItem;
    reEditor: TRichEdit;
    cbTextSize: TComboBox;
    pmRichEditor: TPopupMenu;
    itemGetDate: TMenuItem;
    btClose: TMenuItem;
    Panel1: TPanel;
    tbLeft: TToolButton;
    ActionManager1: TActionManager;
    RichEditBold1: TRichEditBold;
    RichEditItalic1: TRichEditItalic;
    RichEditUnderline1: TRichEditUnderline;
    RichEditStrikeOut1: TRichEditStrikeOut;
    RichEditBullets1: TRichEditBullets;
    RichEditAlignLeft1: TRichEditAlignLeft;
    RichEditAlignRight1: TRichEditAlignRight;
    RichEditAlignCenter1: TRichEditAlignCenter;
    NewFile: TAction;
    SaveFile: TAction;
    tbCenter: TToolButton;
    tbRight: TToolButton;
    WinClose: TAction;
    cbFontStyle: TComboBox;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    pBack: TPanel;
    pLineNumbers: TPanel;
    pbNumberDraw: TPaintBox;
    DisplayLineNumber: TAction;
    DisplayLineNumber1: TMenuItem;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    SelectAll1: TMenuItem;
    N1: TMenuItem;
    procedure NewFileExecute(Sender: TObject);
    procedure cbTextSizeChange(Sender: TObject);
    procedure reEditorKeyPress(Sender: TObject; var Key: Char);
    procedure reEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure itemGetDateClick(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WinCloseExecute(Sender: TObject);
    procedure cbFontStyleChange(Sender: TObject);
    procedure reEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure pbNumberDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbNumberDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pbNumberDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbNumberDrawPaint(Sender: TObject);
    procedure reEditorResizeRequest(Sender: TObject; Rect: TRect);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DisplayLineNumberExecute(Sender: TObject);

  public
  { Public declarations }
    FileName: string;

    function GetPosition(ARichEdit: TRichEdit): String;
    function GetRichEditFromPopup: TRichEdit;
  private
  { Private declarations }
    FGutterBmp:TBitmap;

    procedure UMUPDATEGUTTER(var Msg: TMessage); message WM_USER + 1111;  // define windowproc for listend
    procedure DrawGutter;
  end;

var
  fmEditor: TfmEditor;
  FSelf_Handle: HWND;   // form handle
  FOldWndProc: Pointer; // delcare create rich text handle

const
  UM_UPDATEGUTTER = WM_USER + 1111;

implementation

uses UMain;

{$R *.dfm}

function NewWndProc(WindowHandle: hWnd; TheMessage, ParamW, ParamL: LongInt) : LongInt; stdcall;
begin
  if TheMessage = WM_VSCROLL then
    PostMessage( FSelf_Handle, UM_UPDATEGUTTER, 0 ,0);

  Result:= CallWindowProc(FOldWndProc, WindowHandle, TheMessage, ParamW, ParamL);
end;

procedure TfmEditor.cbFontStyleChange(Sender: TObject);
begin
  reEditor.SelAttributes.Name:= cbFontStyle.Text;
  reEditor.SetFocus;
end;

procedure TfmEditor.cbTextSizeChange(Sender: TObject);
begin
  reEditor.SelAttributes.Size:= StrToInt(cbTextSize.Text);
  reEditor.SetFocus;
end;

procedure TfmEditor.NewFileExecute(Sender: TObject);
begin
  reEditor.Clear;
end;

procedure TfmEditor.pbNumberDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SendMessage(reEditor.Handle, WM_LBUTTONDOWN, MK_LBUTTON, MakeLong(1, Y));
end;

procedure TfmEditor.pbNumberDrawMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  SendMessage(reEditor.Handle, WM_MOUSEMOVE, MK_LBUTTON, MakeLong(1, Y));
end;

procedure TfmEditor.pbNumberDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SendMessage(reEditor.Handle, WM_LBUTTONUP, MK_LBUTTON, MakeLong(1, Y));
end;

procedure TfmEditor.pbNumberDrawPaint(Sender: TObject);
begin
  DrawGutter;
  pbNumberDraw.Canvas.Draw(0, 0, FGutterBmp);
end;

procedure TfmEditor.reEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  sbStatus.Panels[1].Text:= '行列：'+ GetPosition(reEditor);
end;

procedure TfmEditor.reEditorKeyPress(Sender: TObject; var Key: Char);
begin
  sbStatus.Panels[1].Text:= '行列：'+ GetPosition(reEditor);
end;

procedure TfmEditor.reEditorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  sbStatus.Panels[1].Text:= '行列：'+ GetPosition(reEditor);
  cbFontStyle.Text:= reEditor.SelAttributes.Name;
//  cbTextSize.Text:= IntToStr(reEditor.SelAttributes.Size);
end;

procedure TfmEditor.reEditorResizeRequest(Sender: TObject; Rect: TRect);
begin
  PostMessage(Handle, UM_UPDATEGUTTER, 0, 0);
end;

procedure TfmEditor.SaveFileExecute(Sender: TObject);
begin
  if fmMain.CheckMem then
  begin
    // store in memo
    fmMain.stream.Clear;
    reEditor.Lines.SaveToStream(fmMain.stream);
    reEditor.Lines.SaveToFile(fmMain.sPath+fmMain.RichEdit.Name+'.txt');
    fmMain.stream.Seek(0, soFromBeginning);
    fmMain.RichEdit.Lines.LoadFromStream(fmMain.stream);
  end
  else
  begin
    // store in title
    fmMain.streamTitle.Clear;
    reEditor.Lines.SaveToStream(fmMain.streamTitle);
    reEditor.Lines.SaveToFile(fmMain.sPath+fmMain.RichEdit1.Name+'.txt');
    fmMain.streamTitle.Seek(0, soFromBeginning);
    fmMain.RichEdit1.Lines.LoadFromStream(fmMain.streamTitle);
  end;
  WinClose.Execute;
end;

procedure TfmEditor.ToolBar1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  re: TRichEdit;
begin
  re:= GetRichEditFromPopup;
end;

procedure TfmEditor.WinCloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetWindowLong(reEditor.Handle, GWL_WNDPROC, LongInt(FOldWndProc));
  FGutterBmp.Free;
end;

procedure TfmEditor.FormCreate(Sender: TObject);
begin
  FSelf_Handle:= Handle;

  FOldWndProc:= Pointer(SetWindowLong(reEditor.Handle, GWL_WNDPROC, LongInt(@NewWndProc)));

  FGutterBmp:= TBitmap.Create;
end;

procedure TfmEditor.FormShow(Sender: TObject);
var
  I: Integer;
begin
  sbStatus.Panels[1].Text:= '行列：'+ GetPosition(reEditor);
  SendMessage(GetWindow(cbTextSize.Handle,GW_CHILD), EM_SETREADONLY, 1, 0); // set combobox readonly
  if fmMain.CheckMem then
  begin
    // search for Memo
    fmMain.stream.Seek(0 ,soFromBeginning);
    reEditor.Lines.LoadFromStream(fmMain.stream);
    if FileExists(fmMain.sPath+fmMain.RichEdit.Name+'.txt') then
      reEditor.Lines.LoadFromFile(fmMain.sPath+fmMain.RichEdit.Name+'.txt');
    reEditor.SetFocus;
  end
  else
  begin
    // search for title
    fmMain.streamTitle.Seek(0 ,soFromBeginning);
    reEditor.Lines.LoadFromStream(fmMain.streamTitle);
    if FileExists(fmMain.sPath+fmMain.RichEdit1.Name+'.txt') then
      reEditor.Lines.LoadFromFile(fmMain.sPath+fmMain.RichEdit1.Name+'.txt');
    reEditor.SetFocus;
  end;

  for I := 0 to Screen.Fonts.Count - 1 do
  begin
    cbFontStyle.Items.Add(Screen.Fonts.Strings[I]);
  end;
end;

function TfmEditor.GetPosition(ARichEdit: TRichEdit): String;
var
  iX: Integer;
  iY: Integer;
begin
  iX:= 0; iY:= 0;
  iY:= SendMessage(ARichEdit.Handle, EM_EXLINEFROMCHAR, 0, ARichEdit.SelStart+ARichEdit.SelLength);
  iX:= ARichEdit.SelStart+ARichEdit.SelLength - SendMessage(ARichEdit.Handle, EM_LINEINDEX, -1, 0);
  Result:= IntToStr(iY+1) +':'+ IntToStr(iX+1);
end;

function TfmEditor.GetRichEditFromPopup: TRichEdit;
begin
  Result:= TRichEdit(pmRichEditor.PopupComponent);
end;

procedure TfmEditor.itemGetDateClick(Sender: TObject);
begin
  reEditor.SelText:= FormatDateTime('yyyy-mm-dd', Now); // return date for now
end;

procedure TfmEditor.UMUPDATEGUTTER(var Msg: TMessage);
begin
  pbNumberDrawPaint(nil);
end;

procedure TfmEditor.DisplayLineNumberExecute(Sender: TObject);
begin
  pLineNumbers.Visible:= DisplayLineNumber1.Checked;
end;

procedure TfmEditor.DrawGutter;
var
  r: TRect;
  fristline: Integer;
  p: TPoint;
  txtrect: TRect;
  iline: Integer;
  lastline: Integer;
  ichar: Integer;
begin
  if (FGutterBmp.Width <> pbNumberDraw.Width) or (FGutterBmp.Height <> pbNumberDraw.Height) then // panel resize
  begin
    FGutterBmp.Width:= pbNumberDraw.Width;
    FGutterBmp.Height:= pbNumberDraw.Height;
  end;

  with FGutterBmp.Canvas do
  begin
    r:= Rect(0, 0, FGutterBmp.Width, FGutterBmp.Height);
    Brush.Color:= clBtnFace;
    FillRect(r);

    Font.Assign(reEditor.Font);   // inherited TRichFont font type
    Font.Color:= clGrayText;      // set font color
    // find rich text frist line
    fristline:= SendMessage(reEditor.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);

    if fristline > -1 then
    begin
      SendMessage(reEditor.Handle, EM_GETRECT, 0, LongInt(@r));
      p:= r.TopLeft;
      txtrect:= Rect(0, p.Y, FGutterBmp.Width-8, FGutterBmp.Height + 50);

      iline:= fristline;
      repeat
        txtrect.Top:= p.Y;
        DrawText(Handle, IntToStr(iline + 1), -1, txtrect,
        DT_TOP OR DT_RIGHT OR DT_SINGLELINE);

        lastline:= iline;
        repeat
          Inc(p.Y);
          ichar:= SendMessage(reEditor.Handle, EM_CHARFROMPOS, 0, LPARAM(@p));
          iline:= SendMessage(reEditor.Handle, EM_EXLINEFROMCHAR, 0, ichar);    // delcare for char start line position

        // plinenumber bottom position
        until ((p.Y > r.Bottom) or (iline <> lastline));
      until (p.Y > r.Bottom);
    end;
  end;
end;

end.
