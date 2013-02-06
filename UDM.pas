unit UDM;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM = class(TDataModule)
    adoConnectforEx: TADOConnection;
    adoQueryTempEx: TADOQuery;
    adoQueryEx: TADOQuery;
    adoConnectforAnaly: TADOConnection;
    adoQueryTempAnaly: TADOQuery;
    adoQueryAnaly: TADOQuery;
    adoConnectforSys: TADOConnection;
    adoQueryTempSys: TADOQuery;
    adoQuerySys: TADOQuery;
    adoConnectforSch: TADOConnection;
    adoQueryTempSch: TADOQuery;
    adoQuerySch: TADOQuery;
    conn: TADOConnection;
    adods: TADODataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses
  Forms;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  adoConnectforAnaly.ConnectionString:=
    'FILE NAME='+ ExtractFilePath(Application.ExeName)+ 'db.udl';
end;

end.
