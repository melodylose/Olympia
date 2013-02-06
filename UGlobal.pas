unit UGlobal;

interface

uses
  ADODB, Generics.Collections, Generics.Defaults, SysUtils, Classes, Graphics,
  StdCtrls, StrUtils, XMLDoc, XMLIntf, ComCtrls, Forms, IniFiles, jpeg, Windows;

type

// delegates func
  TProc<T> = procedure (n : T) of object;
  TProcList<T> = procedure (n : TList<T>) of object;
  TFunc<T> = reference to function(): T;
  TFuncParam<T, TResult> = reference to function(param: T): TResult;
  TFuncList<T, TResult> = reference to function(n : TList<T>): TResult;
  TFuncListSelect<T, TResult> = reference to function(n: TList<T>): TList<T>;

  procedure XMLTree(XMLDoc : TXMLDocument);
  procedure XMLSave(XMLDoc : TXMLDocument; Attribute: TStringList);
  procedure SqlOpen(Query: TADOQuery; SqlString: string);
  procedure SqlExec(Query: TADOQuery; SqlString: string);
  procedure LoadINI(fPath:String);
  procedure SaveINI(fPath, sD, sY, sT, sU, sP, sS :String);

  function GetZeroString(eNum:Integer; Count:Integer): String;
  function AnsReturn(AnsString: string): String;
  function CheckAwardsImport(Exam_No: string): Boolean;
  function CheckStrucImport(Exam_No: string): Boolean;
  function CheckStrucName: Boolean;
  function RepeatSubName(Sender: TObject): Boolean;
  function BMPtoJPG(var BMPpic, JPGpic: string):boolean;

const
  AccessStr = 'Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password=seat;Data Source=';

var
  SqlStr:String;
  Attribute: TStringList;
  Bitmap: Graphics.TBitmap;
  JpegImg: TJpegImage;
//  Tif: TTIFFImage;

implementation

uses UDM, UMain;

procedure SaveINI(fPath, sD, sY, sT, sU, sP, sS :String);
var
  Ini: TIniFile;
  hWnd: Integer;
  AItem : Boolean;
begin
  fPath := fPath+'_Data';
  AItem := True;
  if not DirectoryExists(fPath) then   //判斷存檔目錄是否存在,不存在則創建檔案
  begin
    ForceDirectories(fPath); //新增目錄
    hWnd := FileCreate(fPath+'\SMCC.ini');
    FileClose(hWnd);
    AItem := False;
  end;
  try
    Ini := TIniFile.Create(fPath+'\SMCC.ini');  //建立物件
    Ini.WriteString('DetailData', 'TermNo',sT);  //寫入INI檔案 (分項,變數名稱,內容值)
    Ini.WriteString('DetailData', 'TYear', sY);
    Ini.WriteString('DetailData', 'Depart', sD);  //寫入INI檔案 (分項,變數名稱,內容值)
    Ini.WriteString('DetailData', 'UserName', sU);
    Ini.WriteString('DetailData', 'PassWord', sP);  //寫入INI檔案 (分項,變數名稱,內容值)
    Ini.WriteString('DetailData', 'Sname', sS);
    if not AItem then
     Ini.WriteString('DetailData', 'Item','');


  finally
    Ini.Free; //釋放物件
  end;
end;

procedure LoadINI(fPath:String);
var
  aIni:TInifile;
begin
  if not FileExists(fPath+'_Data\SMCC.ini') then   //判斷檔案是否存在
  begin
    Application.MessageBox('使用者設定檔遺失！！', '訊息', MB_OK + MB_ICONWARNING);
    Exit;
  end;

  try
    // 讀取 *.ini 檔
    //aIni := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini' ) );
    aIni := TIniFile.Create(fPath+'_Data\SMCC.ini');//路徑+檔名.INI
    //aIni.WriteString('SysConfig2','Test','TTTTT');

    fmMain.sTerm := Copy(Trim(aIni.ReadString('DetailData','TermNo','')),1,1);      //
    fmMain.sTYear := Trim(aIni.ReadString('DetailData','TYear',''));      //
