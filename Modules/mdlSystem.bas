Attribute VB_Name = "mdlSystem"
Option Explicit
Option Base 1
Option Compare Text

Public CurName As String, CurBGMusic As String
Public LoadThisMap As String, ItemOnLoading As Boolean
Public WillExit As Boolean

Public Type GameKeysStruct
  Key As String
  KeyCode As Byte
End Type: Public WorldKey(37) As GameKeysStruct

Public Type GameControKeyStruct
  WalkForward As Byte
  WalkBackward As Byte
  RotateLeft As Byte
  RotateRight As Byte
  Walk_Run As Byte
  Dock As Byte
  Interact As Byte
  RotateCamLeft As Byte
  RotateCamRight As Byte
  MoveCamUp As Byte
  MoveCamDown As Byte
  LockCam As Byte
  Cancel As Byte
  Look As Byte
End Type: Public WorldControl As GameControKeyStruct

Public bRestore As Boolean

Public Sub GetConfig()
Dim FileNum As Integer, tmpPar As String, tmpVal As XVal, Intext As String
Dim tmp As String
FileNum = FreeFile
  Open App.Path & "\System.txt" For Input As FileNum
  Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
        Select Case (tmp)
          Case BGVOL
            tmpPar = tmpVal.val1
            CurBGVol = Val(tmpPar)
          Case SEVOL
            tmpPar = tmpVal.val1
            CurSEVol = Val(tmpPar)
          Case LANG
            tmpPar = tmpVal.val1
            CurLang = Val(tmpPar)
            CurLangLetter = Chr(65 + CurLang)
        End Select
    End If
  Loop
Close #FileNum
End Sub

Public Sub SaveConfig()
  Dim FileNum As Integer, tmpStr As String
  FileNum = FreeFile
  CurLang = frmOpt.lstLang.ListIndex
  Open App.Path & "\System.txt" For Output As FileNum
  tmpStr = LANG & ": " & CurLang & Chr(13) + Chr(10)
  tmpStr = tmpStr & BGVOL & ": " & frmOpt.scrBG.Value & Chr(13) + Chr(10)
  tmpStr = tmpStr & SEVOL & ": " & frmOpt.scrSE.Value & Chr(13) + Chr(10)
  tmpStr = FTextWrite(tmpStr)
  Write #FileNum, tmpStr
  Close #FileNum
  Select Case CurLang
  Case 0
    CurLangLetter = "A"
  Case 1
    CurLangLetter = "B"
  Case 2
    CurLangLetter = "C"
End Select
End Sub

Public Sub SaveKeyToFile()
  Dim FileNum As Integer, tmpStr As String
  FileNum = FreeFile
  Open App.Path & "\Keys.txt" For Output As FileNum
  tmpStr = TERMINATOR & ":" & WorldControl.WalkForward & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.WalkBackward & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.RotateLeft & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.RotateRight & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.Walk_Run & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.Dock & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.Interact & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.RotateCamLeft & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.RotateCamRight & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.MoveCamUp & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.MoveCamDown & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.LockCam & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.Cancel & Chr(13) + Chr(10)
  tmpStr = tmpStr & TERMINATOR & ":" & WorldControl.Look & Chr(13) + Chr(10)
  tmpStr = FTextWrite(tmpStr)
  Write #FileNum, tmpStr
  Close #FileNum
End Sub

Public Sub LoadKeyFromFile()
Dim FileNum As Integer, tmpPar As String, tmpVal As XVal, Intext As String
Dim tmp As String, i As Integer
FileNum = FreeFile
i = 1
  Open App.Path & "\Keys.txt" For Input As FileNum
  Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
        Select Case (tmp)
          Case TERMINATOR
            tmpPar = tmpVal.val1
            Select Case i
            Case 1
              WorldControl.WalkForward = Val(tmpPar)
            Case 2
              WorldControl.WalkBackward = Val(tmpPar)
            Case 3
              WorldControl.RotateLeft = Val(tmpPar)
            Case 4
              WorldControl.RotateRight = Val(tmpPar)
            Case 5
              WorldControl.Walk_Run = Val(tmpPar)
            Case 6
              WorldControl.Dock = Val(tmpPar)
            Case 7
              WorldControl.Interact = Val(tmpPar)
            Case 8
              WorldControl.RotateCamLeft = Val(tmpPar)
            Case 9
              WorldControl.RotateCamRight = Val(tmpPar)
            Case 10
              WorldControl.MoveCamUp = Val(tmpPar)
            Case 11
              WorldControl.MoveCamDown = Val(tmpPar)
            Case 12
              WorldControl.LockCam = Val(tmpPar)
            Case 13
              WorldControl.Cancel = Val(tmpPar)
            Case 14
              WorldControl.Look = Val(tmpPar)
            End Select
            i = i + 1
        End Select
    End If
  Loop
