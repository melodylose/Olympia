unit UReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, TeEngine, Series, TeeProcs, Chart,
  DBChart, TeePolar, TeeURL, TeeSeriesTextEd, StdCtrls, ComCtrls, jpeg;

type
  TfmReport = class(TForm)
  {$region 'Form Controls'}
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    qrName: TQRLabel;
    qrX_No: TQRLabel;
    qrSch_Name: TQRLabel;
    qrGrade: TQRLabel;
    qrGradePaste: TQRLabel;
    QRLabel9: TQRLabel;
    qrClass_No: TQRLabel;
    QRLabel11: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    qrRightCount01: TQRLabel;
    qrRightCount02: TQRLabel;
    qrScore01: TQRLabel;
    qrScore02: TQRLabel;
    qrAverage01: TQRLabel;
    qrAverage02: TQRLabel;
    qrScoreSum: TQRLabel;
    qrAverageSum: TQRLabel;
    qrAwards: TQRLabel;
    qrArrange: TQRLabel;
    qrSub01: TQRLabel;
    qrSub02: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRLabel17: TQRLabel;
    qrSub01Name: TQRLabel;
    qrSub02Name: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    DBChart2: TDBChart;
    DBChart3: TDBChart;
    Series3: TRadarSeries;
    Series5: TRadarSeries;
    DBChart4: TDBChart;
    Series6: TAreaSeries;
    QRImage1: TQRImage;
    QRImage2: TQRImage;
    qrRichText: TQRRichText;
    QRImage3: TQRImage;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRLabel119: TQRLabel;
    QRImage4: TQRImage;
    Series2: TRadarSeries;
    Series4: TRadarSeries;
    QRShape39: TQRShape;
    QRLabel23: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    QRRichText1: TQRRichText;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRLabel85: TQRLabel;
    {$endregion}
    procedure QuickRep1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QuickRep1AfterPreview(Sender: TObject);
    procedure QuickRep1AfterPrint(Sender: TObject);
  private
    EnumStu: TListEnumerator;
    jpg: TJPEGImage;
    BMP: TBitmap;
    Ratio: Double;
    RT: TRect;
    { Private declarations }
  public
    procedure CreateQRLabel_2(L,T,W,H:Integer;N,C:string);
    function ChangeCode(Code: string): String;
    function DelSpc(InputData: string): String;
    function StringReturn(ConvertString:string): string;
    function AnsReturn(ConvertString:string): String;
    function CationReturn(CationStr: string; Index:Integer): String;
  { Public declarations }
  end;

var
  fmReport: TfmReport;

implementation

uses UMain, UModel, UDM, UGlobal, Math;

{$R *.dfm}

procedure TfmReport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  jpg.Free;
  BMP.Free;
  EnumStu.Free;
end;

procedure TfmReport.FormCreate(Sender: TObject);
var
  I: Integer;
  P_W: Integer;
  P_H: Integer;
  TempStr: string;
begin
  jpg:= TJPEGImage.Create;
  BMP:= TBitmap.Create;
  fmMain.LoadTitleImage:= Attribute.Values['ImagePath'];
  if ExtractFileExt(fmMain.LoadTitleImage) = '.bmp' then
  begin
    TempStr:= Copy(fmMain.LoadTitleImage, 1, Length(fmMain.LoadTitleImage)-4)+'.JPG';
    BMPtoJPG(fmMain.LoadTitleImage, TempStr);
    fmMain.LoadTitleImage:= TempStr;
  end;

  if FileExists(fmMain.LoadTitleImage) then
  begin
    jpg.LoadFromFile(fmMain.LoadTitleImage);

    P_W:=jpg.Width;
    P_H:=jpg.Height;

    Ratio:= Min((QRImage4.Width / P_W), (QRImage4.Height / P_H));

    P_H:= Round( P_H * Ratio );
    P_W:= Round( P_W * Ratio );

    BMP.Width:= QRImage4.Width;
    BMP.Height:= QRImage4.Height;

    RT.Left := Floor(Abs((QRImage4.Width)-P_W)/2);
    RT.Top := Floor(Abs((QRImage4.Height)-P_H)/2);
    RT.Right := RT.Left + P_W;
    RT.Bottom := RT.Top + P_H;

    BMP.Canvas.StretchDraw(RT, jpg);
    QRImage4.Picture.Bitmap.Assign(BMP);
    QRImage4.Width:= BMP.Width;
    QRImage4.Height:= BMP.Height;
  end;

  EnumStu:= fmMain.LStudentDetail.GetEnumerator;
  QRLabel43.Caption:= StringReturn(QRLabel43.Caption);
  QRLabel64.Caption:= StringReturn(QRLabel64.Caption);
  // answer carriagestring
  for I := 0 to QRBand1.ControlCount - 1 do
  begin
    if QRBand1.Controls[I].Tag = 5 then
    begin
      TQRLabel(QRBand1.Controls[I]).Caption:=
        AnsReturn(TQRLabel(QRBand1.Controls[I]).Caption);
    end;
  end;

