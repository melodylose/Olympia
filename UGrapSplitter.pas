unit UGrapSplitter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TSplitter = class(ExtCtrls.TSplitter)
  protected
    procedure Paint; override;
  private
    fMouseIn:Boolean;
    property MouseIn : Boolean read fMouseIn;

    procedure CMMouseEnter(var AMsg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var AMsg:TMessage); message CM_MOUSELEAVE;
  end;

  TGrapSplitter = class(TForm)
    GrapSplitter: TSplitter;
  end;

var
  GrapSplitter: TGrapSplitter;

implementation

{$R *.dfm}
procedure TSplitter.Paint;
var
  R: TRect;
  X: Integer;
  Y: Integer;
  DX: Integer;
  DY: Integer;
  Brush: TBitmap;
  I: Integer;
  doTo: Integer;
begin
  R:=ClientRect;
  Canvas.Brush.Color:= Color;
  Canvas.FillRect(ClientRect);

  X:= (R.Left + R.Right) div 2;
  Y:= (R.Top + R.Bottom) div 2;

  if (Align in [alLeft,alRight]) then
  begin
    DX:= 0;
    DY:= 3;
  end
  else
  begin
    DX:= 3;
    DY:= 0;
  end;
  Brush:= TBitmap.Create;

  try
    Brush.SetSize(2,2);
    Brush.Canvas.Brush.Color:= clBtnHighlight;
    Brush.Canvas.FillRect(Rect(0,0,1,1));

    if MouseIn then
    begin
      Brush.Canvas.Pixels[0, 0]:= clBtnText;
      doTo:= 9;
      Dec(X, DX*4);
      Dec(Y, DY*4);
    end
    else
    begin
      Brush.Canvas.Pixels[0, 0]:= clBtnShadow;
      doTo:= 4;
      Dec(X, DX*2);
      Dec(Y, DY*2);
    end;

    for I := 0 to doTo do
    begin
      Canvas.Draw(X,Y,Brush);
      Inc(X, DX);
      Inc(Y, DY);
    end;
  finally
    Brush.Free;
  end;
end;

procedure TSplitter.CMMouseEnter(var AMsg: TMessage);
begin
  fMouseIn:= true;
  Refresh;
end;

procedure TSplitter.CMMouseLeave(var AMsg:TMessage);
begin
  fMouseIn:= false;
  Refresh;
end;

end.
