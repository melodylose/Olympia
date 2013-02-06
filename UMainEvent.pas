unit UMainEvent;

interface

uses
  Forms, SysUtils, Buttons, StdCtrls, StrUtils, ComCtrls, Dialogs, Classes,
  Windows, Variants, Math;

type

  TMainForm = class(TForm)
    procedure cbSubChange(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure RichEditDblClick(Sender: TObject);
    procedure cbExam_NoChange(Sender: TObject);
    procedure btImportGradeNameClick(Sender: TObject);
    procedure btInputAwardsClick(Sender: TObject);
    procedure btImportGradeClick(Sender: TObject);
    procedure btOpenFileClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure btAnswerAnalyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

implementation

uses UMain, UGlobal, UDM, UreEditor, UImportGrade, UReport, UModel,
  UStrucAnaly;

{ TMainForm }


procedure TMainForm.cbSubChange(Sender: TObject);
begin
  // 科目名稱重複  則顯示sub_no
  SqlStr:= ' select Distinct Sub_No from sub_score where exam_no = '+QuotedStr(fmMain.cbExam_No.Text)+
         ' And sub_name = '+QuotedStr((Sender as TComboBox).Text);
  SqlOpen(DM.adoQueryTempEx, SqlStr);
  TComboBox(fmMain.FindComponent('cbSubNo'+RightStr((Sender as TComboBox).Name,2))).Visible:= RepeatSubName(Sender);
  fmMain.lbSub_No.Visible:= fmMain.cbSubNo01.Visible or fmMain.cbSubNo02.Visible;
  if (fmMain.cbExam_No.Text <> '') and (fmMain.cbSub01.Text <> '') and (fmMain.cbSub02.Text <> '') then
  begin
    fmMain.pContentRight.Enabled:= True;
  end
  else
  begin
    fmMain.pContentRight.Enabled:= False;
  end;
  if (Sender as TComboBox).Name = 'cbSub01' then
  begin
    fmMain.cbSub02.SetFocus;
  end
  else if (Sender as TComboBox).Name = 'cbSub02' then
    CheckStrucImport(fmMain.cbExam_No.Text);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmMain do
  begin
    LStudent.Free;
    LSubScore.Free;
    stream.Free;
    streamTitle.Free;
    XMLSave(XMLDocument1, Attribute);
    Attribute.Free;
  end;
end;

procedure TMainForm.RichEditDblClick(Sender: TObject);
begin
  fmMain.RichEdit.ReadOnly:= False;
  fmMain.RichEdit1.ReadOnly:= False;
  fmMain.CheckMem:= (Sender as TButton).Name = 'btRichEdit';
  if fmMain.CheckMem then
  begin
    fmMain.RichEdit.Lines.SaveToStream(fmMain.stream);
    fmMain.RichEdit.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+fmMain.RichEdit.Name+'.txt');
    fmEditor:= TfmEditor.Create(Application);
    fmEditor.Width:= 633;
    fmEditor.Height:= 307;
  end
  else
  begin
    fmMain.RichEdit1.Lines.SaveToStream(fmMain.streamTitle);
    fmMain.RichEdit1.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+fmMain.RichEdit1.Name+'.txt');
    fmEditor:= TfmEditor.Create(Application);
    fmEditor.Width:= 618;
    fmEditor.Height:= 221;
  end;
  fmEditor.ShowModal;
  fmMain.RichEdit.ReadOnly:= True;
  fmMain.RichEdit1.ReadOnly:= True;
end;

procedure TMainForm.SpeedButtonClick(Sender: TObject);
var
  I: Integer;
