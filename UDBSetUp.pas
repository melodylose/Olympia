unit UDBSetUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComObj, ADODB, iniFiles, ComCtrls, Spin;

type
  TfmDBSetUp = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    edtUser: TEdit;
    edtPW: TEdit;
    btnOK: TBitBtn;
    btnExit: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    cmbTNo: TComboBox;
    seYear: TSpinEdit;
    Button1: TButton;
    pChooses: TPanel;
    pSetting: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure GetSysPara();  //取得系統參數
    Function TableExists(TableName : String):Boolean;  //檢查 Table 是否存在
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDBSetUp: TfmDBSetUp;

implementation

uses UMain, StrUtils, UDM, UGlobal, UModel;

{$R *.dfm}

procedure TfmDBSetUp.btnExitClick(Sender: TObject);
begin
//  fmMain.nLogin.Tag := 1;
  Application.Terminate;
//  Release;
end;

procedure TfmDBSetUp.btnOKClick(Sender: TObject);
Var
  sFile1, sFile2, Str_temp : String;
begin

  if (fmDBSetUp.Caption = '登入資料庫') then
  begin

//    if Trim(edtUser.Text)<>'' then
//    begin
//      if (fmMain.sUser <> Trim(edtUser.Text))     //檢查帳號
//      or (fmMain.sPW   <> Trim(edtPW.Text)) then  //檢查密碼
//       begin
//       showmessage('您輸入使用者帳號與密碼不符');
//       Exit;
//       end
//      else
//       begin
//       fmMain.StatusBar1.Panels[1].Text := Trim(edtUser.Text)+' 登入';
//       //fmMain.sUser := Trim(edtUser.Text);
//       end;
//    end
//    else
//    begin
//     showmessage('您尚未輸入使用者帳號/密碼');
//     Exit;
//    end;

    if (Trim(seYear.Text)<>'') and (Trim(cmbTNo.Text)<>'') then
    begin
      fmMain.sTYear := Trim(seYear.Text);   //學年
      fmMain.sTerm := Trim(cmbTNo.Text);  //學期 1：上學期、2：下學期
    end
    else
    begin
      showmessage('請選擇學年/學期');
      Exit;
    end;

    //目錄不在新增目錄
    if Not DirectoryExists(fmMain.sPath+edtUser.Text+'_Data') then
        ForceDirectories(fmMain.sPath+edtUser.Text+'_Data') ;
    //學校資料
    sFile1 := fmMain.sPath+edtUser.Text+'_Data'
              +'\Sch'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';
    //考試資料
    sFile2 := fmMain.sPath+edtUser.Text+'_Data'
              +'\Ex'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';

    if Not (FileExists(PChar(sFile1))) then //找不到 學校基本檔
    begin
      if application.Messagebox('您選擇的學校資料庫不存在，是否幫您建立？','資料庫不存在',MB_YesNo)= IDYES then
        CopyFile(PChar(fmMain.sPath+'_Data\Sch.mdb'),PChar(sFile1),False)  //複製學校空白資料庫
      else
        Exit;

    end;

    if Not (FileExists(PChar(sFile2))) then //找不到 考試檔
    begin
      if application.Messagebox('您選擇的考試資料庫不存在，是否幫您建立？','資料庫不存在',MB_YesNo)= IDYES then
        CopyFile(PChar(fmMain.sPath+'_Data\Ex.mdb'),PChar(sFile2),False)  //複製考試空白資料庫
      else
        Exit;
    end;



//    fmMain.nU101.Enabled := True;
//    fmMain.nU102.Enabled := True;
//    fmMain.nU103.Enabled := True;
//    fmMain.nU104.Enabled := True;
//    fmMain.nU105.Enabled := True;
//    fmMain.nU106.Enabled := True;
//    fmMain.nU107.Enabled := True;
//    fmMain.nU109.Enabled := True;
//    fmMain.NU110.Enabled := True;
//    fmMain.nU206.Enabled := True;
//    fmMain.N1.Enabled := True;
//    fmMain.N2.Enabled := True;
//    fmMain.N3.Enabled := True;
//    fmMain.N4.Enabled := True;
//    fmMain.nU503.Enabled := True;
//    fmMain.nU505.Enabled := True;
//    fmMain.nLogin.Enabled := True;
//
    //add by purea 2012-05-14