Close #FileNum
End Sub

Public Function FTextWrite(Txt As String) As String
  Dim tmp As String
  tmp = Chr(13) + Chr(10) & Txt & Chr(13) + Chr(10)
  FTextWrite = tmp
End Function

Public Function ExModeActive() As Boolean
    'This is used to test if we're in the correct resolution.
    Dim TestCoopRes As Long
    
    TestCoopRes = DD_Main.TestCooperativeLevel
    If WillExit = True Then ExModeActive = True: Exit Function
    If (TestCoopRes = DD_OK) Then
        ExModeActive = True
    Else
        ExModeActive = False
    End If
End Function

Public Sub IniWorldKey()
Dim i As Integer, numList As Integer
Dim j As Integer
i = 1
  For j = 65 To 65 + 25
    WorldKey(i).Key = Chr(j)
    WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  Next
  WorldKey(i).Key = "LEFT SHIFT"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "RIGHT SHIFT"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "LEFT CONTROL"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "RIGHT CONTROL"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "UP ARROW"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "DOWN ARROW"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "LEFT ARROW"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "RIGHT ARROW"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "ENTER"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "SPACE"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
  WorldKey(i).Key = "ESCAPE"
  WorldKey(i).KeyCode = GetKeyCode(WorldKey(i).Key)
    i = i + 1
End Sub

