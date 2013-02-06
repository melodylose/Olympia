unit UStrucSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Spin, Grids;

type
  TfmStrucSetting = class(TForm)
    pback: TPanel;
    pTop: TPanel;
    pContent: TPanel;
    Splitter1: TSplitter;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pGradeContent: TPanel;
    GroupBox1: TGroupBox;
    pGradeRight: TPanel;
    pGrade: TPanel;
    pGradeTop: TPanel;
    Splitter2: TSplitter;
    TreeView1: TTreeView;
    Label1: TLabel;
    lbStatus: TLabel;
    endNo: TSpinEdit;
    startNo: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbExam_No: TComboBox;
    Label5: TLabel;
    cbSub_Name: TComboBox;
    Label6: TLabel;
    cbStrucName: TComboBox;
    Label7: TLabel;
    cbStrucNo: TComboBox;
    btEnter: TButton;
    btReset: TButton;
    btExit: TButton;
    Label8: TLabel;
    cbSub_No: TComboBox;
    pViewer: TPanel;
    pViewContent: TPanel;
    pViewMenu: TPanel;
    AnsTable: TStringGrid;
    btInsert: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure cbSub_NameChange(Sender: TObject);
    procedure cbSub_NoChange(Sender: TObject);
    procedure cbStrucNameChange(Sender: TObject);
    procedure btEnterClick(Sender: TObject);
    procedure btInsertClick(Sender: TObject);
  private
    MaxSerNo: string;
    { Private declarations }
  public
    procedure ChangeCombobox(Sender: TObject);
    function GetMaxSerNo(Exam_No, Sub_Name, Sub_No: string): Integer;
    function RepeatSubName(Sender: TObject): Boolean;
  { Public declarations }
  end;

var
  fmStrucSetting: TfmStrucSetting;

implementation

uses UMain, UGlobal, UDM;

{$R *.dfm}

procedure TfmStrucSetting.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfmStrucSetting.FormShow(Sender: TObject);
begin
  cbExam_No.Clear;
  cbExam_No.Items.Add(fmMain.cbExam_No.Text);
  cbExam_No.ItemIndex:= 0;
  cbExam_No.OnChange:= ChangeCombobox;

  ChangeCombobox(nil);
  MaxSerNo:= IntToStr(GetMaxSerNo(cbExam_No.Text, cbSub_Name.Text, cbSub_No.Text));
  startNo.MaxValue:= StrToInt(MaxSerNo);
  endNo.MaxValue:= StrToInt(MaxSerNo);

  SqlStr:= 'select * from tb_struc';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  cbStrucName.Clear;
  cbStrucNo.Clear;
  while NOT DM.adoQueryTempAnaly.Eof do
  begin
    cbStrucName.AddItem(DM.adoQueryTempAnaly.FieldByName('struc_name').AsString, nil);
    cbStrucNo.AddItem(DM.adoQueryTempAnaly.FieldByName('struc_no').AsString, nil);
    DM.adoQueryTempAnaly.Next;
  end;

end;

procedure TfmStrucSetting.btEnterClick(Sender: TObject);
var
  I: Integer;
  Cnt, Point: Integer;
  Temp: string;
  J: Integer;
  UpdateStr: string;
  UpdateCount: Integer;
begin
  if NOT (cbStrucName.Text <> '') then
  begin
    MessageBoxW(Handle, '請選擇項度名稱', '訊息', MB_OK + MB_ICONINFORMATION +
        MB_TOPMOST);
    cbStrucName.SetFocus;
    Exit;
  end;

  if (cbStrucNo.ItemIndex = -1) or (endNo.Value - startNo.Value < 0) then
  begin
    MessageBoxW(Handle, '請輸入項度資訊', '訊息', MB_OK + MB_ICONINFORMATION +
        MB_TOPMOST);
    Exit;
  end;

  UpdateCount:= 0;

  for I := TreeView1.Items.Count -1 downto 0 do
  begin
    for J := startNo.Value to endNo.Value do
    begin
      if J > I then Break;
      if (Pos('['+FormatFloat('00', J)+']', TreeView1.Items[I].Text) > 0) or
        (Pos('['+FormatFloat('000', J)+']', TreeView1.Items[I].Text) > 0)
      then
      begin
        UpdateStr:= Copy(TreeView1.Items[I].Text,
                         Pos(']', TreeView1.Items[I].Text)+1,
                         Length(TreeView1.Items[I].Text));
        TreeView1.Items[I].Text:= StringReplace(TreeView1.Items[I].Text, UpdateStr,
                                                cbStrucName.Text, [rfReplaceAll, rfIgnoreCase]);
        Inc(UpdateCount);
      end;
    end;
  end;



  if TreeView1.Items.Count = 0 then TreeView1.Items.Add(nil, '試題結構');

  Point:= 1;
  Cnt:= 0;
  for I := 0 to TreeView1.Items.Count - 1 do
  begin
    if (TreeView1.Items[I] <> nil) and (TreeView1.Items[I].Parent = nil) then
    begin
      Inc(Cnt);
      if Cnt = Point then
      begin
        Temp:= TreeView1.Items[I].Text;
        for J:= (startNo.Value + UpdateCount) to endNo.Value do
        begin
          if NOT TreeView1.Items[I].HasChildren then
          begin
            if endNo.Value <= TreeView1.Items.Count then
            begin
              TreeView1.Items.AddChild(TreeView1.Items[I],
              '['+FormatFloat('00', J)+']'+cbStrucName.Text);
            end
            else
            begin
              TreeView1.Items.AddChild(TreeView1.Items[I],
              '['+FormatFloat('00', J)+']'+cbStrucName.Text);
            end;
          end
          else
          begin
            if endNo.Value <= TreeView1.Items.Count then
            begin
              TreeView1.Items.Add(TreeView1.Items[I].Item[0],
              '['+FormatFloat('00', J)+']'+cbStrucName.Text);
            end
            else
            begin
              TreeView1.Items.Add(TreeView1.Items[I].Item[0],
              '['+FormatFloat('00', J)+']'+cbStrucName.Text);
            end;
          end;
        end;
        TreeView1.Items.Item[I].Expanded:= True;
      end;
    end;
  end;

  for J := startNo.Value to endNo.Value do
  begin
    AnsTable.Cells[0, J]:= FormatFloat('00', J);   // serno
    AnsTable.Cells[1, J]:= Trim(cbStrucNo.Text);   // strucno
    AnsTable.Cells[2, J]:= Trim(cbStrucName.Text); // strucname
    AnsTable.Cells[3, J]:= Trim(cbSub_No.Text);    // subno
    AnsTable.Cells[4, J]:= Trim(cbSub_Name.Text);  // subname
  end;

  startNo.Value:= endNo.Value +1;
  endNo.Value:= startNo.Value;
