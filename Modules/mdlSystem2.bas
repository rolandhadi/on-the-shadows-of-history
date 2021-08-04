Attribute VB_Name = "mdlSystem2"
Option Explicit
Option Base 1
Option Compare Text
Public BlankTheScreen As Boolean

Public Type WorldItemStruct
  ItemEnable As Boolean
  ItemName As String
  ItemCaption As String
  ItemDetail As String
  ItemPreview As String
End Type: Public WorldItems() As WorldItemStruct
Public NumItems As Integer

Public Type WorldTaskStruct
  TasKNum As Integer
  TaskName As String
  TaskInfo As String
End Type: Public WorldTask() As WorldTaskStruct
Public NumTask As Integer, CurTaskName As String

Public ItemsShown As Boolean, GameTime As Long, LastGameTick As Long

Public Type Files
  FileName As String
  FileNumber As Integer
End Type: Public FileOpenList(50) As Files, NumOpFiles As Integer

Public Sub MessageBox(Msg As String, Prompt As Boolean)
Dim i%, j%, ExitMenu As Boolean
DX_Input
'
If Prompt = True Then
  PlaySound "Msg"
  Do Until ExitMenu = True
      DX_Input
      
      bRestore = False
      Do Until ExModeActive
          DoEvents
          bRestore = True
      Loop
      
      DoEvents
      If bRestore Then
          RefreshScreen
          bRestore = False
          DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us.
      End If
      
      DS_Back.SetForeColor RGB(0, 0, 0)
      On Local Error Resume Next 'Incase there is an error
      DoEvents 'Give the computer time to do what it needs to do.
      If ItemsShown = False Then
        D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
        D3D_Device.Update 'Update the Direct3D Device.
        D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
      End If
      i = GetSpriteIndex("Footer")
      DS_Back.BltFast 0, 480 - 110, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      Message Msg
      i = GetSpriteIndex("Bunny")
      WorldSprite(i).SRect = AnimCompass(West)
      DS_Back.BltFast 640 - 64, 410, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      DS_Back.DrawText ScreenText.SPos.x, ScreenText.SPos.y, ScreenText.SMessage, False
      If ScreenText2.SMessage <> "" Then DS_Back.DrawText ScreenText2.SPos.x, ScreenText2.SPos.y, ScreenText2.SMessage, False
      DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
      CheckBGMusicLoop
      
      DS_Back.SetForeColor RGB(255, 255, 255)
      Wait 100
      DX_Input
      If DI_MSTATE.buttons(0) <> 0 Then
        ExitMenu = True
        PlaySound "Msg"
        DX_Input
        Wait 200
      ElseIf DI_KSTATE.Key(WorldControl.Interact) <> 0 Then
        ExitMenu = True
        PlaySound "Msg"
        DX_Input
        Wait 200
      End If
      
  Loop
  DX_Input
  Wait 100
Else
      DS_Back.SetForeColor RGB(0, 0, 0)
      i = GetSpriteIndex("Footer")
      DS_Back.BltFast 0, 480 - 110, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      Message Msg
      DS_Back.DrawText ScreenText.SPos.x, ScreenText.SPos.y, ScreenText.SMessage, False
      If ScreenText2.SMessage <> "" Then DS_Back.DrawText ScreenText2.SPos.x, ScreenText2.SPos.y, ScreenText2.SMessage, False
      DS_Back.SetForeColor RGB(255, 255, 255)
End If
End Sub

Public Function SwitchEnabled(Sname As String) As Boolean
Dim i As Integer
If SwitchPresent(Sname) = True Then
  If WorldSwitch(GetSwitchIndex(Sname)).SwitchEnable = True Then SwitchEnabled = True
End If
End Function

Public Function GetSwitchIndex(Sname As String) As Integer
Dim i As Integer
For i = 1 To UBound(WorldSwitch)
  If WorldSwitch(i).SwitchName = Sname Then
    GetSwitchIndex = i
    Exit Function
  End If
Next
'LoadSwitch Sname, "Off"
'GetSwitchIndex = GetSwitchIndex(Sname)
End Function