//    if Trim(fmMain.ItemOn) <> '' then
//    begin
//     fmMain.nU201.Visible := True;
//     fmMain.nU202.Visible := True;
//     fmMain.nU203.Visible := True;
//     fmMain.nU204.Visible := True;
//     fmMain.nU301.Visible := True;
//     fmMain.nU302.Visible := True;
//     fmMain.nU303.Visible := True;
//     fmMain.nU503.Visible := True;
//     fmMain.nDBSetup.Visible := True;
//    end;


    Str_temp:='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source= $StrChange;'
              +'Mode=Share Deny None;Extended Properties="";Persist Security Info=False;Jet OLEDB:System database="";'
              +'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;'
              +'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";'
              +'Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;'
              +'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';

    try
        With DM.adoConnectforSys Do  //System
        begin
          Connected := False;
          ConnectionString:= StringReplace(Str_temp,'$StrChange',fmMain.sPath+'Sys.mdb',[rfReplaceAll]);
          Connected := True;
          //取得系統參數   add by JC 2011.4.24
          GetSysPara();
        end;
        With DM.adoConnectforSch Do  //School
        begin
          Connected := False;
          ConnectionString:= StringReplace(Str_temp,'$StrChange',sFile1,[rfReplaceAll]);
          Connected := True;
        end;
        With DM.adoConnectforEx Do  //Exam
        begin
          Connected := False;
          ConnectionString:= StringReplace(Str_temp,'$StrChange',sFile2,[rfReplaceAll]);
          Connected := True;
        end;
    finally
      SaveINI(fmMain.sPath, 'U', Trim(seYear.Text), Trim(cmbTNo.Text), Trim(edtUser.Text), Trim(edtPW.Text), EmptyStr);
//      InitLSysClass(DM.qryTempSys2);
//      InitLSysGroup(DM.qryTempSys2);
//      InitLSysSubject(DM.qryTempSys2);

      SqlStr:= 'Select * from Term_Student';
      SqlOpen(DM.adoQueryTempSch, SqlStr);
      try
        while NOT DM.adoQueryTempSch.Eof do
        begin
          fmMain.LStudent.Add(Student.Create(
          DM.adoQueryTempSch.FieldByName('Student_No').AsString,
          EmptyStr,
          DM.adoQueryTempSch.FieldByName('College_No').AsString,
          DM.adoQueryTempSch.FieldByName('College_Name').AsString,
          Copy(Trim(DM.adoQueryTempSch.FieldByName('Remark').AsString),1,1),
          Copy(Trim(DM.adoQueryTempSch.FieldByName('Remark').AsString),2,
          Length(Trim(DM.adoQueryTempSch.FieldByName('Remark').AsString))-2),
          DM.adoQueryTempSch.FieldByName('Seat_No').AsString,
          DM.adoQueryTempSch.FieldByName('Student_Name').AsString,
          DM.adoQueryTempSch.FieldByName('Group_No').AsString,
          DM.adoQueryTempSch.FieldByName('Remark').AsString
          ));
          DM.adoQueryTempSch.Next;
        end;
      Except

      end;

      fmMain.cbExam_No.Clear;
      SqlStr:= 'SELECT Distinct Exam_No From Sub_Score';
      SqlOpen(DM.adoQueryTempEx, SqlStr);
      try
        while NOT DM.adoQueryTempEx.Eof do
        begin
          fmMain.cbExam_No.Items.Add(DM.adoQueryTempEx.FieldByName('Exam_No').AsString);
          DM.adoQueryTempEx.Next;
        end;
      finally

      end;
      fmMain.cbSub01.Clear;
      fmMain.cbSub02.Clear;
      fmMain.cbSubNo01.Clear;
      fmMain.cbSubNo02.Clear;
    end;  //try

  end  //if (fmDBSetUp.Caption = '登入資料庫')
  else if fmDBSetUp.Caption = '初始化資料庫' then
  begin
    //
    case RadioGroup1.ItemIndex of
      0:Begin
//        fmMain.StatusBar1.Panels[0].Text := '國中';
//        fmMain.sDepart := 'J';
      End;
      1:Begin
//        fmMain.StatusBar1.Panels[0].Text := '高中';
//        fmMain.sDepart := 'S';
      End;
      2:Begin
//        fmMain.StatusBar1.Panels[0].Text := '高職';
//        fmMain.sDepart := 'V';
      End;
      3:Begin
