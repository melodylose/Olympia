unit UStrucAnaly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls;

type
  TfmStrucAnaly = class(TForm)
    pContent: TPanel;
    pContentStruc: TPanel;
    pContentAnser: TPanel;
    StrucTable: TStringGrid;
    ReadTable: TStringGrid;
    btExit: TButton;
    btCalculate: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStrucAnaly: TfmStrucAnaly;

implementation

{$R *.dfm}

procedure TfmStrucAnaly.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

end.