end;

procedure TfmReport.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrGradePaste.Left:= qrSch_Name.Left + qrSch_Name.Width + 10;
  QRLabel9.Left:= qrGradePaste.Left + qrGradePaste.Width + 10;
  qrClass_No.Left:= QRLabel9.Left + QRLabel9.Width + 10;
  QRLabel11.Left:= qrClass_No.Left + qrClass_No.Width + 10;
end;

procedure TfmReport.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  a, hh, ii, kk, ll: Integer;
  Slen: Integer;
  SAns, S_ans: string;
  SAns2, SAns1: string;
  COUNTOF: Integer;
  SqlStrList: TStringList;
  UNION: string;
  BeginScore: Integer;
  EndScore: Integer;
  J: Integer;
  I: Integer;
  totalofgreade: Integer;
begin
  SqlStrList:= TStringList.Create;
  qrAwards.Caption:=EmptyStr;
  qrName.Caption:= StudentDetail(EnumStu.Current).StudentName;
  qrX_No.Caption:= StudentDetail(EnumStu.Current).Student_No;
  qrSch_Name.Caption:= StudentDetail(EnumStu.Current).School_Name;
  qrGrade.Caption:= StudentDetail(EnumStu.Current).Group_No+ ' 年級組';
  qrGradePaste.Caption:= StudentDetail(EnumStu.Current).Grade;
  qrClass_No.Caption:= StudentDetail(EnumStu.Current).Class_No;
  qrRightCount01.Caption:= StudentDetail(EnumStu.Current).Sub01RightCount;
  qrRightCount02.Caption:= StudentDetail(EnumStu.Current).Sub02RightCount;
  qrScore01.Caption:= StudentDetail(EnumStu.Current).Sub01Score;
  qrScore02.Caption:= StudentDetail(EnumStu.Current).Sub02Score;
  qrScoreSum.Caption:= StudentDetail(EnumStu.Current).SumSub;
  qrAverageSum.Caption:= StudentDetail(EnumStu.Current).Average;

  qrSub01.Caption:= Trim(StudentDetail(EnumStu.Current).Sub01Name);
  qrSub02.Caption:= Trim(StudentDetail(EnumStu.Current).Sub02Name);
  qrSub01Name.Caption:= Trim(StudentDetail(EnumStu.Current).Sub01Name);
  qrSub02Name.Caption:= Trim(StudentDetail(EnumStu.Current).Sub02Name);

  for I := 0 to QRBand1.ControlCount - 1 do
  begin
    if QRBand1.Controls[I].Tag = 6 then
    begin
      TQRLabel(QRBand1.Controls[I]).Caption:=
        CationReturn(TQRLabel(QRBand1.Controls[I]).Caption, 4);
    end
    else if QRBand1.Controls[I].Tag = 7 then
    begin
      TQRLabel(QRBand1.Controls[I]).Caption:=
              CationReturn(TQRLabel(QRBand1.Controls[I]).Caption, 2);
      TQRLabel(QRBand1.Controls[I]).Caption:=
              CationReturn(TQRLabel(QRBand1.Controls[I]).Caption, 2);
    end;
  end;


  SqlStr:= 'SELECT *, RANK() OVER ( ORDER BY SumScore desc ) as arrange FROM RankSumScore '+
           'WHERE Grade='+QuotedStr(StudentDetail(EnumStu.Current).Group_No)+' ORDER BY Student_No';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  DM.adoQueryTempAnaly.First;
  while NOT DM.adoQueryTempAnaly.Eof do
  begin
    if (DM.adoQueryTempAnaly.FieldByName('student_no').AsString =
      StudentDetail(EnumStu.Current).Student_No) and
      (DM.adoQueryTempAnaly.FieldByName('sumscore').AsString =
      StudentDetail(EnumStu.Current).SumSub)
    then
    begin
      qrArrange.Caption:= DM.adoQueryTempAnaly.FieldByName('arrange').AsString + ' / ';
    end;
    DM.adoQueryTempAnaly.Next;
  end;

  SqlStr:= '(select round(avg(sum_sub),2) as sub01avg from sub_score where '+
           ' sub_name='+QuotedStr(StudentDetail(EnumStu.Current).Sub01Name)+
           ' and exam_no='+QuotedStr(fmMain.cbExam_No.Text)+