begin
  if (Sender is TSpeedButton) then
  begin
    if (Sender as TSpeedButton).Tag > 1 then
      Self.Close;
    fmMain.lbMainMenuTitle.Caption:= (Sender as TSpeedButton).Caption;
    fmMain.PageControl1.ActivePageIndex:= (Sender as TSpeedButton).Tag;
    for I := 0 to fmMain.pLeft.ControlCount - 1 do
    begin
      if fmMain.pLeft.Controls[I].Hint= '5' then
      begin
        TSpeedButton(fmMain.pLeft.Controls[I]).Down:= False;
        TSpeedButton(fmMain.pLeft.Controls[I]).Repaint;
      end;
    end;

    (Sender as TSpeedButton).Down:= True;

    if (Sender as TSpeedButton).Tag = 1 then
    begin
      fmMain.pContentRight.Visible:= True;
      Self.Width:= MainWidth;
    end
    else
    begin
      fmMain.pContentRight.Visible:= False;
      Self.Width:= MainWidth - fmMain.pContentRight.Width;
    end;
  end;
end;

procedure TMainForm.btAnswerAnalyClick(Sender: TObject);
var
  Col, Row: Integer;  I, J: Integer;  StrucTotal: Integer;
  StrucNo: string;  Ans: string;
  SLMapping, SCMapping: TStringList;
  RC, TempRC: Double;  StrucCount: Double;  StrucRightRate: Double;