Public Function KeyName(Key As Byte) As String
   Select Case Key
   Case DIK_ESCAPE
      KeyName = "ESCAPE"
   Case DIK_1
      KeyName = "1"
   Case DIK_2
      KeyName = "2"
   Case DIK_3
      KeyName = "3"
   Case DIK_4
      KeyName = "4"
   Case DIK_5
      KeyName = "5"
   Case DIK_6
      KeyName = "6"
   Case DIK_7
      KeyName = "7"
   Case DIK_8
      KeyName = "8"
   Case DIK_9
      KeyName = "9"
   Case DIK_0
      KeyName = "0"
   Case DIK_MINUS
      KeyName = "-"
   Case DIK_EQUALS
      KeyName = "="
   Case DIK_BACK
      KeyName = "BACKSPACE"
   Case DIK_TAB
      KeyName = "TAB"
   Case DIK_Q
      KeyName = "Q"
   Case DIK_W
      KeyName = "W"
   Case DIK_E
      KeyName = "E"
   Case DIK_R
      KeyName = "R"
   Case DIK_T
      KeyName = "T"
   Case DIK_Y
      KeyName = "Y"
   Case DIK_U
      KeyName = "U"
   Case DIK_I
      KeyName = "I"
   Case DIK_O
      KeyName = "O"
   Case DIK_P
      KeyName = "P"
   Case DIK_LBRACKET
      KeyName = "["
   Case DIK_RBRACKET
      KeyName = "]"
   Case DIK_RETURN
      KeyName = "ENTER"
   Case DIK_LCONTROL
      KeyName = "LEFT CONTROL"
   Case DIK_W
      KeyName = "W"
   Case DIK_A
      KeyName = "A"
   Case DIK_S
      KeyName = "S"
   Case DIK_D
      KeyName = "D"
   Case DIK_F
      KeyName = "F"
   Case DIK_G
      KeyName = "G"
   Case DIK_H
      KeyName = "H"
   Case DIK_J
      KeyName = "J"
   Case DIK_K
      KeyName = "K"
   Case DIK_L
      KeyName = "L"
   Case DIK_SEMICOLON
      KeyName = ";"
   Case DIK_APOSTROPHE
      KeyName = "'"
   Case DIK_GRAVE
      KeyName = "`"
   Case DIK_LSHIFT
      KeyName = "LEFT SHIFT"
   Case DIK_BACKSLASH
      KeyName = "\"
   Case DIK_Z
      KeyName = "Z"
   Case DIK_X
      KeyName = "X"
   Case DIK_C
      KeyName = "C"
   Case DIK_V
      KeyName = "V"
   Case DIK_B
      KeyName = "B"
   Case DIK_N
      KeyName = "N"
   Case DIK_M
      KeyName = "M"
   Case DIK_COMMA
      KeyName = ","
   Case DIK_PERIOD
      KeyName = "."
   Case DIK_SLASH
      KeyName = "/"
   Case DIK_RSHIFT
      KeyName = "RIGHT SHIFT"
   Case DIK_MULTIPLY
      KeyName = "NUMPAD MULTIPLY"
   Case DIK_LMENU
      KeyName = "LEFT ALT"
   Case DIK_SPACE
      KeyName = "SPACE"
   Case DIK_CAPITAL
      KeyName = "CAPS LOCK"
   Case DIK_F1
      KeyName = "F1"
   Case DIK_F2
      KeyName = "F2"
   Case DIK_F3
      KeyName = "F3"
   Case DIK_F4
      KeyName = "F4"
   Case DIK_F5
      KeyName = "F5"
   Case DIK_F6
      KeyName = "F6"
   Case DIK_F7
      KeyName = "F7"
   Case DIK_F8
      KeyName = "F8"
   Case DIK_F9
      KeyName = "F9"
   Case DIK_F10
      KeyName = "F10"
   Case DIK_NUMLOCK
      KeyName = "NUM LOCK"
   Case DIK_SCROLL
      KeyName = "SCROLL LOCK"
   Case DIK_NUMPAD7
      KeyName = "NUMPAD 7"
   Case DIK_NUMPAD8
      KeyName = "NUMPAD 8"
   Case DIK_NUMPAD9
      KeyName = "NUMPAD 9"
   Case DIK_SUBTRACT
      KeyName = "NUMPAD SUBTRACT"
   Case DIK_NUMPAD4
      KeyName = "NUMPAD 4"
   Case DIK_NUMPAD5
      KeyName = "NUMPAD 5"
   Case DIK_NUMPAD6
      KeyName = "NUMPAD 6"
   Case DIK_ADD
      KeyName = "NUMPAD ADD"
   Case DIK_NUMPAD1
      KeyName = "NUMPAD 1"
   Case DIK_NUMPAD2
      KeyName = "NUMPAD 2"
   Case DIK_NUMPAD3
      KeyName = "NUMPAD 3"
   Case DIK_NUMPAD0
      KeyName = "NUMPAD 0"
   Case DIK_DECIMAL
      KeyName = "NUMPAD DECIMAL"
   Case DIK_F11
      KeyName = "F11"
   Case DIK_F12
      KeyName = "F12"
   Case DIK_F13
      KeyName = "F13"
   Case DIK_F14
      KeyName = "F14"
   Case DIK_F15
      KeyName = "F15"
   Case DIK_NUMPADENTER
      KeyName = "NUMPAD ENTER"
   Case DIK_RCONTROL
      KeyName = "RIGHT CONTROL"
   Case DIK_NUMPADCOMMA
      KeyName = "NUMPAD ,"
   Case DIK_DIVIDE
      KeyName = "/"
   Case DIK_SYSRQ
      KeyName = "PRINT SCREEN"
   Case DIK_RMENU
      KeyName = "RIGHT ALT"
   Case DIK_HOME
      KeyName = "HOME"
   Case DIK_UP
      KeyName = "UP ARROW"
   Case DIK_PRIOR
      KeyName = "PAGE UP"
   Case DIK_LEFT
      KeyName = "LEFT ARROW"
   Case DIK_RIGHT
      KeyName = "RIGHT ARROW"
   Case DIK_END
      KeyName = "END"
   Case DIK_DOWN
      KeyName = "DOWN ARROW"
   Case DIK_NEXT
      KeyName = "PAGE DOWN"
   Case DIK_INSERT
      KeyName = "INSERT"
   Case DIK_DELETE
      KeyName = "DELETE"
   Case DIK_LWIN
      KeyName = "LEFT WINDOWS"
   Case DIK_RWIN
      KeyName = "RIGHT WINDOWS"
   Case DIK_APPS
      KeyName = "APPLICATION"
   Case DIK_PAUSE
      KeyName = "PAUSE"
   End Select