Public Sub LoadSwitch(Sname As String, SEnable As String)
If SwitchPresent(Sname) = False Then
  ReDim Preserve WorldSwitch(NumSwitch)
  If SEnable = ON_ Then
    WorldSwitch(NumSwitch).SwitchEnable = True
  Else
    WorldSwitch(NumSwitch).SwitchEnable = False
  End If
  WorldSwitch(NumSwitch).SwitchName = Sname
  WorldSwitch(NumSwitch).SwitchNum = NumSwitch
  NumSwitch = NumSwitch + 1
  End If
End Sub

Public Function SwitchPresent(Sname As String) As Boolean
Dim i As Integer
For i = 1 To UBound(WorldSwitch)
  If WorldSwitch(i).SwitchName = Sname Then
    SwitchPresent = True
    Exit Function
  End If
Next
SwitchPresent = False
End Function

Public Function ItemPresent(IName As String) As Boolean
Dim i As Integer
If IName = "" Then ItemPresent = False: Exit Function
For i = 1 To UBound(WorldItems)
  If WorldItems(i).ItemName = IName Then
    ItemPresent = True
    Exit Function
  End If
Next
ItemPresent = False
End Function

Public Sub LoadItem(IName As String, ICAPTION As String, IDETAIL As String, IPREVIEW As String, Ienable As Boolean)
Dim tmpNum As Integer
If ItemPresent(IName) = False Then
  ReDim Preserve WorldItems(NumItems)
  WorldItems(NumItems).ItemName = IName
  
  If Left(ICAPTION, 1) = "&" Then
    WorldItems(NumItems).ItemCaption = GetMessage(CurLangLetter, Right(ICAPTION, Len(ICAPTION) - 1))
  Else
    WorldItems(NumItems).ItemCaption = ICAPTION
  End If
  If Len(WorldItems(NumItems).ItemCaption) >= 80 Then WorldItems(NumItems).ItemCaption = ". " & WorldItems(NumItems).ItemCaption
  
  WorldItems(NumItems).ItemPreview = IPREVIEW
  
  If Left(IDETAIL, 1) = "&" Then
    WorldItems(NumItems).ItemDetail = GetMessage(CurLangLetter, Right(IDETAIL, Len(IDETAIL) - 1))
  Else
    WorldItems(NumItems).ItemDetail = IDETAIL
  End If
  If Len(WorldItems(NumItems).ItemDetail) >= 80 Then WorldItems(NumItems).ItemDetail = ". " & WorldItems(NumItems).ItemDetail
  
  WorldItems(NumItems).ItemEnable = Ienable
  NumItems = NumItems + 1
Else
  tmpNum = GetItemIndex(IName)
  WorldItems(tmpNum).ItemName = IName
  WorldItems(tmpNum).ItemCaption = ICAPTION
  WorldItems(tmpNum).ItemPreview = IPREVIEW
  WorldItems(tmpNum).ItemDetail = IDETAIL
  WorldItems(tmpNum).ItemEnable = Ienable
End If
End Sub

Public Function GetItemIndex(IName As String) As Integer
Dim i As Integer
For i = 1 To UBound(WorldItems)
  If WorldItems(i).ItemName = IName Then
    GetItemIndex = i
    Exit Function
  End If
Next
End Function

Public Sub LoadItemFromFile(IName As String, Ienable As Boolean)
Dim FileNum As Integer, Intext As String, tmpVal As XVal
Dim tmp As String, i As Integer, SCopy As Boolean, tmpEvent As String
Dim tmpItem As WorldItemStruct, tmpSwitch As String, SOn As String
FileNum = FreeFile
AddFile IName, FileNum
  Open App.Path & "\Items\" & IName & ".txt" For Input As FileNum
  tmpItem.ItemName = IName
  Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
        Select Case (tmp)
          Case ICAPTION
            tmpItem.ItemCaption = tmpVal.val1
          Case IDETAIL
            tmpItem.ItemDetail = tmpVal.val1
          Case IPREVIEW
            tmpItem.ItemPreview = tmpVal.val1
          Case SWITCH
            tmpSwitch = tmpVal.val1
            SOn = tmpVal.val2
        End Select
    End If
  Loop
  Close #FileNum
  LoadItem tmpItem.ItemName, tmpItem.ItemCaption, tmpItem.ItemDetail, tmpItem.ItemPreview, Ienable
  LoadSwitch tmpSwitch, SOn
            If Ienable = True Then
              InsertItem tmpItem.ItemName
              LoadSprite tmpItem.ItemName, 24, 24
            Else
              DeleteItem tmpItem.ItemName
            End If