begin
  with fmMain do
  begin
    if cbExam_No.Text = '' then
    begin
      MessageBoxW(Handle, '請選擇考試代碼', '訊息', MB_OK + MB_ICONINFORMATION +
          MB_TOPMOST);
      Exit;
    end;

    SqlStr:= ' SELECT COUNT(*) Cnt FROM Tb_StuStrucInfo'+
             ' WHERE Exam_No='+QuotedStr(cbExam_No.Text);
    SqlOpen(DM.adoQueryTempAnaly, SqlStr);

    if DM.adoQueryTempAnaly.FieldByName('Cnt').AsInteger > 0 then
    begin
      if MessageBoxW(Handle, '這次考試已進行過指標分析，請問是否重新分析', '訊息', MB_OKCANCEL +
          MB_ICONINFORMATION + MB_TOPMOST) = IDCANCEL then
      begin
        Exit;
      end
      else
      begin
        SqlStr:='DELETE FROM Tb_StuStrucInfo WHERE Exam_No='+QuotedStr(cbExam_No.Text);
        SqlExec(DM.adoQueryTempAnaly, SqlStr);
      end;
    end;

    fmStrucAnaly:= TfmStrucAnaly.Create(Application);
    SLMapping:= TStringList.Create;
    SCMapping:= TStringList.Create;
    // get this exam subscore for ReadTable
    SqlStr:=' select student_no, sub_no, ans_status1 from sub_score '+
            ' where exam_no = '+QuotedStr(cbExam_No.Text);
    SqlOpen(DM.adoQueryTempEx, SqlStr);


    Row:=1;
    while NOT DM.adoQueryTempEx.Eof do
    begin
      Col:= 0;
      fmStrucAnaly.ReadTable.Cells[Col, Row]:= Trim(DM.adoQueryTempEx.FieldByName('student_no').AsString);
      Inc(Col);
      fmStrucAnaly.ReadTable.Cells[Col, Row]:= Trim(DM.adoQueryTempEx.FieldByName('sub_no').AsString);
      Inc(Col);
      fmStrucAnaly.ReadTable.Cells[Col, Row]:= Trim(DM.adoQueryTempEx.FieldByName('ans_status1').AsString);
      Inc(Row);
      DM.adoQueryTempEx.Next;
    end;
    fmStrucAnaly.ReadTable.RowCount:= DM.adoQueryTempEx.RecordCount;

    StrucNo:= EmptyStr;  StrucCount:= 0.00;  StrucTotal:= 0;  RC:= 0.00;
    for I := 1 to fmStrucAnaly.ReadTable.RowCount do
    begin
      if fmStrucAnaly.ReadTable.Cells[2, I] = '' then
        Continue;
      SLMapping.Clear;

      SqlStr:=' SELECT Sub_No, Struc_No, SUM(RightRate) as TotalCount FROM Tb_ExamStruc' +
              ' WHERE Sub_No='+QuotedStr(fmStrucAnaly.ReadTable.Cells[1, I])+
              ' And Exam_No = '+QuotedStr(cbExam_No.Text)+
              ' GROUP BY Sub_No, Struc_No';
      SqlOpen(DM.adoQueryTempAnaly, SqlStr);
      while NOT DM.adoQueryTempAnaly.Eof do
      begin
        SLMapping.Add(DM.adoQueryTempAnaly.FieldByName('Struc_No').AsString+'='+
        DM.adoQueryTempAnaly.FieldByName('TotalCount').AsString);
        DM.adoQueryTempAnaly.Next;
      end;

      SCMapping.Clear;
      SqlStr:= ' SELECT Sub_No, Struc_No, COUNT(Ser_No) as TotalCount FROM Tb_ExamStruc' +
               ' WHERE Sub_No='+QuotedStr(fmStrucAnaly.ReadTable.Cells[1, I])+
               ' And Exam_No = '+QuotedStr(cbExam_No.Text)+
               ' GROUP BY Sub_No, Struc_No';
      SqlOpen(DM.adoQueryTempAnaly, SqlStr);
      while NOT DM.adoQueryTempAnaly.Eof do
      begin
        SCMapping.Add(DM.adoQueryTempAnaly.FieldByName('Struc_No').AsString+'='+
        DM.adoQueryTempAnaly.FieldByName('TotalCount').AsString);
        DM.adoQueryTempAnaly.Next;
      end;

      SqlStr:=' SELECT * FROM Tb_ExamStruc '+
              ' WHERE Exam_No = '+QuotedStr(cbExam_No.Text)+
              ' and sub_no = '+QuotedStr(fmStrucAnaly.ReadTable.Cells[1, I])+
              ' order by Struc_no';
      SqlOpen(DM.adoQueryTempAnaly, SqlStr);

      Row:= 1;
      while NOT DM.adoQueryTempAnaly.Eof do
      begin
        Col:= 0;
        fmStrucAnaly.StrucTable.Cells[Col, Row]:= Trim(DM.adoQueryTempAnaly.FieldByName('Sub_no').AsString);
        Inc(Col);
        fmStrucAnaly.StrucTable.Cells[Col, Row]:= Trim(DM.adoQueryTempAnaly.FieldByName('Ser_no').AsString);
        Inc(Col);
        fmStrucAnaly.StrucTable.Cells[Col, Row]:= Trim(DM.adoQueryTempAnaly.FieldByName('Struc_no').AsString);
        Inc(Col);
        fmStrucAnaly.StrucTable.Cells[Col, Row]:= Trim(DM.adoQueryTempAnaly.FieldByName('RightRate').AsString);
        Inc(Row);
        DM.adoQueryTempAnaly.Next;
      end;
      fmStrucAnaly.StrucTable.RowCount:= DM.adoQueryTempAnaly.RecordCount;

      if DM.adoQueryTempAnaly.IsEmpty then
        Continue;

      for J := 1 to fmStrucAnaly.StrucTable.RowCount do
      begin
        Ans:= Copy(fmStrucAnaly.ReadTable.Cells[2, I], StrToInt(fmStrucAnaly.StrucTable.Cells[1, J]), 1);

        if Trim(fmStrucAnaly.StrucTable.Cells[2, J]) <> StrucNo then
        begin
          StrucNo:= Trim(fmStrucAnaly.StrucTable.Cells[2, J]);
  //        StrucCount:= StrToFloat(Trim(SLMapping.Values[StrucNo]));
          StrucTotal:= StrToInt(Trim(SCMapping.Values[StrucNo]));
          RC:= 0.00;
          StrucRightRate:= 0.00;
        end;

        if Ans = 'X' then
        begin
          StrucTotal:= StrucTotal - 1;
        end
        else
        begin
          if TryStrToFloat(fmStrucAnaly.StrucTable.Cells[3, J], TempRC) then
            RC:= RC + StrToFloat(fmStrucAnaly.StrucTable.Cells[3, J]);
          StrucTotal:= StrucTotal - 1;
        end;

        if StrucTotal = 0 then
        begin
          if TryStrToFloat(Trim(SLMapping.Values[StrucNo]), TempRC) then
            if StrToFloat(Trim(SLMapping.Values[StrucNo])) <> 0.00 then
            begin
              StrucCount:= StrToFloat(Trim(SLMapping.Values[StrucNo]));
              StrucRightRate:= RC / StrucCount;
              SqlStr:='INSERT INTO Tb_StuStrucInfo(Exam_No, Sub_No, Student_No, Struc_No, RightRate)' +
                      'Values(' +
                      QuotedStr(cbExam_No.Text)+', '+
                      QuotedStr(Trim(fmStrucAnaly.StrucTable.Cells[0 ,J]))+', '+
                      QuotedStr(Trim(fmStrucAnaly.ReadTable.Cells[0, I]))+', '+
                      QuotedStr(Trim(StrucNo))+', '+
                      FormatFloat('#0.00', StrucRightRate)+
                      ')';
              SqlExec(DM.adoQueryTempAnaly, SqlStr);
            end;
        end;
      end;
    end;
    MessageBoxW(Handle, '指標分析完畢', '訊息', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    SCMapping.Free;
    SLMapping.Free;
    btPrintClick(nil);
  end;
end;

procedure TMainForm.btImportGradeClick(Sender: TObject);
begin
  if NOT (fmMain.cbExam_No.Text <> '') then
  begin
    MessageBoxW(Handle, '請選擇考試代碼', '訊息', MB_OK + MB_ICONINFORMATION +
        MB_TOPMOST);
    Exit;
  end;
  fmImportGrade:= TfmImportGrade.Create(Application);
  fmImportGrade.Show;
end;

procedure TMainForm.btImportGradeNameClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  xlsFileName: string;
  LInsertSqlList: TStringList;
  Test: Int64;
begin
  SqlStr:= 'SELECT * FROM Tb_Struc';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);

  if NOT DM.adoQueryTempAnaly.IsEmpty then
  begin
    if MessageBoxW(Handle, '指標名稱已經存在，是否覆蓋', '訊息', MB_OKCANCEL +
        MB_ICONINFORMATION + MB_TOPMOST) = IDCANCEL then
    begin
        Exit;
    end
    else
    begin
      SqlStr:= 'DELETE FROM Tb_Struc';
      SqlExec(DM.adoQueryTempAnaly, SqlStr);
    end;
  end;

  LInsertSqlList:= TStringList.Create;
  OpenDialog:= TOpenDialog.Create(nil);
  OpenDialog.DefaultExt:= '*.csv';
  OpenDialog.InitialDir:= ExtractFilePath(Application.ExeName);
  OpenDialog.Filter:='Excel(*.xls)|*.xls;Text(*.csv)|*.csv;Text(*.txt)|*.txt';
  OpenDialog.FileName:=EmptyStr;
  OpenDialog.Title:='請選擇所要匯入的檔案:';

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

    LInsertSqlList.Clear;
    while NOT DM.adods.Eof do
    begin
      if NOT TryStrToInt64(Trim(DM.adods.FieldByName('F1').AsString), Test) then
      begin
        DM.adods.Next;
        Continue;
      end;

      SqlStr:= 'INSERT INTO Tb_Struc (Sub_No, Struc_No, Struc_Name) '+
               'Values(' +
               QuotedStr(GetZeroString(StrToInt(
                     Trim(DM.adods.FieldByName('F1').AsString)),2))+', '+
               QuotedStr(Trim(DM.adods.FieldByName('F2').AsString))+', '+
               QuotedStr(Trim(DM.adods.FieldByName('F3').AsString))+
               ')';

      LInsertSqlList.Add(SqlStr);
      DM.adods.Next;
    end;

    try
      SqlExec(DM.adoQueryTempAnaly, LInsertSqlList.Text);
    except
      MessageBoxW(Handle, '匯入失敗', '訊息', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      DM.conn.Close;
      DM.adods.Close;
      LInsertSqlList.Free;
      Exit;
    end;
    MessageBoxW(Handle, '匯入成功', '訊息', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    DM.conn.Close;
    DM.adods.Close;
    LInsertSqlList.Free;
    CheckStrucName;
  end;
end;

procedure TMainForm.btInputAwardsClick(Sender: TObject);
var
  LInsertSqlList: TStringList;
  OpenDialog: TOpenDialog;
  xlsFileName: string;
  Test: Int64;
begin
  SqlStr:= 'SELECT * FROM StudentAward';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);

  if NOT DM.adoQueryTempAnaly.IsEmpty then
  begin
    if MessageBoxW(Handle, '獎項名稱已匯入，是否覆蓋', '訊息', MB_OKCANCEL +
        MB_ICONINFORMATION + MB_TOPMOST) = IDCANCEL then
    begin
        Exit;
    end
    else
    begin
      SqlStr:= 'DELETE FROM StudentAward';
      SqlExec(DM.adoQueryTempAnaly, SqlStr);
      CheckAwardsImport(fmMain.cbExam_No.Text);
    end;
  end;

  LInsertSqlList:= TStringList.Create;
  OpenDialog:= TOpenDialog.Create(nil);
  OpenDialog.DefaultExt:= '*.csv';
  OpenDialog.InitialDir:= ExtractFilePath(Application.ExeName);
  OpenDialog.Filter:='Excel(*.xls)|*.xls;Text(*.csv)|*.csv;Text(*.txt)|*.txt';
  OpenDialog.FileName:=EmptyStr;
  OpenDialog.Title:='請選擇所要匯入的檔案:';

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

    LInsertSqlList.Clear;

    while NOT DM.adods.Eof do
    begin
      if NOT TryStrToInt64(Trim(DM.adods.FieldByName('F1').AsString), Test) then
      begin
        DM.adods.Next;
        Continue;
      end;

      SqlStr:='INSERT INTO StudentAward(Student_No, Awards)' +
              'Values(' +
              QuotedStr(Trim(DM.adods.FieldByName('F1').AsString))+', '+  // student_no
              QuotedStr(Trim(DM.adods.FieldByName('F2').AsString))+       // awards
              ')';
      LInsertSqlList.Add(SqlStr);
      DM.adods.Next;
    end;

    try
      SqlExec(DM.adoQueryTempAnaly, LInsertSqlList.Text);
    except
      MessageBoxW(Handle, '匯入失敗', '訊息', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      DM.adods.Close;
      DM.conn.Close;
      LInsertSqlList.Free;
      Exit;
    end;
    MessageBoxW(Handle,
        '匯入成功',
        '訊息',
        MB_OK
        +
        MB_ICONINFORMATION
        +
        MB_TOPMOST);
    DM.adods.Close;
    DM.conn.Close;
    CheckAwardsImport(fmMain.cbExam_No.Text);
    LInsertSqlList.Free;
  end;
end;

procedure TMainForm.btOpenFileClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  with fmMain do
  begin
    OpenDialog:= TOpenDialog.Create(nil);
    OpenDialog.DefaultExt:= '*.jpg';
    OpenDialog.InitialDir:= ExtractFilePath(Application.ExeName);
    OpenDialog.Filter:='JEPG(*.jpg)|*.jpg;|Bitmap(*.bmp)|*.bmp;';
    OpenDialog.FileName:=EmptyStr;
    OpenDialog.Title:='請選擇要顯示標題圖片的檔案:';
    if OpenDialog.Execute then
    begin
      edImagePath.Text:= ExtractFileName(OpenDialog.FileName);
      LoadTitleImage:= ExtractFilePath(OpenDialog.FileName)+ExtractFileName(OpenDialog.FileName);
      Attribute.Values['ImagePath']:= LoadTitleImage;
    end;
  end;
end;

procedure TMainForm.btPrintClick(Sender: TObject);
var
  I, J: Integer;
  hh, jj, kk, ll: Integer;
  LStrucInfo: TStringList;
begin
  with  fmMain  do
  begin
    if cbSub01.Text = '' then
    begin
      MessageBoxW(Handle, '請選擇科目', '訊息', MB_OK + MB_ICONINFORMATION +
          MB_TOPMOST);
      Exit;
    end;

    if cbSubNo01.Text = cbSubNo02.Text then
    begin
      MessageBoxW(Handle, '一、二節科目相同', '訊息', MB_OK + MB_ICONINFORMATION +
          MB_TOPMOST);
      Exit;
    end;
    LStrucInfo:= TStringList.Create;
    fmReport:= TfmReport.Create(Application);

    if (cbSub01.Text <> '') and (cbSub02.Text <> '') then
      SqlStr:=
      'select A.student_no as student_no,'+
      ' A.right_count as sub01right_count, A.sub_no as sub01no, A.sub_name as sub01name, A.sum_sub as sub01score, A.ans_status2 as sub01ansstatus'+
      ', B.right_count as sub02right_count, B.sub_no as sub02no, B.sub_name as sub02name, B.sum_sub as sub02score, B.ans_status2 as sub02ansstatus'+
      ' FROM (select student_no, right_count, sub_no, sub_name, sum_sub, ans_status2 from sub_score where exam_no='+QuotedStr(cbExam_No.Text)
    else
    begin
      MessageBoxW(Handle, '請選擇ㄧ、二節考試科目', '訊息', MB_OK + MB_ICONINFORMATION +
          MB_TOPMOST);
      Exit;
    end;
    if lbSub_No.Visible then
    begin
      if cbSubNo01.Text <> '' then
        SqlStr:= SqlStr +
        ' And sub_no = '+QuotedStr(cbSubNo01.Text)+' And sub_name='+QuotedStr(cbSub01.Text)+' ) A,'+
        ' (select student_no, right_count, sub_no, sub_name, sum_sub, ans_status2 from sub_score where exam_no='+QuotedStr(cbExam_No.Text)
      else
        SqlStr:= SqlStr +
              ' And sub_name='+QuotedStr(cbSub01.Text)+' ) A,'+
              ' (select student_no, right_count, sub_no, sub_name, sum_sub, ans_status2 from sub_score where exam_no='+QuotedStr(cbExam_No.Text);
      if cbSubNo02.Text <> '' then
        SqlStr:= SqlStr +
        ' And sub_no = '+QuotedStr(cbSubNo02.Text)+' And sub_name='+QuotedStr(cbSub02.Text)+') B'+
        ' where A.student_no=B.student_no order by a.student_no'
      else
        SqlStr:= SqlStr +
        ' And sub_name='+QuotedStr(cbSub02.Text)+' ) B'+
        ' where A.student_no=B.student_no order by a.student_no';
    end
    else
    begin
      SqlStr:= SqlStr+
      ' And sub_name='+QuotedStr(cbSub01.Text)+' ) A,'+
      ' (select student_no, right_count, sub_no, sub_name, sum_sub, ans_status2 from sub_score where exam_no='+QuotedStr(cbExam_No.Text)+
      ' And sub_name='+QuotedStr(cbSub02.Text)+' ) B'+
      ' where A.student_no=B.student_no order by a.student_no';
    end;

    SqlOpen(DM.adoQueryTempEx, SqlStr);
    LSubScore.Clear;

    if DM.adoQueryTempEx.IsEmpty then
    begin
      Application.MessageBox('請確認批改資料是否有誤', '訊息', MB_OK + MB_ICONWARNING);
      Exit;
    end;

    DM.adoQueryTempEx.First;
    while NOT DM.adoQueryTempEx.Eof do
    begin
      LSubScore.Add(Sub_Score.Create(
      DM.adoQueryTempEx.FieldByName('Student_No').AsString,
      DM.adoQueryTempEx.FieldByName('sub01right_count').AsString,
      DM.adoQueryTempEx.FieldByName('sub01no').AsString,
      DM.adoQueryTempEx.FieldByName('sub01name').AsString,
      DM.adoQueryTempEx.FieldByName('sub01score').AsString,
      DM.adoQueryTempEx.FieldByName('sub01ansstatus').AsString,
      DM.adoQueryTempEx.FieldByName('sub02right_count').AsString,
      DM.adoQueryTempEx.FieldByName('sub02no').AsString,
      DM.adoQueryTempEx.FieldByName('sub02name').AsString,
      DM.adoQueryTempEx.FieldByName('sub02score').AsString,
      DM.adoQueryTempEx.FieldByName('sub02ansstatus').AsString
      ));
      DM.adoQueryTempEx.Next;
    end;
    LStudentDetail.Clear;
    for I := 0 to LStudent.Count - 1 do
    begin
      for J := 0 to LSubScore.Count - 1 do
      begin
        if Student(LStudent[I]).Student_No = Sub_Score(LSubScore[J]).Student_No then
        begin
          LStudentDetail.Add(StudentDetail.Create(
          Student(LStudent[I]).Student_No,
          Student(LStudent[I]).Student_Name,
          Student(LStudent[I]).Sch_Name,
          Student(LStudent[I]).Grade,
          Student(LStudent[I]).Class_No,
          Sub_Score(LSubScore[J]).Sub01_Name,
          Sub_Score(LSubScore[J]).Sub02_Name,
          Sub_Score(LSubScore[J]).Sub01_Sum_Sub,
          Sub_Score(LSubScore[J]).Sub02_Sum_Sub,
          Sub_Score(LSubScore[J]).Sub01Right_Count,
          Sub_Score(LSubScore[J]).Sub02Right_Count,
          FloatToStr(StrToFloat(Sub_Score(LSubScore[J]).Sub01_Sum_Sub)+
          StrToFloat(Sub_Score(LSubScore[J]).Sub02_Sum_Sub)),
          FloatToStr(Floor((StrToFloat(Sub_Score(LSubScore[J]).Sub01_Sum_Sub)+
          StrToFloat(Sub_Score(LSubScore[J]).Sub02_Sum_Sub)) / 2)),
          EmptyStr,
          Sub_Score(LSubScore[J]).Sub01_Status2,
          Sub_Score(LSubScore[J]).Sub02_Status2,
          Student(LStudent[I]).Group_No
          ));
        end;
      end;
    end;

    SqlStr:=' Delete RankSumScore ';
    SqlExec(DM.adoQueryTempAnaly, SqlStr);

    for I := 0 to LStudentDetail.Count - 1 do
    begin
      SqlStr:= 'Insert Into RankSumScore (Student_No, Grade, SumScore) '+
               'Values ('+QuotedStr(StudentDetail(LStudentDetail[I]).Student_No)+','+
               QuotedStr(StudentDetail(LStudentDetail[I]).Group_No)+','+
               StudentDetail(LStudentDetail[I]).SumSub+
               ' ) ';
      SqlExec(DM.adoQueryTempAnaly, SqlStr);
    end;

    hh:= -1; ll:= -1;
    for I := 1 to 2 do
    begin
      if I=1 then
        begin
           hh:= fmReport.QRLabel19.Top;
           ll:= fmReport.QRLabel20.Top;
        end
      else
        begin
           hh:=hh+76;
           ll:=ll+71;
        end;
      jj:=0;
      for kk := 0 to 8 do
        begin
  //         if kk>=2 then inc(jj);
           if I = 1 then
           begin
             fmReport.CreateQRLabel_2((kk*115)+fmReport.QRLabel24.Left+(jj*2), ll, 150, 16, 'QRDT_1'+Sub_Score(LSubScore[0]).Sub01_No+IntToStr(KK), ' ');
             fmReport.CreateQRLabel_2((kk*115)+fmReport.QRLabel24.Left+(jj*2), hh, 150, 16, 'QRDT_2'+Sub_Score(LSubScore[0]).Sub01_No+IntToStr(KK), ' ');
           end
           else
           begin
             fmReport.CreateQRLabel_2((kk*115)+fmReport.QRLabel24.Left+(jj*2), ll, 150, 16, 'QRDT_1'+Sub_Score(LSubScore[0]).Sub02_No+IntToStr(KK), ' ');
             fmReport.CreateQRLabel_2((kk*115)+fmReport.QRLabel24.Left+(jj*2), hh, 150, 16, 'QRDT_2'+Sub_Score(LSubScore[0]).Sub02_No+IntToStr(KK), ' ');
           end;
        end;
    end;

    try
      stream.Seek(0, soFromBeginning);
      fmReport.qrRichText.Lines.LoadFromStream(stream);
      if FileExists(fmMain.sPath+fmMain.RichEdit.Name+'.txt') then
        fmReport.qrRichText.Lines.LoadFromFile(fmMain.sPath+fmMain.RichEdit.Name+'.txt');
      streamTitle.Seek(0, soFromBeginning);
      fmReport.QRRichText1.Lines.LoadFromStream(streamTitle);
      if FileExists(fmMain.sPath+fmMain.RichEdit1.Name+'.txt') then
        fmReport.QRRichText1.Lines.LoadFromFile(fmMain.sPath+fmMain.RichEdit1.Name+'.txt');

      fmReport.QuickRep1.Preview;
    finally
      fmReport.Free;
      LStrucInfo.Free;
    end;
  end;
end;

procedure TMainForm.cbExam_NoChange(Sender: TObject);
var
  Sub_No: string;
begin
  SqlStr:= 'select Distinct Sub_No, Sub_Name from sub_score where '+
           ' Exam_No='+QuotedStr((Sender as TComboBox).Text)+
           ' order by sub_name';
  SqlOpen(DM.adoQueryTempEx, SqlStr);
  fmMain.cbSub01.Clear;
  fmMain.cbSub02.Clear;
  Sub_No:= EmptyStr;
  while NOT DM.adoQueryTempEx.Eof do
  begin
    if Sub_No <> Trim(DM.adoQueryTempEx.FieldByName('Sub_Name').AsString) then
    begin
      Sub_No:= Trim(DM.adoQueryTempEx.FieldByName('Sub_Name').AsString);
      fmMain.cbSub01.AddItem(DM.adoQueryTempEx.FieldByName('Sub_Name').AsString, nil);
      fmMain.cbSub02.AddItem(DM.adoQueryTempEx.FieldByName('Sub_Name').AsString, nil);
    end;
    DM.adoQueryTempEx.Next;
  end;
  CheckAwardsImport(fmMain.cbExam_No.Text);
  CheckStrucName;

  fmMain.lbGrade.Caption:= Copy(fmMain.cbExam_No.Text,6,1)+' 年級組設定';
  if (fmMain.cbExam_No.Text <> '') and (fmMain.cbSub01.Text <> '') and (fmMain.cbSub02.Text <> '') then
  begin
    fmMain.btInputAwards.Enabled:= True;
    fmMain.btImportGradeName.Enabled:= True;
    fmMain.btPrint.Enabled:= True;
    fmMain.btAnswerAnaly.Enabled:= True;
    fmMain.btImportGrade.Enabled:= True;
  end;
  fmMain.cbSub01.SetFocus;
end;

end.