//           ' and absent_c <> '+QuotedStr('1')+
           ' and Group_No='+QuotedStr(StudentDetail(EnumStu.Current).Group_No)+')';

  SqlOpen(DM.adoQueryTempEx, SqlStr);
  DM.adoQueryTempEx.First;
  if NOT DM.adoQueryTempEx.IsEmpty then
    qrAverage01.Caption:= DM.adoQueryTempEx.FieldByName('sub01avg').AsString;

  SqlStr:= '(select round(avg(sum_sub),2) as sub02avg from sub_score where '+
           ' sub_name='+QuotedStr(StudentDetail(EnumStu.Current).Sub02Name)+
           ' and exam_no='+QuotedStr(fmMain.cbExam_No.Text)+
//           ' and absent_c <> '+QuotedStr('1')+
           ' and Group_No='+QuotedStr(StudentDetail(EnumStu.Current).Group_No)+')';

  SqlOpen(DM.adoQueryTempEx, SqlStr);
  DM.adoQueryTempEx.First;
  if NOT DM.adoQueryTempEx.IsEmpty then
    qrAverage02.Caption:= DM.adoQueryTempEx.FieldByName('sub02avg').AsString;
  // exam total people count
  SqlStr:=' (select count(student_no) as cnt from student_score where '+
          ' exam_no='+QuotedStr(fmMain.cbExam_No.Text)+
          ' and Group_No='+QuotedStr(StudentDetail(EnumStu.Current).Group_No)+')';

  SqlOpen(DM.adoQueryTempEx, SqlStr);
  DM.adoQueryTempEx.First;
  if NOT DM.adoQueryTempEx.IsEmpty then
    qrArrange.Caption:= qrArrange.Caption + DM.adoQueryTempEx.FieldByName('cnt').AsString;
  // exam awards
  SqlStr:='select * from studentaward where student_no='+QuotedStr(StudentDetail(EnumStu.Current).Student_No);
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  DM.adoQueryTempAnaly.First;
  if NOT DM.adoQueryTempAnaly.IsEmpty then
    qrAwards.Caption:= DM.adoQueryTempAnaly.FieldByName('awards').AsString;



  totalofgreade:= DM.adoQueryTempEx.FieldByName('cnt').AsInteger;

  SqlStr:= ' select sum(ans_score) as sumsub from exam_question where '+
             ' exam_no = '+QuotedStr(fmMain.cbExam_No.Text)+
             ' and sub_name in ('+QuotedStr(fmMain.cbSub01.Text)+', '+QuotedStr(fmMain.cbSub02.Text)+')';
  if fmMain.lbSub_No.Visible and (fmMain.cbSubNo01.Text <> '') or (fmMain.cbSubNo02.Text <> '') then
  begin
    SqlStr:= SqlStr + ' and sub_no in ('+QuotedStr(fmMain.cbSubNo01.Text)+', '+QuotedStr(fmMain.cbSubNo02.Text)+')';
  end;

  SqlOpen(DM.adoQueryTempEx, SqlStr);
  DM.adoQueryTempEx.First;
  COUNTOF:= -1;

  if NOT DM.adoQueryTempEx.IsEmpty then
  begin
    COUNTOF:= DM.adoQueryTempEx.FieldByName('sumsub').AsInteger;
  end;
  SqlStrList.Clear;
  UNION:= ' union all ';
  BeginScore:= 1;
  EndScore:= 10;
  J:= COUNTOF div 10;
  for I := 1 to J+3 do
  begin
    SqlStrList.Append(
    'select '+IntToStr(EndScore-10)+' as [range], '+
          'SUM(case when SumScore between '+IntToStr(BeginScore)+
          ' and '+IntToStr(EndScore)+' then 1 else 0 end) as sumscore from RankSumScore'+
          ' where Grade = '+QuotedStr(StudentDetail(EnumStu.Current).Group_No)
          );
    SqlStrList.Append(UNION);
    BeginScore:= BeginScore + 10;
    EndScore:= EndScore + 10;
  end;

  SqlStrList.Delete(SqlStrList.Count-1);
  SqlOpen(DM.adoQueryAnaly, StringReplace(SqlStrList.Text,#$D#$A,'',[rfReplaceAll]));
  fmReport.DBChart4.Series[0].Clear;
  while NOT DM.adoQueryAnaly.Eof do
  begin
    if DM.adoQueryAnaly.RecNo = DM.adoQueryAnaly.RecordCount then
    begin
      fmReport.DBChart4.Series[0].AddNull(
      DM.adoQueryAnaly.FieldByName('sumscore').AsFloat);
    end
    else
    begin
      fmReport.DBChart4.Series[0].Add(DM.adoQueryAnaly.FieldByName('sumscore').AsFloat,
      DM.adoQueryAnaly.FieldByName('range').AsString);
    end;
    DM.adoQueryAnaly.Next;
  end;

  DBChart4.Title.Caption:= StudentDetail(EnumStu.Current).Group_No + ' 年級分數組距長條圖';
  if totalofgreade <> 0 then
    DBChart4.LeftAxis.Maximum:= totalofgreade;
  fmReport.DBChart4.SaveToMetafile(ExtractFilePath(Application.ExeName)+'img.wmf');
  fmReport.QRImage1.Picture.Metafile.LoadFromFile(ExtractFilePath(Application.ExeName)+'img.wmf');
  fmReport.QRImage1.Height:= fmReport.DBChart4.Height;
  fmReport.QRImage1.Width:= fmReport.DBChart4.Width;
  DeleteFile(ExtractFilePath(Application.ExeName)+'img.wmf');
  // rader chart sub01
  SqlStr:='SELECT Exam_No, a.Sub_No, Student_No, a.Struc_No, Struc_Name, RightRate FROM '+
          'Tb_StuStrucInfo a, Tb_Struc b WHERE a.Struc_No=b.Struc_No and a.Sub_No=b.Sub_No ' +
          ' and exam_no='+QuotedStr(Trim(fmMain.cbExam_No.Text))+
          ' and a.sub_No='+QuotedStr(fmMain.cbSubNo01.Text)+
          ' and student_no='+QuotedStr(StudentDetail(EnumStu.Current).Student_No)+
          ' ORDER BY Student_No, a.Struc_No ';

  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  DBChart2.Series[1].Clear;
  DM.adoQueryTempAnaly.First;
  while NOT DM.adoQueryTempAnaly.Eof do
  begin
    DBChart2.Series[1].Add(
    StrToFloat(FormatFloat('#0.00', DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat*100)),
//    DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat,
                           DM.adoQueryTempAnaly.FieldByName('Struc_Name').AsString);
    DM.adoQueryTempAnaly.Next;
  end;
  SqlStr:=' SELECT Exam_No, a.Sub_No, Struc_Name, AVG(RightRate) as RightRate FROM Tb_StuStrucInfo  a, Tb_Struc b ' +
          ' WHERE a.Struc_No=b.Struc_No and a.Sub_No=b.Sub_No' +
          ' And Exam_No ='+QuotedStr(Trim(fmMain.cbExam_No.Text))+
          ' And a.Sub_No='+QuotedStr(fmMain.cbSubNo01.Text)+
          ' GROUP BY Exam_No, a.Sub_No, Struc_Name, a.Struc_No '+
          ' Order By a.Struc_No'
          ;
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  DBChart2.Series[0].Clear;
  DM.adoQueryTempAnaly.First;
  while NOT DM.adoQueryTempAnaly.Eof do
  begin
    DBChart2.Series[0].Add(
    StrToFloat(FormatFloat('#0.00', DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat*100)),
//    DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat,
                           DM.adoQueryTempAnaly.FieldByName('Struc_Name').AsString);
    DM.adoQueryTempAnaly.Next;
  end;
  DBChart2.Series[0].Title:= '全體';
  DBChart2.Series[1].Title:= '個人';

  DBChart2.Title.Caption:= Trim(StudentDetail(EnumStu.Current).Sub01Name);

  DBChart2.SaveToBitmapFile(ExtractFilePath(Application.ExeName)+'img1.bmp');
  QRImage2.Height:= DBChart2.Height;
  QRImage2.Width:= DBChart2.Width;
  QRImage2.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName)+'img1.bmp');
  DeleteFile(ExtractFilePath(Application.ExeName)+'img1.bmp');
  // rader chart sub02
  SqlStr:='SELECT Exam_No, a.Sub_No, Student_No, a.Struc_No, Struc_Name, RightRate FROM '+
          'Tb_StuStrucInfo a, Tb_Struc b WHERE a.Struc_No=b.Struc_No and a.Sub_No=b.Sub_No ' +
          ' and exam_no='+QuotedStr(Trim(fmMain.cbExam_No.Text))+
          ' and a.sub_No='+QuotedStr(fmMain.cbSubNo02.Text)+
          ' and student_no='+QuotedStr(StudentDetail(EnumStu.Current).Student_No)+
          ' ORDER BY Student_No, a.Struc_No ';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  DBChart3.Series[1].Clear;
  DM.adoQueryTempAnaly.First;
  while NOT DM.adoQueryTempAnaly.Eof do
  begin

    DBChart3.Series[1].Add(
    StrToFloat(FormatFloat('#0.00', DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat*100)),
//    DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat,
                           DM.adoQueryTempAnaly.FieldByName('Struc_Name').AsString);
    DM.adoQueryTempAnaly.Next;
  end;
  SqlStr:=' SELECT Exam_No, a.Sub_No, Struc_Name, AVG(RightRate) as RightRate FROM Tb_StuStrucInfo  a, Tb_Struc b ' +
          ' WHERE a.Struc_No=b.Struc_No and a.Sub_No=b.Sub_No' +
          ' And Exam_No ='+QuotedStr(Trim(fmMain.cbExam_No.Text))+
          ' And a.Sub_No='+QuotedStr(fmMain.cbSubNo02.Text)+
          ' GROUP BY Exam_No, a.Sub_No, Struc_Name, a.Struc_No '+
          ' Order By a.Struc_No'
          ;
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  DBChart3.Series[0].Clear;
  DM.adoQueryTempAnaly.First;
  while NOT DM.adoQueryTempAnaly.Eof do
  begin
    DBChart3.Series[0].Add(
    StrToFloat(FormatFloat('#0.00', DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat*100)),
//    DM.adoQueryTempAnaly.FieldByName('RightRate').AsFloat,
                           DM.adoQueryTempAnaly.FieldByName('Struc_Name').AsString);
    DM.adoQueryTempAnaly.Next;
  end;
  DBChart3.Series[0].Title:= '全體';
  DBChart3.Series[1].Title:= '個人';
  DBChart3.Title.Caption:= Trim(StudentDetail(EnumStu.Current).Sub02Name);
  DBChart3.SaveToBitmapFile(ExtractFilePath(Application.ExeName)+'img2.bmp');
  QRImage3.Height:= DBChart3.Height;
  QRImage3.Width:= DBChart3.Width;
  QRImage3.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName)+'img2.bmp');
  DeleteFile(ExtractFilePath(Application.ExeName)+'img2.bmp');

  // answer status
  for ii := 1 to 2 do
  begin

    SQLStr:='select q_no,qt_name,ans_score,ans_no,Ans_Dis from Exam_Question '
     + ' where Exam_No='+QuotedStr(fmMain.cbExam_No.Text);
     if ii <> 1 then
      SqlStr:= SqlStr + ' and Sub_Name='+ QuotedStr(StudentDetail(EnumStu.Current).Sub02Name)
     else
      SqlStr:= SqlStr + ' and Sub_Name='+ QuotedStr(StudentDetail(EnumStu.Current).Sub01Name);
    SqlStr:= SqlStr + ' order by q_no';

    SqlOpen(DM.adoQueryTempEx, SQLStr);
    DM.adoQueryTempEx.First;
    S_ans:='';
    for a := 1 to DM.adoQueryTempEx.RecordCount do
    begin
      S_ans:=S_ans+ChangeCode(DM.adoQueryTempEx.FieldByName('ans_no').AsString);
      DM.adoQueryTempEx.Next;
    end;

    if ii <> 1 then
      SAns:=StudentDetail(EnumStu.Current).Sub02Ans
    else
      SAns:=StudentDetail(EnumStu.Current).Sub01Ans;

    Slen:= Length(SAns) div 10;

    if Length(SAns) mod 10 =0 then
      Slen := Slen -1;
    for kk := 0 to Slen do
    begin
      SAns2:=copy(S_ans,(kk*10)+1,10); //標準答案
      SAns1:=copy(SAns,(kk*10)+1,10);  //學生答案
      if II <> 1 then
      begin
        (FindComponent('QRDT_1'+Sub_Score(fmMain.LSubScore[0]).Sub02_No+IntToStr(KK)) as TQRLabel).Caption := SAns1;
        (FindComponent('QRDT_2'+Sub_Score(fmMain.LSubScore[0]).Sub02_No+IntToStr(KK)) as TQRLabel).Caption := SAns2;
      end
      else
      begin
        (FindComponent('QRDT_1'+Sub_Score(fmMain.LSubScore[0]).Sub01_No+IntToStr(KK)) as TQRLabel).Caption := SAns1;
        (FindComponent('QRDT_2'+Sub_Score(fmMain.LSubScore[0]).Sub01_No+IntToStr(KK)) as TQRLabel).Caption := SAns2;
      end;
    end;
  end;
  SqlStrList.Free;