End Sub

Public Function GetSwitchesAndItems() As String
  Dim i As Integer, tmpStr As String
  
  For i = LBound(WorldItems) To UBound(WorldItems)
    If WorldItems(i).ItemName <> "" Then
      tmpStr = tmpStr & ITEM & ": " & WorldItems(i).ItemName & ", " & GetState(WorldItems(i).ItemEnable) & Chr(13) + Chr(10)
    End If
  Next
  
  For i = LBound(WorldSwitch) To UBound(WorldSwitch)
    If WorldSwitch(i).SwitchName <> "" Then
    tmpStr = tmpStr & SWITCH & ": " & WorldSwitch(i).SwitchName & ", " & GetState(WorldSwitch(i).SwitchEnable) & Chr(13) + Chr(10)
    End If
  Next
  
  GetSwitchesAndItems = tmpStr
End Function

Public Function GetState(Bool As Boolean) As String
  If Bool = True Then
    GetState = ON_
  Else
    GetState = "OFF"
  End If
End Function

Public Function GetON(Bool As String) As Boolean
  If Bool = ON_ Then
    GetON = True
  Else
    GetON = False
  End If
End Function

Public Sub CloseFile(FName As String)
  Dim i As Integer
  For i = 1 To 50
    If FileOpenList(i).FileName = FName Then
      Close #FileOpenList(i).FileNumber
      FileOpenList(i).FileName = ""
    End If
  Next
End Sub

Public Sub AddFile(FName As String, FileNum)
If NumOpFiles = 0 Then NumOpFiles = 1
  If NumOpFiles > 50 Then
    NumOpFiles = 1
    FileOpenList(NumOpFiles).FileName = FName
    FileOpenList(NumOpFiles).FileNumber = FileNum
    NumOpFiles = NumOpFiles + 1
  Else
    FileOpenList(NumOpFiles).FileName = FName
    FileOpenList(NumOpFiles).FileNumber = FileNum
    NumOpFiles = NumOpFiles + 1
  End If
End Sub

Public Sub CopyAllEvents()
Dim MyPath As String, MyName As String, MPath As String
On Error Resume Next
Kill App.Path & "\Events\*.txt"
MPath = App.Path & "\Events\"
MyPath = App.Path & "\OrigEvents\"
MyName = Dir(MyPath, vbNormal) ' Retrieve the first entry.
Do While MyName <> "" ' Start the loop.
  ' Ignore the current directory and the encompassing directory.
  If MyName <> "." And MyName <> ".." Then
    FileCopy MyPath & MyName, MPath & MyName
  End If
  MyName = Dir  ' Get next entry.
Loop
Close
End Sub

Public Sub UpdateGameTimer()
If GetTickCount() - LastGameTick >= 1000 Then
  GameTime = GameTime + 1
  LastGameTick = GetTickCount
End If
End Sub

Public Sub ShowTask(TaskName As String)
If TaskPresent(TaskName) = True Then
MessageBox WorldTask(GetTaskIndex(TaskName)).TaskInfo, True
Else
MessageBox "............", True
End If
End Sub

Public Function TaskPresent(TaskName As String) As Boolean
Dim i As Integer
For i = 1 To UBound(WorldTask)
  If WorldTask(i).TaskName = TaskName Then
    TaskPresent = True
    Exit Function
  End If
Next
End Function

Public Function GetTaskIndex(TaskName As String) As Integer
Dim i As Integer
For i = 1 To UBound(WorldTask)
  If WorldTask(i).TaskName = TaskName Then
    GetTaskIndex = i
    Exit Function
  End If
Next
End Function