End Function

Public Function GetKeyCode(Key As String) As Byte
   Select Case Key
   Case "ESCAPE"
      GetKeyCode = DIK_ESCAPE
   Case "1"
      GetKeyCode = DIK_1
   Case "2"
      GetKeyCode = DIK_2
   Case "3"
      GetKeyCode = DIK_3
   Case "4"
      GetKeyCode = DIK_4
   Case "5"
      GetKeyCode = DIK_5
   Case "6"
      GetKeyCode = DIK_6
   Case "7"
      GetKeyCode = DIK_7
   Case "8"
      GetKeyCode = DIK_8
   Case "9"
      GetKeyCode = DIK_9
   Case "0"
      GetKeyCode = DIK_0
   Case "Q"
      GetKeyCode = DIK_Q
   Case "W"
      GetKeyCode = DIK_W
   Case "E"
      GetKeyCode = DIK_E
   Case "R"
      GetKeyCode = DIK_R
   Case "T"
      GetKeyCode = DIK_T
   Case "Y"
      GetKeyCode = DIK_Y
   Case "U"
      GetKeyCode = DIK_U
   Case "I"
      GetKeyCode = DIK_I
   Case "O"
      GetKeyCode = DIK_O
   Case "P"
      GetKeyCode = DIK_P
   Case "ENTER"
      GetKeyCode = DIK_RETURN
   Case "LEFT CONTROL"
      GetKeyCode = DIK_LCONTROL
   Case "A"
      GetKeyCode = DIK_A
   Case "S"
      GetKeyCode = DIK_S
   Case "D"
      GetKeyCode = DIK_D
   Case "F"
      GetKeyCode = DIK_F
   Case "G"
      GetKeyCode = DIK_G
   Case "H"
      GetKeyCode = DIK_H
   Case "J"
      GetKeyCode = DIK_J
   Case "K"
      GetKeyCode = DIK_K
   Case "L"
      GetKeyCode = DIK_L
   Case "LEFT SHIFT"
      GetKeyCode = DIK_LSHIFT
   Case "Z"
      GetKeyCode = DIK_Z
   Case "X"
      GetKeyCode = DIK_X
   Case "C"
      GetKeyCode = DIK_C
   Case "V"
      GetKeyCode = DIK_V
   Case "B"
      GetKeyCode = DIK_B
   Case "N"
      GetKeyCode = DIK_N
   Case "M"
      GetKeyCode = DIK_M
   Case "RIGHT SHIFT"
      GetKeyCode = DIK_RSHIFT
   Case "SPACE"
      GetKeyCode = DIK_SPACE
   Case "RIGHT CONTROL"
      GetKeyCode = DIK_RCONTROL
   Case "UP ARROW"
      GetKeyCode = DIK_UP
   Case "LEFT ARROW"
      GetKeyCode = DIK_LEFT
   Case "RIGHT ARROW"
      GetKeyCode = DIK_RIGHT
   Case "DOWN ARROW"
      GetKeyCode = DIK_DOWN
   End Select
End Function

Public Sub GameSave(Slot As String)
Dim i%, j%, ExitMenu As Boolean, GSave As Boolean
DX_Input

If CanSave = False Then
  Message "                                                                                                                                                                                                                                            "
  MessageBox "Cannot Save Here...", True
  DX_Input
  Exit Sub
End If

PlaySound "Menu"
Wait 200

Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_ESCAPE) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      Wait 200
    ElseIf DI_KSTATE.Key(DIK_RETURN) <> 0 Then
      PlaySound "OK"
      Wait 200
      GSave = True
      
      
      ExitMenu = True
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
        DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us. we must
    End If
    
    On Local Error Resume Next 'Incase there is an error
    DoEvents 'Give the computer time to do what it needs to do.
    DS_Back.SetForeColor RGB(255, 255, 255)
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
    i = GetSpriteIndex("Form-Save")
    DS_Back.BltFast 190, 180, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    DS_Back.DrawText 190 + 18, 180 + 50, "Save To Slot " & Slot & "?", False
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
If GSave = True Then SaveGameToFile Slot
End Sub