end;

procedure TfmReport.QuickRep1AfterPreview(Sender: TObject);
begin
  EnumStu:= fmMain.LStudentDetail.GetEnumerator;
end;

procedure TfmReport.QuickRep1AfterPrint(Sender: TObject);
begin
  EnumStu:= fmMain.LStudentDetail.GetEnumerator;
end;

procedure TfmReport.QuickRep1NeedData(Sender: TObject; var MoreData: Boolean);
begin
  MoreData:= EnumStu.MoveNext;
end;

procedure TfmReport.CreateQRLabel_2(L,T,W,H:Integer;N,C:string);
var
  obj: TQRLabel;
begin
  obj:= TQRLabel.create(self);
  obj.Parent:= QRBand1;
  obj.AutoSize:= False;
  obj.Left:= L;
  obj.Top:= T;
  obj.Width:= W;
  obj.Height:= H;
  obj.Caption:= C;
  obj.Name:= N;
  obj.Tag := 1;
  obj.Font.Charset := ANSI_CHARSET;
  obj.Font.Name := 'Courier New';
  obj.Font.Size:= 14;
  obj.Alignment:= taLeftJustify;
  obj.Transparent:= True;
  obj.ParentFont:= False;
end;

function TfmReport.ChangeCode(Code: string): String;
var
  Ans : String;