//    fmMain.sDepart := Trim(aIni.ReadString('DetailData','Depart',''));    //
    fmMain.sUser := Trim(aIni.ReadString('DetailData','UserName',''));    //
    fmMain.sPW := Trim(aIni.ReadString('DetailData','PassWord',''));      //
//    fmMain.sName := Trim(aIni.ReadString('DetailData','Sname',''));      //
//    fmMain.ItemOn := Trim(aIni.ReadString('DetailData','ItemOn',''));      //使否隱藏標準版流程
//    fmMain.sUpdate := Trim(aIni.ReadString('DetailData','sUpdate',''));  // add by ken 20121001 是否顯示資料庫更新功能
  finally
    aIni.Free;
  end;
end;


procedure SqlOpen(Query: TADOQuery; SqlString: string);
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add(SqlString);
  Query.Open;
end;

procedure SqlExec(Query: TADOQuery; SqlString: string);
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add(SqlString);
  Query.ExecSQL;
end;

function GetZeroString(eNum:Integer; Count:Integer): String;
begin
  Result:= Format('%0.*d',[Count,eNum]);
end;

function AnsReturn(AnsString: string): String;
var
  LChar: Char;
  CommStr: Char;
begin
  Result:= EmptyStr;
  CommStr:= Char(44);
  for LChar in AnsString do
  begin
    Result:= Result + LChar + CommStr;
  end;
end;

function CheckAwardsImport(Exam_No: string): Boolean;
var
  ResultStu: TStringList;
  I: Integer;
  J: Integer;
begin
  ResultStu:= TStringList.Create;
  Result:= False;

  SqlStr:= 'SELECT Distinct Student_No FROM StudentAward';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);

  while NOT DM.adoQueryTempAnaly.Eof do
  begin
    ResultStu.Add(DM.adoQueryTempAnaly.FieldByName('Student_No').AsString);
    DM.adoQueryTempAnaly.Next;
  end;

  Result:= ResultStu.Count > 0;
  if Result then
  begin
    fmMain.lbCheckAwards.Caption:='學生獎項已匯入';
    fmMain.lbCheckAwards.Font.Color:= clGreen;
  end
  else
  begin
    fmMain.lbCheckAwards.Caption:='學生獎項未匯入';
    fmMain.lbCheckAwards.Font.Color:= clRed;
  end;
  ResultStu.Free;
end;

function CheckStrucImport(Exam_No: string): Boolean;
begin
  Result:= False;
  SqlStr:= ' select sum(A.cnt) as Cnt FROM '+
           ' (SELECT COUNT(Distinct Ser_No) as Cnt, Sub_No FROM Tb_ExamStruc WHERE'+
           ' Exam_No='+QuotedStr(fmMain.cbExam_No.Text)+
           ' and sub_no in ('+QuotedStr(fmMain.cbSubNo01.Text)+
           ', '+QuotedStr(fmMain.cbSubNo02.Text) + ') GROUP BY Sub_No ) A';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);

  SqlStr:= 'select count(*) as cnt from Exam_Question where' +
           ' Exam_No='+QuotedStr(fmMain.cbExam_No.Text)+
           ' and sub_no in ('+QuotedStr(fmMain.cbSubNo01.Text)+
           ', '+QuotedStr(fmMain.cbSubNo02.Text) + ')';
  SqlOpen(DM.adoQueryTempEx, SqlStr);

  if NOT (DM.adoQueryTempAnaly.IsEmpty and DM.adoQueryTempEx.IsEmpty) then

  if DM.adoQueryTempAnaly.FieldByName('Cnt').AsInteger <> 0 then
    Result:= DM.adoQueryTempAnaly.FieldByName('Cnt').AsInteger = DM.adoQueryTempEx.FieldByName('cnt').AsInteger;
  if Result then
  begin
    fmMain.lbStrucImport.Caption:= '指標結構已匯入';
    fmMain.lbStrucImport.Font.Color:= clGreen;
  end
  else
  begin
    fmMain.lbStrucImport.Caption:= '指標結構未匯入';
    fmMain.lbStrucImport.Font.Color:= clRed;
  end;
end;