Public Sub GameLoad(Slot As String)
Dim i%, j%, ExitMenu As Boolean, GLoad As Boolean, tmp As String
DX_Input
tmp = Slot & "_" & CurName
tmp = GetSavedGame(tmp)
If FileExist(App.Path & "\Saves\", tmp) = False Then PlaySound "cancel": Exit Sub
tmp = Left(tmp, Len(tmp) - 4)
PlaySound "Menu"
Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_ESCAPE) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      Wait 200
    ElseIf DI_KSTATE.Key(DIK_RETURN) <> 0 Then
      GLoad = True
      PlaySound "OK"
      Wait 1000
      ExitMenu = True
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
        DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us. we must
    End If
    
    On Local Error Resume Next 'Incase there is an error
    DoEvents 'Give the computer time to do what it needs to do.
    DS_Back.SetForeColor RGB(255, 255, 255)
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
    i = GetSpriteIndex("Form-Load")
    DS_Back.BltFast 190, 180, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    DS_Back.DrawText 190 + 18, 180 + 50, "Load From Slot " & Slot & "?", False
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
If GLoad = True Then LoadGameFromFile tmp
End Sub

Public Sub GameMenu()
Dim i%, j%, ExitMenu As Boolean
Wait 200
DX_Input
PlaySound "Menu"
Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_ESCAPE) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      Wait 200
    ElseIf DI_KSTATE.Key(DIK_X) <> 0 Then
      PlaySound "OK"
      Call DX_Exit
      Wait 200
      DX_Input
      Wait 200
      Exit Sub
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
          DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us. we must
      End If
    
    On Local Error Resume Next 'Incase there is an error
    DoEvents 'Give the computer time to do what it needs to do.
    DS_Back.SetForeColor RGB(255, 255, 255)
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
    i = GetSpriteIndex("Form-Menu")
    DS_Back.BltFast 190, 180, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Sub

Public Function GameForceExit() As Boolean
Dim i%, j%, ExitMenu As Boolean
Wait 200
DX_Input
PlaySound "Menu"
Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_ESCAPE) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      Wait 200
    ElseIf DI_KSTATE.Key(DIK_X) <> 0 Then
      PlaySound "OK"
      GameForceExit = True
      Wait 200
      DX_Input
      Wait 200
      Exit Function
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
          DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us. we must
      End If
    
    On Local Error Resume Next 'Incase there is an error
    DoEvents 'Give the computer time to do what it needs to do.
    DS_Back.SetForeColor RGB(255, 255, 255)
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
    i = GetSpriteIndex("Form-Menu")
    DS_Back.BltFast 190, 180, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Function


Public Sub ChoiceMenu(ByVal CName As String, ByVal CMsg As String)
Dim i%, j%, ExitMenu As Boolean
Wait 200
DX_Input
PlaySound "Menu"
Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_Y) <> 0 Then
      DeleteEventFromList CName & "NO"
      ExecuteEvent CName & "YES"
      DeleteEventFromList CName & "Yes"
      DeleteEventFromList CName
      ExitMenu = True
      Exit Sub
    ElseIf DI_KSTATE.Key(DIK_N) <> 0 Then
      DeleteEventFromList CName & "Yes"
      ExecuteEvent CName & "NO"
      DeleteEventFromList CName & "NO"
      DeleteEventFromList CName
      ExitMenu = True
      Exit Sub
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
        DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us. we must
    End If
    
    On Local Error Resume Next 'Incase there is an error
    DoEvents 'Give the computer time to do what it needs to do.
    DS_Back.SetForeColor RGB(255, 255, 255)
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
    i = GetSpriteIndex("Form-YesOrNo")
    DS_Back.BltFast 190, 180, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    ItemsShown = True
    MessageBox CMsg, False
    ItemsShown = False
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Sub

