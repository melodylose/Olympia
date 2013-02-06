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
    procedure GetSysPara();  //���o�t�ΰѼ�
    Function TableExists(TableName : String):Boolean;  //�ˬd Table �O�_�s�b
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

  if (fmDBSetUp.Caption = '�n�J��Ʈw') then
  begin

//    if Trim(edtUser.Text)<>'' then
//    begin
//      if (fmMain.sUser <> Trim(edtUser.Text))     //�ˬd�b��
//      or (fmMain.sPW   <> Trim(edtPW.Text)) then  //�ˬd�K�X
//       begin
//       showmessage('�z��J�ϥΪ̱b���P�K�X����');
//       Exit;
//       end
//      else
//       begin
//       fmMain.StatusBar1.Panels[1].Text := Trim(edtUser.Text)+' �n�J';
//       //fmMain.sUser := Trim(edtUser.Text);
//       end;
//    end
//    else
//    begin
//     showmessage('�z�|����J�ϥΪ̱b��/�K�X');
//     Exit;
//    end;

    if (Trim(seYear.Text)<>'') and (Trim(cmbTNo.Text)<>'') then
    begin
      fmMain.sTYear := Trim(seYear.Text);   //�Ǧ~
      fmMain.sTerm := Trim(cmbTNo.Text);  //�Ǵ� 1�G�W�Ǵ��B2�G�U�Ǵ�
    end
    else
    begin
      showmessage('�п�ܾǦ~/�Ǵ�');
      Exit;
    end;

    //�ؿ����b�s�W�ؿ�
    if Not DirectoryExists(fmMain.sPath+edtUser.Text+'_Data') then
        ForceDirectories(fmMain.sPath+edtUser.Text+'_Data') ;
    //�Ǯո��
    sFile1 := fmMain.sPath+edtUser.Text+'_Data'
              +'\Sch'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';
    //�Ҹո��
    sFile2 := fmMain.sPath+edtUser.Text+'_Data'
              +'\Ex'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';

    if Not (FileExists(PChar(sFile1))) then //�䤣�� �Ǯհ���
    begin
      if application.Messagebox('�z��ܪ��Ǯո�Ʈw���s�b�A�O�_���z�إߡH','��Ʈw���s�b',MB_YesNo)= IDYES then
        CopyFile(PChar(fmMain.sPath+'_Data\Sch.mdb'),PChar(sFile1),False)  //�ƻs�Ǯժťո�Ʈw
      else
        Exit;

    end;

    if Not (FileExists(PChar(sFile2))) then //�䤣�� �Ҹ���
    begin
      if application.Messagebox('�z��ܪ��Ҹո�Ʈw���s�b�A�O�_���z�إߡH','��Ʈw���s�b',MB_YesNo)= IDYES then
        CopyFile(PChar(fmMain.sPath+'_Data\Ex.mdb'),PChar(sFile2),False)  //�ƻs�Ҹժťո�Ʈw
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
          //���o�t�ΰѼ�   add by JC 2011.4.24
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

  end  //if (fmDBSetUp.Caption = '�n�J��Ʈw')
  else if fmDBSetUp.Caption = '��l�Ƹ�Ʈw' then
  begin
    //
    case RadioGroup1.ItemIndex of
      0:Begin
//        fmMain.StatusBar1.Panels[0].Text := '�ꤤ';
//        fmMain.sDepart := 'J';
      End;
      1:Begin
//        fmMain.StatusBar1.Panels[0].Text := '����';
//        fmMain.sDepart := 'S';
      End;
      2:Begin
//        fmMain.StatusBar1.Panels[0].Text := '��¾';
//        fmMain.sDepart := 'V';
      End;
      3:Begin
//        fmMain.StatusBar1.Panels[0].Text := '�j��';
//        fmMain.sDepart := 'U';
      End;
    end; //case RadioGroup1.ItemIndex of


    if (Trim(edtUser.Text)='') then
    begin
      showmessage('�z�|���]�w�ϥΪ̱b��');
      edtUser.SetFocus;
      Exit;
    end
    else
      fmMain.sUser := Trim(edtUser.Text);

    if Trim(seYear.Text)='' then
    begin
      showmessage('�п�J/��ܪ�l�ƪ��Ǧ~');
      seYear.SetFocus;
      Exit;
    end
    else
      fmMain.sTYear := Trim(seYear.Text);

    if Trim(cmbTNo.Text)='' then
    begin
      showmessage('�п�J/��ܪ�l�ƪ��Ǵ�');
      cmbTNo.SetFocus;
      Exit;
    end
    else
    fmMain.sTerm := Trim(cmbTNo.Text);

    if (Trim(edtPW.Text)='') then
    begin