//        fmMain.StatusBar1.Panels[0].Text := '大學';
//        fmMain.sDepart := 'U';
      End;
    end; //case RadioGroup1.ItemIndex of


    if (Trim(edtUser.Text)='') then
    begin
      showmessage('您尚未設定使用者帳號');
      edtUser.SetFocus;
      Exit;
    end
    else
      fmMain.sUser := Trim(edtUser.Text);

    if Trim(seYear.Text)='' then
    begin
      showmessage('請輸入/選擇初始化的學年');
      seYear.SetFocus;
      Exit;
    end
    else
      fmMain.sTYear := Trim(seYear.Text);

    if Trim(cmbTNo.Text)='' then
    begin
      showmessage('請輸入/選擇初始化的學期');
      cmbTNo.SetFocus;
      Exit;
    end
    else
    fmMain.sTerm := Trim(cmbTNo.Text);

    if (Trim(edtPW.Text)='') then
    begin
//      if application.Messagebox('您確定不設定密碼嗎？','密碼尚未設定',MB_YesNo)= IDYES then
//         fmMain.sPW := Trim(edtPW.Text)
//      else
//       begin
//         ShowMessage('請輸入設定密碼');
//         Exit;
//       end;
    end;

    try
     try
     if Not DirectoryExists(fmMain.sPath+edtUser.Text+'_Data') then //檢查有無此目錄
      ForceDirectories(fmMain.sPath+edtUser.Text+'_Data'); //新增目錄

      sFile1 := fmMain.sPath+edtUser.Text+'_Data'
                +'\Sch'+'U'+fmMain.sTYear+Copy(fmMain.sTerm,1,1)+'.mdb';
      sFile2 := fmMain.sPath+edtUser.Text+'_Data'
                +'\Ex'+'U'+fmMain.sTYear+Copy(fmMain.sTerm,1,1)+'.mdb';

      CopyFile(PChar(fmMain.sPath+'_Data\Sys.mdb'),PChar(fmMain.sPath+'Sys.mdb'),False);
      CopyFile(PChar(fmMain.sPath+'_Data\Sch.mdb'),PChar(sFile1),False);  //轉換路徑要先用 PChar() 這個函數
      CopyFile(PChar(fmMain.sPath+'_Data\Ex.mdb'),PChar(sFile2),False);
      showmessage('初始化成功！'); //請您到系統設定中的「資料庫設定」登入！
     except
      showmessage('初始化失敗，請檢查'+#13#10+fmMain.sPath+'_Data\ '+'資料夾是否存在！');
     end;

    finally
     fmDBSetUp.Caption := '登入資料庫';
//     SaveINI(fmMain.sPath, fmMain.sDepart, Trim(seYear.Text), Trim(cmbTNo.Text), Trim(edtUser.Text), Trim(edtPW.Text), fmMain.sName);
     btnOK.OnClick(self);
    end;

  end;  //else if fmDBSetUp.Caption = '初始化資料庫'
 // SaveINI(fmMain.sPath, fmMain.sDepart, Trim(seYear.Text), Trim(cmbTNo.Text), Trim(edtUser.Text), Trim(edtPW.Text));
//  fmMain.nLogin.Tag := 10;
  Close;
end;

procedure TfmDBSetUp.Button1Click(Sender: TObject);
var
  sFile1, sFile2, Str_temp, SQLStr, vsDepart : String;
begin
  // add by ken 20120927 資料庫更新位置更換(完成)
  case RadioGroup1.ItemIndex of
    0:Begin
      vsDepart := 'J';
    End;
    1:Begin
      vsDepart := 'S';
    End;
    2:Begin
      vsDepart := 'V';
    End;
    3:Begin
      vsDepart := 'U';
    End;
  end; //case RadioGroup1.ItemIndex of

  //目錄不在新增目錄
  if Not DirectoryExists(fmMain.sPath+edtUser.Text+'_Data') then
      ForceDirectories(fmMain.sPath+edtUser.Text+'_Data') ;
  //學校資料
  sFile1 := fmMain.sPath+edtUser.Text+'_Data'
            +'\Sch'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';
  //考試資料
  sFile2 := fmMain.sPath+edtUser.Text+'_Data'
            +'\Ex'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';

  if Not (FileExists(PChar(sFile1))) then //找不到 學校基本檔
  begin
    if application.Messagebox('您選擇的學校資料庫不存在，是否幫您建立？','資料庫不存在',MB_YesNo)= IDYES then
      CopyFile(PChar(fmMain.sPath+'_Data\Sch.mdb'),PChar(sFile1),False)  //複製學校空白資料庫
    else
      Exit;

  end;

  if Not (FileExists(PChar(sFile2))) then //找不到 考試檔
  begin
    if application.Messagebox('您選擇的考試資料庫不存在，是否幫您建立？','資料庫不存在',MB_YesNo)= IDYES then
      CopyFile(PChar(fmMain.sPath+'_Data\Ex.mdb'),PChar(sFile2),False)  //複製考試空白資料庫
    else
      Exit;
  end;

  Str_temp:='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source= $StrChange;'
              +'Mode=Share Deny None;Extended Properties="";Persist Security Info=False;Jet OLEDB:System database="";'
              +'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;'
              +'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";'
              +'Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;'
              +'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';

  try
    With DM.adoConnectforSys Do  //System
    begin
      Connected := False;
      ConnectionString:= StringReplace(Str_temp,'$StrChange',fmMain.sPath+'Sys.mdb',[rfReplaceAll]);
      Connected := True;
      //取得系統參數   add by JC 2011.4.24
      GetSysPara();
    end;
    With DM.adoConnectforSch Do  //School
    begin
      Connected := False;
      ConnectionString:= StringReplace(Str_temp,'$StrChange',sFile1,[rfReplaceAll]);
      Connected := True;
    end;
    With DM.adoConnectforEx Do  //Exam
    begin
      Connected := False;
      ConnectionString:= StringReplace(Str_temp,'$StrChange',sFile2,[rfReplaceAll]);
      Connected := True;
    end;
  finally
//    try  // add by ken 20120828 Start 資料庫更新
//      // add by ken 20120829 Exam_Data欄位更新
//      SQLStr :='ALTER TABLE Exam_Data ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Data ALTER Class_NoS varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Data ALTER Class_NoE varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Class欄位更新
//      SQLStr :='ALTER TABLE Exam_Class ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Class ALTER Class_No varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Group欄位更新
//      SQLStr :='ALTER TABLE Exam_Group ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Qtype欄位更新
//      SQLStr :='ALTER TABLE Exam_Qtype ALTER QT_Type varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Qtype ALTER QT_Remark varchar (50) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Question欄位更新
//      SQLStr :='ALTER TABLE Exam_Question ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Question ALTER Ans_Special varchar (20) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='SELECT * FROM Exam_Question WHERE 1<>1';  // 新增欄位
//      OpenSQL(DM.qryTempEx, SQLStr);
//      if DM.qryTempEx.FindField('Sub_Sno')=nil then
//      begin
//        SQLStr :='ALTER TABLE exam_question ADD Sub_Sno varchar (2)  ';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//      // add by ken 201200829 Exam_Range欄位更新
//      SQLStr :='ALTER TABLE Exam_Range ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Range ALTER R_Count varchar (6) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Range_Sub欄位更新
//      SQLStr :='ALTER TABLE Exam_Range_Sub ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Sub欄位更新
//      SQLStr :='ALTER TABLE Exam_Sub ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Sub ALTER Sub_No varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Group_Range欄位更新
//      SQLStr :='ALTER TABLE Group_Range ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Student_Score欄位更新
//      SQLStr :='ALTER TABLE Student_Score ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Class_No varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_School varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_Grade varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_Class varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_Group1 varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_Group2 varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_Group3 varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_Group4 varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Student_Score ALTER Arrange_Group5 varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Sub_Analysis欄位更新
//      SQLStr :='ALTER TABLE Sub_Analysis ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='SELECT * FROM Sub_Analysis WHERE 1<>1';  // 新增欄位
//      OpenSQL(DM.qryTempEx, SQLStr);
//      if DM.qryTempEx.FindField('Sub_Sno')=nil then
//      begin
//        SQLStr :='ALTER TABLE Sub_Analysis ADD Sub_Sno varchar (2)  ';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//      // add by ken 20120829 Sub_Score欄位更新
//      SQLStr :='ALTER TABLE Sub_Score ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Sub_Score ALTER Class_No varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Sub_Score ALTER Score_People varchar (6) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//
//      SQLStr :='SELECT * FROM Sub_Score WHERE 1<>1';  // 新增欄位
//      OpenSQL(DM.qryTempEx, SQLStr);
//      if DM.qryTempEx.FindField('Arrange_School')=nil then
//      begin
//        SQLStr :='ALTER TABLE Sub_Score ADD '+
//                 'Arrange_School varchar (5), '+
//                 'Arrange_Grade varchar  (4), '+
//                 'Arrange_Class varchar  (4)  ';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//      // add by ken 20120829 TScore_Mix欄位更新
//      SQLStr :='ALTER TABLE TScore_Mix ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//
//      // add by ken 20120829 Exam_Score_people檢查資料表是否存在
//      if not TableExists('Exam_Score_people') then
//      begin
//        SQLStr := 'CREATE TABLE [Exam_Score_people]'
//                + '       ([Exam_No]      varchar (8)  NOT NULL,'
//                + '        [Sub_No]       varchar (4)  NOT NULL,'
//                +'         [Student_No]   varchar (15) NOT NULL,'
//                + '        [Grade]        varchar (1)  NULL,'
//                + '        [Class_No]     varchar (5)  NULL,'
//                + '        [Seat_No]      varchar (5)  NULL,'
//                + '        [Score_People] varchar (8)  NULL)';
//        SQLExec(DM.qryTempEx, SQLStr);
//
//        SQLStr :='ALTER TABLE [Exam_Score_people] '+
//                 'Add Constraint [PK_Exam_Score_people] '+
//                 'Primary Key ([Exam_No],[Sub_No],[Student_No])';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//
//      // add by ken 20120829 Exam_sub_sno檢查資料表是否存在
//      if not TableExists('Exam_sub_sno') then
//      begin
//        SQLStr := 'CREATE TABLE [Exam_sub_sno]'
//                + '       ([Exam_No]      varchar (8)  NOT NULL,'
//                + '        [Sub_No]       varchar (2)  NOT NULL,'
//                +'         [Sub_Sno]      varchar (2)  NOT NULL,'
//                + '        [Grade]        varchar (1)  NOT NULL,'
//                + '        [Class_No]     varchar (5)  NOT NULL) ';
//        SQLExec(DM.qryTempEx, SQLStr);
//
//        SQLStr :='ALTER TABLE [Exam_sub_sno] '+
//                 'Add Constraint [PK_Exam_sub_sno] '+
//                 'Primary Key ([Exam_No],[Sub_No],[Sub_Sno],[Grade],[Class_No])';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//
//      // add by ken 20120829 Term_Class欄位更新
//      SQLStr :='ALTER TABLE Term_Class ALTER Class_No   varchar (3) ';
//      SQLExec(DM.qryTempSch, SQLStr);
//      // add by ken 20120829 Term_Student欄位更新
//      SQLStr :='ALTER TABLE Term_Student ALTER Class_No varchar (3) ';
//      SQLExec(DM.qryTempSch, SQLStr);
//      SQLStr :='ALTER TABLE Term_Student ALTER Seat_No  varchar (3) ';
//      SQLExec(DM.qryTempSch, SQLStr);
//
//      //add by ken 20120828 Start 資料庫第一版更新：題型設定加題組三、加自訂多重題型
//      SQLStr :='SELECT * FROM exam_question WHERE 1<>1';
//      OpenSQL(DM.qryTempEx, SQLStr);
//      if DM.qryTempEx.FindField('QT_Score1')=nil then
//      begin
//        SQLStr :='ALTER TABLE exam_question ADD '+
//                 'QT_Score1 varchar (50),  '+
//                 'QT_Score2 varchar (50),  '+
//                 'QT_Score3 varchar (50),  '+
//                 'QT_Score4 varchar (50),  '+
//                 'QT_Score5 varchar (50),  '+
//                 'QT_Deduct1 varchar (50), '+
//                 'QT_Deduct2 varchar (50), '+
//                 'QT_Deduct3 varchar (50), '+
//                 'QT_Deduct4 varchar (50), '+
//                 'QT_Deduct5 varchar (50)'  ;
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//
//      //add by ken 20121016 新增完欄位再把欄位為空白的填上預設值0
//      SQLStr :='update  exam_question set QT_Score1=0  where QT_TypeCode<>''G'' and QT_Score1 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Score2=0  where QT_TypeCode<>''G'' and QT_Score2 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Score3=0  where QT_TypeCode<>''G'' and QT_Score3 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Score4=0  where QT_TypeCode<>''G'' and QT_Score4 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Score5=0  where QT_TypeCode<>''G'' and QT_Score5 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Deduct1=0  where QT_TypeCode<>''G'' and QT_Deduct1 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Deduct2=0  where QT_TypeCode<>''G'' and QT_Deduct2 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Deduct3=0  where QT_TypeCode<>''G'' and QT_Deduct3 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Deduct4=0  where QT_TypeCode<>''G'' and QT_Deduct4 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//      SQLStr :='update  exam_question set QT_Deduct5=0  where QT_TypeCode<>''G'' and QT_Deduct5 is null';
//      SQLExec(DM.qryTempEx,SQLStr);
//
//      if not TableExists('Exam_Question_Range') then
//      begin
//        SQLStr := 'CREATE TABLE [Exam_Question_Range]'
//                + '       ([Exam_No]    varchar (8) NOT NULL,'
//                + '        [Sub_No]     varchar (2) NOT NULL,'
//                +'         [Sub_Sno]    varchar (2) NULL,'
//                + '        [Q_No]       varchar (3) NOT NULL,'
//                + '        [QT_No]      varchar (2) NULL,'
//                + '        [Rcnt_Range] varchar (2)  NOT NULL,'
//                + '        [Q_No_Start] varchar (3)  NULL,'
//                + '        [Q_No_End]   varchar (3)  NULL,'
//                + '        [Rcnt_Start] varchar (3) NULL,'
//                + '        [Rcnt_End]   varchar (3) NULL,'
//                + '        [Q_Score]    varchar (3)  NULL)';
//        SQLExec(DM.qryTempEx, SQLStr);
//
//        SQLStr :='ALTER TABLE [Exam_Question_Range] '+
//                 'Add Constraint [PK_Exam_Question_Range] '+
//                 'Primary Key ([Q_No],[Sub_No],[Exam_No],[Sub_Sno],[QT_No],[Rcnt_Range])';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end; //add by ken 20120828 Start 資料庫第一版更新：題型設定加題組三、加自訂多重題
//
//      // add by ken 20120926 SYS_CLASS新增欄位
//      SQLStr :='SELECT * FROM Sys_Class WHERE 1<>1';  // 新增欄位
//      OpenSQL(DM.qryTempSys, SQLStr);
//      if DM.qryTempSys.FindField('Type')=nil then
//      begin
//        // add by ken 20121018 把班級編號欄位加大到3碼
//        SQLStr :='ALTER TABLE Sys_Class ALTER Class_no varchar (3) ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 新增類別欄位(Type)
//        SQLStr :='ALTER TABLE Sys_Class ADD '+
//                 'Type CHAR(1) ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 去除原有的PrimaryKey(Class_no)
//        SQLStr :='ALTER TABLE [sys_Class] '+
//                 'DROP CONSTRAINT [PrimaryKey] ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 更新登入學制的type欄位值
//        SQLStr :='Update Sys_Class set Type='''+vsDepart+''' ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 加上Class_no,Type雙主鍵
//        SQLStr :='ALTER TABLE [Sys_Class] '+
//                 'Add Constraint [PK_Sys_Class] '+
//                 'Primary Key ([Class_No],[Type])';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 把原有PrimaryKey(Class_no)的重覆限制拿掉(索引由：是(不可重覆)改成否)
//        SQLStr :='ALTER TABLE sys_class '+
//                 'DROP CONSTRAINT class_no ';
//        SQLExec(DM.qryTempSys, SQLStr);
//      end;
//
//      // add by ken 20120926 SYS_SCHOOL新增欄位
//      SQLStr :='SELECT * FROM Sys_School WHERE 1<>1';  // 新增欄位
//      OpenSQL(DM.qryTempSys, SQLStr);
//      if DM.qryTempSys.FindField('Type')=nil then
//      begin
//        // add by ken 20120927 新增類別欄位(Type)
//        SQLStr :='ALTER TABLE Sys_School ADD '+
//                 'Type CHAR(1) ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 去除原有的PrimaryKey(Sch_code)
//        SQLStr :='ALTER TABLE [sys_School] '+
//                 'DROP CONSTRAINT [PrimaryKey] ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 更新登入學制的type欄位值
//        SQLStr :='Update Sys_School set Type='''+vsDepart+''' ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 加上Sch_code,Type雙主鍵
//        SQLStr :='ALTER TABLE [Sys_School] '+
//                 'ADD Constraint [PK_Sys_School] '+
//                 'Primary Key ([Sch_Code],[Type])';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 把原有PrimaryKey(Sch_code)的重覆限制拿掉(索引由：是(不可重覆)改成否)
//        SQLStr :='ALTER TABLE sys_School '+
//                 'DROP CONSTRAINT Sch_code ';
//        SQLExec(DM.qryTempSys, SQLStr);
//      end;
//      ShowMessage('更新成功！');
//    except
//      ShowMessage('更新失敗！');
//    end; // add by ken 20120828 Start 資料庫更新
  end;
end;

procedure TfmDBSetUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmDBSetUp.FormDestroy(Sender: TObject);
begin
  fmDBSetUp := Nil;
end;

procedure TfmDBSetUp.FormShow(Sender: TObject);
begin
  edtPW.SetFocus;

  if pChooses.Visible then
  begin
    fmDBSetUp.Height:= 317;  // 顯示sDepart 選項
  end
  else
  begin
    fmDBSetUp.Height:= fmDBSetUp.Height - pChooses.Height;
  end;

  SendMessage(GetWindow(cmbTNo.Handle, GW_CHILD), EM_SETREADONLY, 1, 0);
    //帶預設值
    LoadINI(fmMain.sPath);
//    if (fmMain.sDepart = 'J') OR (fmMain.sDepart = '') then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '國中';
//      RadioGroup1.ItemIndex := 0;
//    end;
//    if (fmMain.sDepart = 'S')  then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '高中';
//      RadioGroup1.ItemIndex := 1;
//    end;
//    if (fmMain.sDepart = 'V')  then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '高職';
//      RadioGroup1.ItemIndex := 2;
//    end;
//    if (fmMain.sDepart = 'U')  then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '大學';
//      RadioGroup1.ItemIndex := 3;
//    end;
    //2012/03/14 By Hippo Add
    seYear.Text:=fmMain.sTYear;
    if fmMain.sTerm='1' then
       cmbTNo.Text:=fmMain.sTerm+' 上學期'
    else
       cmbTNo.Text:=fmMain.sTerm+' 下學期';

//    if fmMain.sUpdate<>'' then  // add by ken 20121001 判斷ini檔中的sUpdate是否有值，有值即顯示更新資料庫按鈕
//    begin
//      Button1.Visible:=True;
//    end
//    else
//    begin
//      Button1.Visible:=False;
//    end;

end;

procedure TfmDBSetUp.GetSysPara;
var ls_SQL :String;
begin

   //Read_Student_No  讀答案卡時讀 0:座號 或 1:學號
   //加入是否一科多卷 Set_sub
//   Sys.Read_Student_No := 0;
//   sys.Set_Sub :=0;
//   ls_SQL := ' Select Set_Para,Set_sub From Sys_SetUp Where Set_Name = "Read_Student_No" ';
//   OpenSQL(DM.qryTempSys, ls_SQL);
//   try
//     Sys.Read_Student_No := DM.qryTempSys.FieldByName('Set_Para').AsInteger ;
//     sys.Set_Sub := DM.qryTempSys.FieldByName('Set_sub').AsInteger ;
//   except
//     Sys.Read_Student_No := 0;
//     sys.Set_Sub :=0;
//   end;

   //Other


end;

procedure TfmDBSetUp.RadioGroup1Click(Sender: TObject);
begin
//    case RadioGroup1.ItemIndex of
//      0:Begin
//        fmMain.StatusBar1.Panels[0].Text := '國中';
//        fmMain.sDepart := 'J';
//      End;
//      1:Begin
//        fmMain.StatusBar1.Panels[0].Text := '高中';
//        fmMain.sDepart := 'S';
//      End;
//      2:Begin
//        fmMain.StatusBar1.Panels[0].Text := '高職';
//        fmMain.sDepart := 'V';
//      End;
//      3:Begin
//        fmMain.StatusBar1.Panels[0].Text := '大學';
//        fmMain.sDepart := 'U';
//      End;
//    end; //case RadioGroup1.ItemIndex of


end;

function TfmDBSetUp.TableExists(TableName: String): Boolean;
Var
    Sl : TStrings;
Begin
//    Sl := TstringList.Create;
//    // 使用ADO ===============================
//    DM.ConnExam.GetTableNames(Sl,True);
//    Result := Sl.IndexOf(TableName)<> -1 ;
//    // 使用BDE ===============================
//  //  Session.GetTableNames('dbAlias',TableName,False,True,Sl);
//  //  Result := Sl.Count>0 ;
//    // 擇一使用 ===============================
//    Sl.Free;
end;

end.