Public Sub SaveGameToFile(Slot As String)
Dim FileNum As Integer, tmpStr As String, MapName$, CharPos As D3DVECTOR, CharDir$, T As String
Dim tmp As String
If CurName = "" Then CurName = "Rozs"
tmp = Slot & "_" & CurName
tmp = GetSavedGame(tmp)
If FileExist(App.Path & "\Saves\", tmp) = True Then Kill App.Path & "\Saves\" & tmp
  FileNum = FreeFile
  T = Format(Now, "mmm#dd#yy_hh@mmAMPM")
  Open App.Path & "\Saves\" & Slot & "_" & CurName & "_" & T & ".txt" For Output As FileNum
  MapName = curMapName
  CharFrames(1).GetPosition Nothing, CharPos
  CharDir = GetCurDir(GetCharName(LBound(WorldAni)))
  CharPos = GetCenterPos(WorldAni(1).AniName)
  tmpStr = Chr(13) & Chr(10) & BGMUSIC & ": " & CurBGMusic & ",LOOP" & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & GTIME & ": " & GameTime & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & TASK & ": " & CurTaskName & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & GetSwitchesAndItems
  tmpStr = Chr(13) & Chr(10) & tmpStr & FPLAYBG & ": " & CurBGMusic & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & SETCHARPOS & ": " & Abs(CInt(CharPos.Z + 5) \ 10) & ", " & CInt(CharPos.y) & ", " & CInt(CharPos.x) \ 10 & ", " & CharDir & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & FLOADMAP & ": " & MapName & Chr(13) & Chr(10)
  tmpStr = FTextWrite(tmpStr)
  
  Write #FileNum, tmpStr
  Close #FileNum
  Message "                                                                                                                                                                                                                                            "
  ScreenText.SMessage = ""
  MessageBox "Saving Of The Game is Complete. Press Interact Key To Continue...", True
End Sub

Public Sub AutoSaveGameToFile(Slot As String)
Dim FileNum As Integer, tmpStr As String, MapName$, CharPos As D3DVECTOR, CharDir$, T As String
Dim tmp As String
If CurName = "" Then CurName = "Rozs"
tmp = Slot & "_" & CurName
tmp = GetSavedGame(tmp)
If FileExist(App.Path & "\Saves\", tmp) = True Then Kill App.Path & "\Saves\" & tmp
  FileNum = FreeFile
  T = Format(Now, "mmm#dd#yy_hh@mmAMPM")
  Open App.Path & "\Saves\" & Slot & "_" & CurName & "_" & T & ".txt" For Output As FileNum
  MapName = curMapName
  CharFrames(1).GetPosition Nothing, CharPos
  CharDir = GetCurDir(GetCharName(LBound(WorldAni)))
  CharPos = GetCenterPos(WorldAni(1).AniName)
  tmpStr = Chr(13) & Chr(10) & BGMUSIC & ": " & CurBGMusic & ",LOOP" & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & GTIME & ": " & GameTime & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & TASK & ": " & CurTaskName & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & GetSwitchesAndItems
  tmpStr = Chr(13) & Chr(10) & tmpStr & FPLAYBG & ": " & CurBGMusic & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & SETCHARPOS & ": " & Abs(CInt(CharPos.Z + 5) \ 10) & ", " & CInt(CharPos.y) & ", " & CInt(CharPos.x) \ 10 & ", " & CharDir & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & FLOADMAP & ": " & MapName & Chr(13) & Chr(10)
  tmpStr = FTextWrite(tmpStr)
  
  Write #FileNum, tmpStr
  Close #FileNum
End Sub


Public Sub SaveGameToReload(Slot As String)
Dim FileNum As Integer, tmpStr As String, MapName$, CharPos As D3DVECTOR, CharDir$, T As String
Dim tmp As String
If CurName = "" Then CurName = "Rozs"
tmp = Slot & "_" & CurName
tmp = GetSavedGame(tmp)
If FileExist(App.Path & "\Saves\", tmp) = True Then Kill App.Path & "\Saves\" & tmp
  FileNum = FreeFile
  Open App.Path & "\Saves\" & Slot & ".txt" For Output As FileNum
  MapName = curMapName
  CharFrames(1).GetPosition Nothing, CharPos
  CharDir = GetCurDir(GetCharName(LBound(WorldAni)))
  CharPos = GetCenterPos(WorldAni(1).AniName)
  tmpStr = Chr(13) & Chr(10) & tmpStr & GetSwitchesAndItems
  tmpStr = Chr(13) & Chr(10) & tmpStr & GTIME & ": " & GameTime & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & TASK & ": " & CurTaskName & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & SETCHARPOS & ": " & Abs(CInt(CharPos.Z + 5) \ 10) & ", " & CInt(CharPos.y) & ", " & CInt(CharPos.x) \ 10 & ", " & CharDir & Chr(13) & Chr(10)
  tmpStr = Chr(13) & Chr(10) & tmpStr & FLOADMAP & ": " & MapName & Chr(13) & Chr(10)
  tmpStr = FTextWrite(tmpStr)
  Write #FileNum, tmpStr
  Close #FileNum
End Sub

Public Sub LoadGameFromFile(CurGame As String)
    IniItems
    ItemOnLoading = True
    LoadingGame = True
    ChangeMap = True
    ChangeMapName = CurGame
    MapLoaded = False
    ReDim WorldSwitch(1)
    NumSwitch = 1
    ReDim WorldItems(1)
    NumItems = 1
    Message "                                                                                                                                                                                                                                            "
    ScreenText.SMessage = ""
    MessageBox "Loading Of The Game is Complete. Press Interact Key To Continue...", True
End Sub

Public Sub LoadGameFromReload(CurGame As String)
    IniItems
    ItemOnLoading = True
    LoadingGame = True
    ChangeMap = True
    ChangeMapName = CurGame
    MapLoaded = False
    ReDim WorldItems(1)
    NumItems = 1
End Sub

Public Function FileExist(Path As String, FileName As String) As Boolean
  If Dir(Path & FileName) = FileName And Dir(Path & FileName) <> "" Then FileExist = True
End Function

Public Function FTextLoad(Text As String) As String
Dim i As Integer, L As String, tmp As String
For i = 1 To Len(Text)
  L = Mid(Text, i, 1)
  If L = "_" Then
    tmp = tmp & " "
  ElseIf L = "@" Then
    tmp = tmp & ":"
  ElseIf L = "#" Then
    tmp = tmp & "/"
  Else
    tmp = tmp & L
  End If
Next
FTextLoad = tmp
End Function

Public Function FTextSave(Text As String) As String
Dim i As Integer, L As String, tmp As String
For i = 1 To Len(Text)
  L = Mid(Text, i, 1)
  If L = " " Then
    tmp = tmp & "_"
  ElseIf L = ":" Then
    tmp = tmp & "@"
  ElseIf L = "/" Then
    tmp = tmp & "#"
  Else
    tmp = tmp & L
  End If
Next
FTextSave = tmp
End Function

Public Function GetSavedGame(Sname As String) As String
Dim MyPath As String, MyName As String
MyPath = App.Path & "\Saves\"
MyName = Dir(MyPath, vbNormal) ' Retrieve the first entry.
Do While MyName <> "" ' Start the loop.
  ' Ignore the current directory and the encompassing directory.
  If MyName <> "." And MyName <> ".." Then
    If Left(MyName, Len(Sname)) = Sname Then
      GetSavedGame = MyName
      Exit Function
    End If
  End If
  MyName = Dir  ' Get next entry.
Loop
End Function


Public Function GetUserName(FName As String) As String
Dim tmp As String, tmpName As String
Dim i As Integer, L As String
  tmp = Left(FName, Len(FName) - 18)
  For i = Len(tmp) To 1 Step -1
    L = Mid(tmp, i, 1)
    If L = ")" Then
      GetUserName = Right(tmpName, Len(tmpName) - 1)
      Exit Function
    Else
      tmpName = L & tmpName
    End If
  Next
End Function

Public Sub RefreshScreen()
SaveGameToReload "Refresh"
LoadGameFromReload "Refresh"
LoadImages
On Error Resume Next
Kill App.Path & "/Events/Refresh.txt"
End Sub

Public Sub AutoSaveNow()
AutoSaveGameToFile "(AutoSave)"
End Sub

Public Sub BackUpNow()
AutoSaveGameToFile "(BackUp)"
End Sub


