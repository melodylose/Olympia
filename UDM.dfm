object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 413
  Width = 453
  object adoConnectforEx: TADOConnection
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object adoQueryTempEx: TADOQuery
    Connection = adoConnectforEx
    Parameters = <>
    Left = 130
    Top = 16
  end
  object adoQueryEx: TADOQuery
    Connection = adoConnectforEx
    Parameters = <>
    Left = 206
    Top = 16
  end
  object adoConnectforAnaly: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 80
  end
  object adoQueryTempAnaly: TADOQuery
    Connection = adoConnectforAnaly
    Parameters = <>
    Left = 152
    Top = 80
  end
  object adoQueryAnaly: TADOQuery
    Connection = adoConnectforAnaly
    Parameters = <>
    Left = 256
    Top = 80
  end
  object adoConnectforSys: TADOConnection
    LoginPrompt = False
    Left = 40
    Top = 152
  end
  object adoQueryTempSys: TADOQuery
    Connection = adoConnectforSys
    Parameters = <>
    Left = 152
    Top = 153
  end
  object adoQuerySys: TADOQuery
    Connection = adoConnectforSys
    Parameters = <>
    Left = 256
    Top = 153
  end
  object adoConnectforSch: TADOConnection
    Left = 40
    Top = 224
  end
  object adoQueryTempSch: TADOQuery
    Connection = adoConnectforSch
    Parameters = <>
    Left = 144
    Top = 224
  end
  object adoQuerySch: TADOQuery
    Connection = adoConnectforSch
    Parameters = <>
    Left = 232
    Top = 224
  end
  object conn: TADOConnection
    Left = 40
    Top = 296
  end
  object adods: TADODataSet
    Connection = conn
    Parameters = <>
    Left = 144
    Top = 296
  end
end
