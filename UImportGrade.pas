unit UImportGrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB;

type
  TfmImportGrade = class(TForm)
    pContent: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btImport: TButton;
    cbExamNo: TComboBox;
    cbSubName: TComboBox;
    cbSubNo: TComboBox;
    btExit: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbExamNoChange(Sender: TObject);
    procedure cbSubNameChange(Sender: TObject);
    procedure btImportClick(Sender: TObject);
  private
    { Private declarations }
  public
    function RepeatSubName(Sender: TObject): Boolean;
  { Public declarations }
  end;

var
  fmImportGrade: TfmImportGrade;

implementation

uses UMain, UDM, UGlobal, StrUtils;

{$R *.dfm}

procedure TfmImportGrade.btExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmImportGrade.btImportClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  xlsFileName, SerNo: string;
  LInsertSqlList: TStringList;
  Test: Int64;
  SerCount: Integer;
  StrucNo: string;
begin
  SqlStr:= ' SELECT * FROM Tb_ExamStruc' +
           ' WHERE Exam_No = '+ QuotedStr(cbExamNo.Text)+
           ' And Sub_No = '+ QuotedStr(cbSubNo.Text);
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);

  if NOT DM.adoQueryTempAnaly.IsEmpty then
  begin
    if MessageBoxW(Handle, PChar(Trim(cbSubName.Text)+' 向度結構已存在，是否覆蓋'), '訊息', MB_OKCANCEL +
        MB_ICONINFORMATION + MB_TOPMOST) = IDCANCEL then
    begin
      Exit;
    end
    else
    begin
      SqlStr:= ' DELETE FROM Tb_ExamStruc' +
               ' WHERE Exam_No = '+ QuotedStr(cbExamNo.Text)+
               ' And Sub_No = '+ QuotedStr(cbSubNo.Text);
      SqlExec(DM.adoQueryTempAnaly, SqlStr);
    end;
  end;

  OpenDialog:= TOpenDialog.Create(nil);
  OpenDialog.DefaultExt:= '*.csv';
  OpenDialog.InitialDir:= ExtractFilePath(Application.ExeName);
  OpenDialog.Filter:='Excel(*.xls)|*.xls;Text(*.csv)|*.csv;Text(*.txt)|*.txt';
  OpenDialog.FileName:=EmptyStr;
  OpenDialog.Title:='請選擇所要匯入的檔案:';
  LInsertSqlList:= TStringList.Create;

  if OpenDialog.Execute then
  begin
    xlsFileName:= OpenDialog.FileName;
    if DM.conn.Connected then  DM.conn.Close;
    DM.conn.ConnectionString:=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+xlsFileName+';'+
    'Extended Properties="Excel 8.0;HDR=No;";';
    DM.conn.Open;
    DM.adods.Close;
    DM.adods.CommandText:='';
    DM.adods.CommandText:='select * from [sheet1$]';
    DM.adods.Open;
    DM.adods.Last;
    DM.adods.First;
    xlsFileName:= Unassigned;
    SerCount:= 0;
    while NOT DM.adods.Eof do
    begin
      if TryStrToInt64(Trim(DM.adods.FieldByName('F1').AsString), Test) then
        if (GetZeroString(StrToInt(Trim(DM.adods.FieldByName('F1').AsString)),2) = cbSubNo.Text) then
        begin
          if DM.adods.RecNo = 1 then
          begin
            SerNo:= Trim(DM.adods.FieldByName('F2').AsString);
            StrucNo:= Trim(DM.adods.FieldByName('F3').AsString);
            SqlStr:= 'INSERT INTO Tb_ExamStruc(Exam_No, Sub_No, Ser_No, Struc_No, RightRate) '+
                     'Values(' +
                     QuotedStr(cbExamNo.Text)+ ',' +                                           // Exam_No
                     QuotedStr(GetZeroString(StrToInt(
                     Trim(DM.adods.FieldByName('F1').AsString)),2))+ ',' +                     // SubNo
                     QuotedStr(Trim(DM.adods.FieldByName('F2').AsString))+ ',' +               // Ser_No
                     QuotedStr(Trim(DM.adods.FieldByName('F3').AsString))+ ',' +               // struc_no
                     QuotedStr(Trim(DM.adods.FieldByName('F4').AsString))+                     // RightRate
                     ')';

            LInsertSqlList.Add(SqlStr);
            DM.adods.Next;
            Continue;
          end;

          if Trim(DM.adods.FieldByName('F2').AsString) <> SerNo then
          begin
            if Trim(DM.adods.FieldByName('F3').AsString) <> StrucNo then
              StrucNo:= Trim(DM.adods.FieldByName('F3').AsString);
            SerNo:= Trim(DM.adods.FieldByName('F2').AsString);
            SerCount:= SerCount + 1;
          end
          else
          begin
            if Trim(DM.adods.FieldByName('F3').AsString) = StrucNo then
            begin

              Application.MessageBox(PChar('題號: '+SerNo+'題 指標結構: '+StrucNo+'重複!!'), '訊息', MB_OK +
                MB_ICONWARNING);
              Exit;
            end
            else
              StrucNo:= Trim(DM.adods.FieldByName('F3').AsString);
          end;

          SqlStr:= 'INSERT INTO Tb_ExamStruc(Exam_No, Sub_No, Ser_No, Struc_No, RightRate) '+
                   'Values(' +
                   QuotedStr(cbExamNo.Text)+ ',' +                                           // Exam_No
                   QuotedStr(GetZeroString(StrToInt(
                   Trim(DM.adods.FieldByName('F1').AsString)),2))+ ',' +                     // SubNo
                   QuotedStr(Trim(DM.adods.FieldByName('F2').AsString))+ ',' +               // Ser_No
                   QuotedStr(Trim(DM.adods.FieldByName('F3').AsString))+ ',' +               // struc_no
                   QuotedStr(Trim(DM.adods.FieldByName('F4').AsString))+                     // RightRate
                   ')';
          LInsertSqlList.Add(SqlStr);
        end;
      DM.adods.Next;
    end;

    SqlStr:= ' select count(*) as cnt from exam_question' +
             ' where exam_no ='+QuotedStr(cbExamNo.Text)+
             ' and sub_no ='+QuotedStr(cbSubNo.Text);
    SqlOpen(DM.adoQueryTempEx, SqlStr);

    if NOT DM.adoQueryTempEx.IsEmpty then
    begin
      DM.adoQueryTempEx.First;
      if DM.adoQueryTempEx.FieldByName('cnt').AsInteger <> SerCount then
      begin
        MessageBoxW(Handle, '請確認匯入總題數是否正確', '訊息', MB_OK + MB_ICONINFORMATION +
            MB_TOPMOST);
        Exit;
      end;
    end;



    if LInsertSqlList.Text = '' then
    begin
      MessageBoxW(Handle, '無向度結構匯入，請確認科目代號是否正確', '訊息', MB_OK +
          MB_ICONINFORMATION + MB_TOPMOST);
      LInsertSqlList.Free;
      DM.adods.Close;
      DM.conn.Close;
      Exit;
    end;

    try
      SqlExec(DM.adoQueryTempAnaly, LInsertSqlList.Text);
    except
      MessageBoxW(Handle, '匯入失敗', '訊息', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      LInsertSqlList.Free;
      DM.adods.Close;
      DM.conn.Close;
      Exit;
    end;
    MessageBoxW(Handle, '匯入完成', '訊息', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    CheckStrucImport(cbExamNo.Text);
    LInsertSqlList.Free;
    DM.adods.Close;
    DM.conn.Close;
  end;
end;

procedure TfmImportGrade.cbExamNoChange(Sender: TObject);
var
  Sub_No: string;
begin
  SqlStr:= 'select Distinct Sub_No, Sub_Name from sub_score where '+
         ' Exam_No='+QuotedStr(cbExamNo.Text)+
         ' order by sub_name';
  SqlOpen(DM.adoQueryTempEx, SqlStr);
  cbSubName.Clear;
  Sub_No:= EmptyStr;
  while NOT DM.adoQueryTempEx.Eof do
  begin
    if Sub_No <> Trim(DM.adoQueryTempEx.FieldByName('Sub_Name').AsString) then
    begin
      Sub_No:= Trim(DM.adoQueryTempEx.FieldByName('Sub_Name').AsString);
      cbSubName.AddItem(DM.adoQueryTempEx.FieldByName('Sub_Name').AsString, nil);
    end;
    DM.adoQueryTempEx.Next;
  end;
  cbSubName.ItemIndex:= 0;
end;

procedure TfmImportGrade.cbSubNameChange(Sender: TObject);
begin
  SqlStr:= ' select Distinct Sub_No from sub_score where exam_no = '+QuotedStr(cbExamNo.Text)+
         ' And sub_name = '+QuotedStr(cbSubName.Text);
  SqlOpen(DM.adoQueryTempEx, SqlStr);
  cbSubNo.Visible:= RepeatSubName(cbSubName);
end;

procedure TfmImportGrade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmMain.Show;
  Action:= caFree;
end;

procedure TfmImportGrade.FormShow(Sender: TObject);
var
  I: Integer;
begin
  cbExamNo.Clear;
  cbExamNo.AddItem(fmMain.cbExam_No.Text, nil);
  cbExamNo.ItemIndex:= 0;
  cbExamNoChange(nil);
  cbSubNameChange(nil);
  for I := 0 to pContent.ControlCount - 1 do
  begin
    if pContent.Controls[I].Tag = 5 then
    begin
      SendMessage(GetWindow((pContent.Controls[I] as TComboBox).Handle, GW_CHILD),
      EM_SETREADONLY, 1, 0);
    end;
  end;
end;

function TfmImportGrade.RepeatSubName(Sender: TObject): Boolean;
begin
  cbSubNo.Clear;
  while NOT DM.adoQueryTempEx.Eof do
  begin
    cbSubNo.AddItem(DM.adoQueryTempEx.FieldByName('Sub_No').AsString, nil);
    DM.adoQueryTempEx.Next;
  end;
  cbSubNo.ItemIndex:= 0;
  RepeatSubName:= cbSubNo.Items.Count > 1;
end;

end.