begin
  Ans := DelSpc(Code);
  if (Ans = 'A____') or (Ans = '1____') or (Ans = 'A') or (Ans = '1') then
    Result :='A'
  else if (Ans = '_B___') or (Ans = '_2___') or (Ans = 'B') or (Ans = '2') then
    Result :='B'
  else if (Ans = '__C__') or (Ans = '__3__') or (Ans = 'C') or (Ans = '3') then
    Result :='C'
  else if (Ans = '___D_') or (Ans = '___4_') or (Ans = 'D') or (Ans = '4') then
    Result :='D'
  else if (Ans = '____E') or (Ans = '____5') or (Ans = 'E') or (Ans = '5') then
    Result :='E'
  else if (Ans = 'AB___') or (Ans = '12___') or (Ans = 'AB') or (Ans = '12') then
    Result :='F'
  else if (Ans = 'A_C__') or (Ans = '1_3__') or (Ans = 'AC') or (Ans = '13') then
    Result :='G'
  else if (Ans = 'A__D_') or (Ans = '1__4_') or (Ans = 'AD') or (Ans = '14') then
    Result :='H'
  else if (Ans = 'A___E') or (Ans = '1___5') or (Ans = 'AE') or (Ans = '15') then
    Result :='I'
  else if (Ans = '_BC__') or (Ans = '_23__') or (Ans = 'BC') or (Ans = '23') then
    Result :='J'
  else if (Ans = '_B_D_') or (Ans = '_2_4_') or (Ans = 'BD') or (Ans = '24') then
    Result :='K'
  else if (Ans = '_B__E') or (Ans = '_2__5') or (Ans = 'BE') or (Ans = '25') then
    Result :='L'
  else if (Ans = '__CD_') or (Ans = '__34_') or (Ans = 'CD') or (Ans = '34') then
    Result :='M'
  else if (Ans = '__C_E') or (Ans = '__3_5') or (Ans = 'CE') or (Ans = '35') then
    Result :='N'
  else if (Ans = '___DE') or (Ans = '___45') or (Ans = 'DE') or (Ans = '45') then
    Result :='O'
  else if (Ans = 'ABC__') or (Ans = '123__') or (Ans = 'ABC') or (Ans = '123') then
    Result :='P'
  else if (Ans = 'AB_D_') or (Ans = '12_4_') or (Ans = 'ABD') or (Ans = '124') then
    Result :='Q'
  else if (Ans = 'AB__E') or (Ans = '12__5') or (Ans = 'ABE') or (Ans = '125') then
    Result :='R'
  else if (Ans = 'A_CD_') or (Ans = '1_34_') or (Ans = 'ACD') or (Ans = '134') then
    Result :='S'
  else if (Ans = 'A_C_E') or (Ans = '1_3_5') or (Ans = 'ACE') or (Ans = '135') then
    Result :='T'
  else if (Ans = 'A__DE') or (Ans = '1__45') or (Ans = 'ADE') or (Ans = '145') then
    Result :='U'
  else if (Ans = '_BCD_') or (Ans = '_234_') or (Ans = 'BCD') or (Ans = '234') then
    Result :='V'
  else if (Ans = '_BC_E') or (Ans = '_23_5') or (Ans = 'BCE') or (Ans = '235') then
    Result :='W'
  else if (Ans = '_B_DE') or (Ans = '_2_45') or (Ans = 'BDE') or (Ans = '245') then
    Result :='X'
  else if (Ans = '__CDE') or (Ans = '__345') or (Ans = 'CDE') or (Ans = '345') then
    Result :='Y'
  else if (Ans = 'ABCD_') or (Ans = '1234_') or (Ans = 'ABCD') or (Ans = '1234') then
    Result :='Z'
  else if (Ans = 'ABC_E') or (Ans = '123_5') or (Ans = 'ABCE') or (Ans = '1235') then
    Result :='*'
  else if (Ans = 'AB_DE') or (Ans = '12_45') or (Ans = 'ABDE') or (Ans = '1245') then
    Result :='$'
  else if (Ans = 'A_CDE') or (Ans = '1_345') or (Ans = 'ACDE') or (Ans = '1345') then
    Result :='%'
  else if (Ans = '_BCDE') or (Ans = '_2345') or (Ans = 'BCDE') or (Ans = '2345') then
    Result :='='
  else if (Ans = 'ABCDE') or (Ans = '12345') then
    Result :='#'
  else if (Ans = '0')  then
    Result :='0'
  else if (Ans = '6')  then
    Result :='6'
  else if (Ans = '7')  then
    Result :='7'
  else if (Ans = '8')  then
    Result :='8'
  else if (Ans = '9')  then
    Result :='9'
  else
    Result :='\';