function CheckStrucName: Boolean;
begin
  Result:= False;
  SqlStr:='SELECT COUNT(*) as Cnt FROM Tb_Struc';
  SqlOpen(DM.adoQueryTempAnaly, SqlStr);
  if NOT DM.adoQueryTempAnaly.IsEmpty then
    Result:= DM.adoQueryTempAnaly.FieldByName('Cnt').AsInteger > 0;
  if Result then
  begin
    fmMain.lbStrucName.Caption:= '指標名稱已匯入';
    fmMain.lbStrucName.Font.Color:= clGreen;
  end
  else
  begin
    fmMain.lbStrucName.Caption:= '指標名稱未匯入';
    fmMain.lbStrucName.Font.Color:= clRed;
  end;
end;

function RepeatSubName(Sender: TObject): Boolean;
begin
  TComboBox(fmMain.FindComponent('cbSubNo'+RightStr((Sender as TComboBox).Name,2))).Clear;
  while NOT DM.adoQueryTempEx.Eof do
  begin
    TComboBox(fmMain.FindComponent('cbSubNo'+RightStr((Sender as TComboBox).Name,2)))
    .AddItem(DM.adoQueryTempEx.FieldByName('Sub_No').AsString, nil);
    DM.adoQueryTempEx.Next;
  end;
  TComboBox(fmMain.FindComponent('cbSubNo'+RightStr((Sender as TComboBox).Name,2))).ItemIndex:= 0;
  RepeatSubName:= TComboBox(fmMain.FindComponent('cbSubNo'+RightStr((Sender as TComboBox).Name,2))).Items.Count > 1;

end;

procedure XMLTree(XMLDoc : TXMLDocument);
  var
  jNode: IXMLNode;
  procedure ProcessNode(Node: IXMLNode; tn: TTreeNode);
  var
    cNode: IXMLNode;
  begin
    if Node = nil then Exit;
    Attribute.Add(Node.NodeName + '=' + Node.Attributes['name']);
    cNode:= Node.ChildNodes.First;
    while cNode <> nil do
    begin
      ProcessNode(cNode, tn);
      cNode:= cNode.NextSibling;
    end;
  end;
begin
  XMLDoc.FileName:= ChangeFileExt(ParamStr(0),'.XML');
  XMLDoc.Active:=True;

  if XMLDoc.ChildNodes.First = nil then
  begin
    Application.MessageBox(PCHAR('設定檔錯誤'),'錯誤',MB_OK or MB_ICONERROR);
    Exit;
  end;

  jNode:= XMLDoc.DocumentElement.ChildNodes.First;
  while Assigned(jNode) do
  begin
    ProcessNode(jNode,nil);
    jNode:=jNode.NextSibling;
  end;
  XMLDoc.Active:= False;
end;

procedure XMLSave(XMLDoc : TXMLDocument; Attribute: TStringList);
  procedure ProcessNode(Node: IXMLNode; Attribute:TStringList);
  begin
    if Attribute = nil then Exit;
    Node.Attributes['name']:=Attribute.Values[Node.NodeName];
  end;
var
  iNode: IXMLNode;
begin
  XMLDoc.FileName := ChangeFileExt(ParamStr(0),'.xml');
  XMLDoc.Active := True;
  iNode:=XMLDoc.DocumentElement.ChildNodes.First;

  while iNode <> nil do
  begin
    ProcessNode(iNode,Attribute);
    iNode:= iNode.NextSibling;
  end;

  XMLDoc.SaveToFile(ChangeFileExt(ParamStr(0),'.xml'));
  XMLDoc:=nil;
end;

function BMPtoJPG(var BMPpic, JPGpic: string):boolean;
begin
  Result:=False;
  Bitmap := Graphics.TBitmap.Create;
  try
   Bitmap.LoadFromFile(BMPpic) ;
   JpegImg := TJpegImage.Create;
   try
    JpegImg.Assign(Bitmap) ;
    JpegImg.SaveToFile(JPGpic) ;
    Result:=True;
   finally
    JpegImg.Free
   end;
  finally
   Bitmap.Free
  end;
end;

end.