end;



procedure TfmStrucSetting.btExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmStrucSetting.btInsertClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to AnsTable.RowCount - 1 do
  begin
    if NOT (Trim(AnsTable.Cells[0, I+1]) <> '') then Exit;

    SqlStr:= 'INSERT INTO Tb_ExamStruc(Exam_No, Sub_No, Ser_No, Struc_No)'+
             'Values ('+QuotedStr(Trim(cbExam_No.Text))+
             ','+QuotedStr(Trim(AnsTable.Cells[3, I+1]))+
             ','+Trim(AnsTable.Cells[0, I+1])+
             ','+QuotedStr(Trim(AnsTable.Cells[1, I+1]))+
             ')';

    SqlExec(DM.adoQueryTempAnaly, SqlStr);
  end;
end;

procedure TfmStrucSetting.cbStrucNameChange(Sender: TObject);
begin
  cbStrucNo.ItemIndex:= (Sender as TComboBox).ItemIndex;
end;

procedure TfmStrucSetting.cbSub_NameChange(Sender: TObject);
begin
  SqlStr:= ' select Distinct Sub_No from sub_score where exam_no = '+QuotedStr(cbExam_No.Text)+
           ' And sub_name = '+QuotedStr((Sender as TComboBox).Text);
  SqlOpen(DM.adoQueryTempEx, SqlStr);
  cbSub_No.Visible:= RepeatSubName(Sender);
  Label8.Visible:= cbSub_No.Visible;
end;

procedure TfmStrucSetting.cbSub_NoChange(Sender: TObject);
begin
  MaxSerNo:= IntToStr(GetMaxSerNo(cbExam_No.Text, cbSub_Name.Text, cbSub_No.Text));
  startNo.MaxValue:= StrToInt(MaxSerNo);
  endNo.MaxValue:= StrToInt(MaxSerNo);
end;

procedure TfmStrucSetting.ChangeCombobox(Sender: TObject);
begin
  SqlStr:='select Distinct sub_name from sub_score where exam_no = '+QuotedStr(cbExam_No.Text);
  SqlOpen(DM.adoQueryTempEx, SqlStr);

  cbSub_Name.Clear;
  while NOT DM.adoQueryTempEx.Eof do
  begin
    cbSub_Name.AddItem(DM.adoQueryTempEx.FieldByName('sub_name').AsString, nil);
    DM.adoQueryTempEx.Next;
  end;
  cbSub_Name.ItemIndex:= 0;
  cbSub_NameChange(cbSub_Name);
end;

function TfmStrucSetting.GetMaxSerNo(Exam_No, Sub_Name, Sub_No: string): Integer;
var
  SerNo: Integer;
begin
  SerNo:= -1;
  SqlStr:= 'SELECT Count(*) as cnt from exam_question where '+
           'exam_no='+QuotedStr(Exam_No)+
           ' and sub_no = '+QuotedStr(Sub_No)+
           ' and sub_name='+QuotedStr(Sub_Name);
  SqlOpen(DM.adoQueryTempEx, SqlStr);

  while NOT DM.adoQueryTempEx.Eof do
  begin
    SerNo:= DM.adoQueryTempEx.FieldByName('cnt').AsInteger;
    DM.adoQueryTempEx.Next;
  end;
  GetMaxSerNo:= SerNo;
end;

function TfmStrucSetting.RepeatSubName(Sender: TObject): Boolean;
begin
  cbSub_No.Clear;
  while NOT DM.adoQueryTempEx.Eof do
  begin
    cbSub_No.AddItem(DM.adoQueryTempEx.FieldByName('Sub_No').AsString, nil);
    DM.adoQueryTempEx.Next;
  end;
  cbSub_No.ItemIndex:= 0;
  RepeatSubName:= cbSub_No.Items.Count > 1;
end;

end.