Public Sub LoadTask()
Dim FileNum As Integer, Intext As String, tmpVal As XVal
Dim tmp As String, i As Integer
FileNum = FreeFile
  Open App.Path & "\OrigEvents\" & "Tasks" & ".txt" For Input As FileNum
  Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
        Select Case Trim((tmp))
          Case TASK
            ReDim Preserve WorldTask(NumTask)
            WorldTask(NumTask).TasKNum = NumTask
            WorldTask(NumTask).TaskName = tmpVal.val1
            If Left(tmpVal.val2, 1) = "&" Then
              WorldTask(NumTask).TaskInfo = GetMessage(CurLangLetter, Right(tmpVal.val2, Len(tmpVal.val2) - 1))
              If Len(WorldTask(NumTask).TaskInfo) >= 80 Then WorldTask(NumTask).TaskInfo = ". " & WorldTask(NumTask).TaskInfo
            Else
              WorldTask(NumTask).TaskInfo = tmpVal.val2
            End If
            NumTask = NumTask + 1
        End Select
    End If
  Loop
  Close #FileNum
End Sub

Public Sub ShowBlankScreen()
Dim i As Integer
LoadSprite "BlankScreen", 480, 640
            On Local Error Resume Next 'Incase there is an error
            DoEvents 'Give the computer time to do what it needs to do.
            DS_Back.SetForeColor RGB(255, 255, 255)
            D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
            D3D_Device.Update 'Update the Direct3D Device.
            D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
            i = GetSpriteIndex("BlankScreen")
            DS_Back.BltFast 0, 0, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
            DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
            CheckBGMusicLoop
            DeleteSprite "BlankScreen"
            Wait 1000
End Sub

Public Sub ShowScores()
  Dim i%, j%, ExitMenu As Boolean
Wait 200
DX_Input
PlaySound "Menu"
LoadSprite "Score", 480, 640
Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_RETURN) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      DeleteSprite "Score"
      Wait 200
    End If
    
    bRestore = False
    Do Until ExModeActive
        DoEvents
        bRestore = True
    Loop
    
    DoEvents
    If bRestore Then
        RefreshScreen
        bRestore = False
        DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us.
    End If
    
    On Local Error Resume Next 'Incase there is an error
    DoEvents 'Give the computer time to do what it needs to do.
    DS_Back.SetForeColor RGB(255, 255, 255)
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
    If ExitMenu = False Then
      i = GetSpriteIndex("Score")
      DS_Back.SetFont SFont
      DS_Back.BltFast 0, 0, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      DS_Back.DrawText 360, 5, GetGameTime(GameTime), False
      DS_Back.DrawText 360, 70, GetNumItems, False
      DS_Back.DrawText 550, 320, GetRank, False
      DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    End If
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Sub


Public Function GetGameTime(ByVal T As Long) As String
  Dim tmpStr As String, tmpInt As Integer
  tmpStr = ""
  tmpInt = T \ 60 \ 60
  tmpStr = tmpStr & tmpInt & ":"
  tmpInt = Abs((60 * (T \ 60 \ 60)) - T \ 60)
'  tmpStr = tmpStr & tmpInt & ":"
'  tmpInt = Abs((tmpInt * 60) - T) / 100
  tmpStr = tmpStr & tmpInt
  GetGameTime = tmpStr
End Function

Public Function GetNumItems() As Integer
  GetNumItems = UBound(WorldItems)
End Function

Public Function GetRank() As String
  Dim tmpNumItems As Integer
  Dim tmpNumGTime As Integer
  tmpNumItems = GetNumItems
  tmpNumGTime = GameTime \ 60
  tmpNumGTime = tmpNumGTime \ 30
  tmpNumItems = tmpNumItems - tmpNumGTime
  Select Case tmpNumItems
    Case 25 To 30
      GetRank = "A"
    Case 20 To 24
      GetRank = "B"
    Case 15 To 19
      GetRank = "C"
    Case 10 To 14
      GetRank = "D"
    Case 5 To 9
      GetRank = "E"
    Case 0 To 4
      GetRank = "F"
  End Select
End Function