end;

function TfmReport.DelSpc(InputData: string): String;
var
  m: Word;
begin
  InputData:= UpperCase(Trim(InputData));
  Result:= '';
  for m:= 1 to Length(InputData) do
  begin
    if (Copy(InputData, m, 1) <> ' ') then
    begin
      Result:= Result + Copy(InputData, m, 1);
    end;
  end;  // for m:= 1 to Length(InputData) do
end;

function TfmReport.StringReturn(ConvertString:string): string;
var
  LChar: Char;
  CarriageString: Char;
begin
  StringReturn:= EmptyStr;
  CarriageString:=Char(13);
  for LChar in ConvertString do
  begin
    Result:= Result + LChar + CarriageString;
  end;
end;

function TfmReport.AnsReturn(ConvertString:string): String;
var
  CarriageString: Char;
  LChar: Char;
begin
  Result:= EmptyStr;
  CarriageString:= Char(13);
  for LChar in ConvertString do
  begin
    if (LChar = 'o') or (LChar=#32) then
      Result:= Result + LChar
    else
      Result:= Result + LChar + CarriageString;
  end;
end;

function TfmReport.CationReturn(CationStr: string; Index:Integer): String;
var
  CarriageString: Char;
  LChar: Char;
  I: Integer;
begin
  Result:= EmptyStr;
  CarriageString:= Char(13);
  I:= 0;
  for LChar in CationStr do
  begin
    Inc(I);
    if I = Index then
      Result:= Result + LChar + CarriageString + #$A
    else
      Result:= Result + LChar;
  end;
end;

end.
