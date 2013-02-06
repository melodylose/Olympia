unit IQueryList;

interface

uses
  UGlobal, Generics.Defaults, Generics.Collections;

type
  IQueryList<T, TResult> = interface
    function Where(const param: TFuncParam<T,TResult>): IQueryList<T, TResult>;
    function OrderBy(const AComparer: IComparer<T>): IQueryList<T, TResult>;
    function Select(const param: TFuncListSelect<T,TResult>): IQueryList<T, TResult>;
    function FillList(const param: TFuncList<T,TResult>): IQueryList<T, TResult>;
    function Distinct(): IQueryList<T, TResult>;
    function List(): TList<T>;
  end;

  TQueryList<T, TResult> = class(TInterfacedObject, IQueryList<T,TResult>)
    private
      FList:TList<T>;
    protected
      function Where(const param: TFuncParam<T,TResult>): IQueryList<T, TResult>;
      function FillList(const param: TFuncList<T,TResult>): IQueryList<T, TResult>;
      function Select(const param:TFuncListSelect<T,TResult>): IQueryList<T, TResult>;
      function Distinct():IQueryList<T, TResult>;
      function List():TList<T>;
      function OrderBy(const AComparer: IComparer<T>): IQueryList<T, TResult>;
    public
      constructor Create();
      destructor Destroy(); override;
      class function New: IQueryList<T, TResult>;
  end;


implementation

{ TQueryList<T, TResult> }

constructor TQueryList<T, TResult>.Create;
begin
  FList:= TList<T>.Create;
end;

destructor TQueryList<T, TResult>.Destroy;
begin
  if Assigned(FList) then
    FList.Free;
  inherited;
end;

function TQueryList<T, TResult>.Distinct: IQueryList<T, TResult>;
var
  list: TList<T>;
  I: Integer;
begin
  list:= TList<T>.Create;
  for I := 0 to FList.Count - 1 do
  begin
    if not list.Contains(FList[I]) then
      list.Add(FList[I]);
  end;
  FList.Free;
  FList:= list;
  Result:= Self;
end;

function TQueryList<T, TResult>.FillList(
  const param: TFuncList<T, TResult>): IQueryList<T, TResult>;
begin
  param(FList);
  Result:= Self;
end;

function TQueryList<T, TResult>.List: TList<T>;
begin
  Result:= FList;
end;

class function TQueryList<T, TResult>.New: IQueryList<T, TResult>;
begin
  Result:= Create;
end;

function TQueryList<T, TResult>.OrderBy(
  const AComparer: IComparer<T>): IQueryList<T, TResult>;
begin
  FList.Sort(AComparer);
  Result:= Self;
end;

function TQueryList<T, TResult>.Select(
  const param: TFuncListSelect<T, TResult>): IQueryList<T, TResult>;
begin
  Flist:= param(FList);
  Result:= Self;
end;

function TQueryList<T, TResult>.Where(
  const param: TFuncParam<T, TResult>): IQueryList<T, TResult>;
var
  list: TList<T>;
  Comparer: IEqualityComparer<TResult>;
  I: Integer;
begin
  list:= TList<T>.Create();
  for I := 0 to FList.Count - 1 do
  begin
    Comparer:= TEqualityComparer<TResult>.Default;
    if not Comparer.Equals(Default(TResult), param(FList[I])) then
      list.Add(FList[I]);
  end;
  FList.Free;
  FList:= list;
  Result:= Self;
end;

end.