//      if application.Messagebox('�z�T�w���]�w�K�X�ܡH','�K�X�|���]�w',MB_YesNo)= IDYES then
//         fmMain.sPW := Trim(edtPW.Text)
//      else
//       begin
//         ShowMessage('�п�J�]�w�K�X');
//         Exit;
//       end;
    end;

    try
     try
     if Not DirectoryExists(fmMain.sPath+edtUser.Text+'_Data') then //�ˬd���L���ؿ�
      ForceDirectories(fmMain.sPath+edtUser.Text+'_Data'); //�s�W�ؿ�

      sFile1 := fmMain.sPath+edtUser.Text+'_Data'
                +'\Sch'+'U'+fmMain.sTYear+Copy(fmMain.sTerm,1,1)+'.mdb';
      sFile2 := fmMain.sPath+edtUser.Text+'_Data'
                +'\Ex'+'U'+fmMain.sTYear+Copy(fmMain.sTerm,1,1)+'.mdb';

      CopyFile(PChar(fmMain.sPath+'_Data\Sys.mdb'),PChar(fmMain.sPath+'Sys.mdb'),False);
      CopyFile(PChar(fmMain.sPath+'_Data\Sch.mdb'),PChar(sFile1),False);  //�ഫ���|�n���� PChar() �o�Ө��
      CopyFile(PChar(fmMain.sPath+'_Data\Ex.mdb'),PChar(sFile2),False);
      showmessage('��l�Ʀ��\�I'); //�бz��t�γ]�w�����u��Ʈw�]�w�v�n�J�I
     except
      showmessage('��l�ƥ��ѡA���ˬd'+#13#10+fmMain.sPath+'_Data\ '+'��Ƨ��O�_�s�b�I');
     end;

    finally
     fmDBSetUp.Caption := '�n�J��Ʈw';
//     SaveINI(fmMain.sPath, fmMain.sDepart, Trim(seYear.Text), Trim(cmbTNo.Text), Trim(edtUser.Text), Trim(edtPW.Text), fmMain.sName);
     btnOK.OnClick(self);
    end;

  end;  //else if fmDBSetUp.Caption = '��l�Ƹ�Ʈw'
 // SaveINI(fmMain.sPath, fmMain.sDepart, Trim(seYear.Text), Trim(cmbTNo.Text), Trim(edtUser.Text), Trim(edtPW.Text));
//  fmMain.nLogin.Tag := 10;
  Close;
end;

procedure TfmDBSetUp.Button1Click(Sender: TObject);
var
  sFile1, sFile2, Str_temp, SQLStr, vsDepart : String;
begin
  // add by ken 20120927 ��Ʈw��s��m��(����)
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

  //�ؿ����b�s�W�ؿ�
  if Not DirectoryExists(fmMain.sPath+edtUser.Text+'_Data') then
      ForceDirectories(fmMain.sPath+edtUser.Text+'_Data') ;
  //�Ǯո��
  sFile1 := fmMain.sPath+edtUser.Text+'_Data'
            +'\Sch'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';
  //�Ҹո��
  sFile2 := fmMain.sPath+edtUser.Text+'_Data'
            +'\Ex'+'U'+Trim(seYear.Text)+Copy(Trim(cmbTNo.Text),1,1)+'.mdb';

  if Not (FileExists(PChar(sFile1))) then //�䤣�� �Ǯհ���
  begin
    if application.Messagebox('�z��ܪ��Ǯո�Ʈw���s�b�A�O�_���z�إߡH','��Ʈw���s�b',MB_YesNo)= IDYES then
      CopyFile(PChar(fmMain.sPath+'_Data\Sch.mdb'),PChar(sFile1),False)  //�ƻs�Ǯժťո�Ʈw
    else
      Exit;

  end;

  if Not (FileExists(PChar(sFile2))) then //�䤣�� �Ҹ���
  begin
    if application.Messagebox('�z��ܪ��Ҹո�Ʈw���s�b�A�O�_���z�إߡH','��Ʈw���s�b',MB_YesNo)= IDYES then
      CopyFile(PChar(fmMain.sPath+'_Data\Ex.mdb'),PChar(sFile2),False)  //�ƻs�Ҹժťո�Ʈw
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
      //���o�t�ΰѼ�   add by JC 2011.4.24
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
//    try  // add by ken 20120828 Start ��Ʈw��s
//      // add by ken 20120829 Exam_Data����s
//      SQLStr :='ALTER TABLE Exam_Data ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Data ALTER Class_NoS varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Data ALTER Class_NoE varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Class����s
//      SQLStr :='ALTER TABLE Exam_Class ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Class ALTER Class_No varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Group����s
//      SQLStr :='ALTER TABLE Exam_Group ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Qtype����s
//      SQLStr :='ALTER TABLE Exam_Qtype ALTER QT_Type varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Qtype ALTER QT_Remark varchar (50) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Question����s
//      SQLStr :='ALTER TABLE Exam_Question ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Question ALTER Ans_Special varchar (20) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='SELECT * FROM Exam_Question WHERE 1<>1';  // �s�W���
//      OpenSQL(DM.qryTempEx, SQLStr);
//      if DM.qryTempEx.FindField('Sub_Sno')=nil then
//      begin
//        SQLStr :='ALTER TABLE exam_question ADD Sub_Sno varchar (2)  ';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//      // add by ken 201200829 Exam_Range����s
//      SQLStr :='ALTER TABLE Exam_Range ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Range ALTER R_Count varchar (6) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Range_Sub����s
//      SQLStr :='ALTER TABLE Exam_Range_Sub ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Exam_Sub����s
//      SQLStr :='ALTER TABLE Exam_Sub ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Exam_Sub ALTER Sub_No varchar (4) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Group_Range����s
//      SQLStr :='ALTER TABLE Group_Range ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      // add by ken 20120829 Student_Score����s
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
//      // add by ken 20120829 Sub_Analysis����s
//      SQLStr :='ALTER TABLE Sub_Analysis ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='SELECT * FROM Sub_Analysis WHERE 1<>1';  // �s�W���
//      OpenSQL(DM.qryTempEx, SQLStr);
//      if DM.qryTempEx.FindField('Sub_Sno')=nil then
//      begin
//        SQLStr :='ALTER TABLE Sub_Analysis ADD Sub_Sno varchar (2)  ';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//      // add by ken 20120829 Sub_Score����s
//      SQLStr :='ALTER TABLE Sub_Score ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Sub_Score ALTER Class_No varchar (5) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//      SQLStr :='ALTER TABLE Sub_Score ALTER Score_People varchar (6) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//
//      SQLStr :='SELECT * FROM Sub_Score WHERE 1<>1';  // �s�W���
//      OpenSQL(DM.qryTempEx, SQLStr);
//      if DM.qryTempEx.FindField('Arrange_School')=nil then
//      begin
//        SQLStr :='ALTER TABLE Sub_Score ADD '+
//                 'Arrange_School varchar (5), '+
//                 'Arrange_Grade varchar  (4), '+
//                 'Arrange_Class varchar  (4)  ';
//        SQLExec(DM.qryTempEx, SQLStr);
//      end;
//      // add by ken 20120829 TScore_Mix����s
//      SQLStr :='ALTER TABLE TScore_Mix ALTER Exam_No varchar (8) ';
//      SQLExec(DM.qryTempEx, SQLStr);
//
//      // add by ken 20120829 Exam_Score_people�ˬd��ƪ�O�_�s�b
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
//      // add by ken 20120829 Exam_sub_sno�ˬd��ƪ�O�_�s�b
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
//      // add by ken 20120829 Term_Class����s
//      SQLStr :='ALTER TABLE Term_Class ALTER Class_No   varchar (3) ';
//      SQLExec(DM.qryTempSch, SQLStr);
//      // add by ken 20120829 Term_Student����s
//      SQLStr :='ALTER TABLE Term_Student ALTER Class_No varchar (3) ';
//      SQLExec(DM.qryTempSch, SQLStr);
//      SQLStr :='ALTER TABLE Term_Student ALTER Seat_No  varchar (3) ';
//      SQLExec(DM.qryTempSch, SQLStr);
//
//      //add by ken 20120828 Start ��Ʈw�Ĥ@����s�G�D���]�w�[�D�դT�B�[�ۭq�h���D��
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
//      //add by ken 20121016 �s�W�����A����쬰�ťժ���W�w�]��0
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
//      end; //add by ken 20120828 Start ��Ʈw�Ĥ@����s�G�D���]�w�[�D�դT�B�[�ۭq�h���D
//
//      // add by ken 20120926 SYS_CLASS�s�W���
//      SQLStr :='SELECT * FROM Sys_Class WHERE 1<>1';  // �s�W���
//      OpenSQL(DM.qryTempSys, SQLStr);
//      if DM.qryTempSys.FindField('Type')=nil then
//      begin
//        // add by ken 20121018 ��Z�Žs�����[�j��3�X
//        SQLStr :='ALTER TABLE Sys_Class ALTER Class_no varchar (3) ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 �s�W���O���(Type)
//        SQLStr :='ALTER TABLE Sys_Class ADD '+
//                 'Type CHAR(1) ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 �h���즳��PrimaryKey(Class_no)
//        SQLStr :='ALTER TABLE [sys_Class] '+
//                 'DROP CONSTRAINT [PrimaryKey] ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 ��s�n�J�Ǩtype����
//        SQLStr :='Update Sys_Class set Type='''+vsDepart+''' ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 �[�WClass_no,Type���D��
//        SQLStr :='ALTER TABLE [Sys_Class] '+
//                 'Add Constraint [PK_Sys_Class] '+
//                 'Primary Key ([Class_No],[Type])';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 ��즳PrimaryKey(Class_no)�����Э����(���ޥѡG�O(���i����)�令�_)
//        SQLStr :='ALTER TABLE sys_class '+
//                 'DROP CONSTRAINT class_no ';
//        SQLExec(DM.qryTempSys, SQLStr);
//      end;
//
//      // add by ken 20120926 SYS_SCHOOL�s�W���
//      SQLStr :='SELECT * FROM Sys_School WHERE 1<>1';  // �s�W���
//      OpenSQL(DM.qryTempSys, SQLStr);
//      if DM.qryTempSys.FindField('Type')=nil then
//      begin
//        // add by ken 20120927 �s�W���O���(Type)
//        SQLStr :='ALTER TABLE Sys_School ADD '+
//                 'Type CHAR(1) ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 �h���즳��PrimaryKey(Sch_code)
//        SQLStr :='ALTER TABLE [sys_School] '+
//                 'DROP CONSTRAINT [PrimaryKey] ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 ��s�n�J�Ǩtype����
//        SQLStr :='Update Sys_School set Type='''+vsDepart+''' ';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 �[�WSch_code,Type���D��
//        SQLStr :='ALTER TABLE [Sys_School] '+
//                 'ADD Constraint [PK_Sys_School] '+
//                 'Primary Key ([Sch_Code],[Type])';
//        SQLExec(DM.qryTempSys, SQLStr);
//
//        // add by ken 20120927 ��즳PrimaryKey(Sch_code)�����Э����(���ޥѡG�O(���i����)�令�_)
//        SQLStr :='ALTER TABLE sys_School '+
//                 'DROP CONSTRAINT Sch_code ';
//        SQLExec(DM.qryTempSys, SQLStr);
//      end;
//      ShowMessage('��s���\�I');
//    except
//      ShowMessage('��s���ѡI');
//    end; // add by ken 20120828 Start ��Ʈw��s
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
    fmDBSetUp.Height:= 317;  // ���sDepart �ﶵ
  end
  else
  begin
    fmDBSetUp.Height:= fmDBSetUp.Height - pChooses.Height;
  end;

  SendMessage(GetWindow(cmbTNo.Handle, GW_CHILD), EM_SETREADONLY, 1, 0);
    //�a�w�]��
    LoadINI(fmMain.sPath);
//    if (fmMain.sDepart = 'J') OR (fmMain.sDepart = '') then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '�ꤤ';
//      RadioGroup1.ItemIndex := 0;
//    end;
//    if (fmMain.sDepart = 'S')  then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '����';
//      RadioGroup1.ItemIndex := 1;
//    end;
//    if (fmMain.sDepart = 'V')  then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '��¾';
//      RadioGroup1.ItemIndex := 2;
//    end;
//    if (fmMain.sDepart = 'U')  then
//    begin
//      fmMain.StatusBar1.Panels[0].Text := '�j��';
//      RadioGroup1.ItemIndex := 3;
//    end;
    //2012/03/14 By Hippo Add
    seYear.Text:=fmMain.sTYear;
    if fmMain.sTerm='1' then
       cmbTNo.Text:=fmMain.sTerm+' �W�Ǵ�'
    else
       cmbTNo.Text:=fmMain.sTerm+' �U�Ǵ�';

//    if fmMain.sUpdate<>'' then  // add by ken 20121001 �P�_ini�ɤ���sUpdate�O�_���ȡA���ȧY��ܧ�s��Ʈw���s
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

   //Read_Student_No  Ū���ץd��Ū 0:�y�� �� 1:�Ǹ�
   //�[�J�O�_�@��h�� Set_sub
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
//        fmMain.StatusBar1.Panels[0].Text := '�ꤤ';
//        fmMain.sDepart := 'J';
//      End;
//      1:Begin
//        fmMain.StatusBar1.Panels[0].Text := '����';
//        fmMain.sDepart := 'S';
//      End;
//      2:Begin
//        fmMain.StatusBar1.Panels[0].Text := '��¾';
//        fmMain.sDepart := 'V';
//      End;
//      3:Begin
//        fmMain.StatusBar1.Panels[0].Text := '�j��';
//        fmMain.sDepart := 'U';
//      End;
//    end; //case RadioGroup1.ItemIndex of


end;

function TfmDBSetUp.TableExists(TableName: String): Boolean;
Var
    Sl : TStrings;
Begin
//    Sl := TstringList.Create;
//    // �ϥ�ADO ===============================
//    DM.ConnExam.GetTableNames(Sl,True);
//    Result := Sl.IndexOf(TableName)<> -1 ;
//    // �ϥ�BDE ===============================
//  //  Session.GetTableNames('dbAlias',TableName,False,True,Sl);
//  //  Result := Sl.Count>0 ;
//    // �ܤ@�ϥ� ===============================
//    Sl.Free;
end;

end.
