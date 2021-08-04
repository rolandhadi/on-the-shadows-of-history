Attribute VB_Name = "mdlInput"
Option Explicit
Option Base 1
Option Compare Text
Public LastDirection As String
Public TPos As D3DVECTOR, CPos As D3DVECTOR
Public TFrm As Direct3DRMFrame3: Dim Moved As Boolean
Public OldTPos As D3DVECTOR, OldCPos As D3DVECTOR
Public LastTick As Long
Public GameInput As Boolean, Run As Boolean, Push As Boolean, Dock As Boolean
Public LastKeyPress As Long, LastKeyPress1 As Long, PUSHKEY As Boolean, DOCKKEY As Boolean, LastRotate As String
Public OldCharPos As XY, LatestOldPos As D3DVECTOR, Polar As Integer, CamLock As Boolean

Public Sub MoveChar()
Dim CurPos As D3DVECTOR, OldPos As D3DVECTOR, tmp As XY
Dim i%, PStart%, PEnd%, PSpeed%, tmpPos As D3DVECTOR
Dim CharINX As Integer, CharName As String
On Error GoTo ErrMsg
CharINX = LBound(CharFrames)
CharName = GetCharName(CharINX)
AlignPointer CharName
CharFrames(CharINX).GetPosition Nothing, OldPos
OldCharPos = GetMtxXY(OldPos)

If GetCurDir2(GetCharName(LBound(WorldAni))) <> NONE Then
  LastDirection = GetCurDir2(GetCharName(LBound(WorldAni)))
  If LastRotate = LEFT_ Then
      Polar = -1
      Else
      Polar = 1
  End If
End If
If DI_KSTATE.Key(WorldControl.Interact) <> 0 Then DI_MSTATE.buttons(0) = 1
  If DI_KSTATE.Key(WorldControl.Look) <> 0 Then Exit Sub

  If DI_KSTATE.Key(WorldControl.Dock) <> 0 And Dock = False Then
      If WorldAni(CharINX).AniStruct(5).AniName <> NONE Then
        tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(5).AniName)
        PSpeed = 20: PStart = tmp.x: PEnd = tmp.y
        DOCKKEY = True
        tmpPos = GetCenterPos(GetCharName(1))
        CharFrames(1).SetPosition Nothing, tmpPos.x, tmpPos.y, tmpPos.Z
      End If
      
  ElseIf DI_KSTATE.Key(WorldControl.Dock) = 0 And Dock = True Then
      If WorldAni(CharINX).AniStruct(5).AniName <> NONE Then
        tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(5).AniName)
        PSpeed = 30: PStart = tmp.y: PEnd = tmp.x
        DOCKKEY = True
      End If
  
  ElseIf DI_KSTATE.Key(WorldControl.WalkForward) <> 0 And Run = True And DI_KSTATE.Key(WorldControl.Dock) = 0 And DI_MSTATE.buttons(0) = 0 And Push = False Then
      CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, -RSpeed * GSpeed
      CharFrames(CharINX).GetPosition Nothing, CurPos
      
      If IsBlock(GetXY(CurPos)) = True Then
          Select Case ShallMoveTo(CharName)
          Case 1
            CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z - 0.1
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = 0: LatestOldPos.y = 0: LatestOldPos.Z = -0.1
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case 2
            CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z + 0.1
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = 0: LatestOldPos.y = 0: LatestOldPos.Z = 0.1
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case 3
            CharFrames(CharINX).SetPosition Nothing, OldPos.x + 0.1, OldPos.y, OldPos.Z
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = 0.1: LatestOldPos.y = 0: LatestOldPos.Z = 0
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case 4
            CharFrames(CharINX).SetPosition Nothing, OldPos.x - 0.1, OldPos.y, OldPos.Z
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = -0.1: LatestOldPos.y = 0: LatestOldPos.Z = 0
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case Else
            CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, LatestOldPos.x, LatestOldPos.y, LatestOldPos.Z
          End Select
          tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(3).AniName)
          PSpeed = 70: PStart = tmp.x: PEnd = tmp.y
      Else
        If WorldAni(CharINX).AniStruct(3).AniName <> NONE Then
          tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(3).AniName)
          PSpeed = 70: PStart = tmp.x: PEnd = tmp.y
          Moved = True
        End If
      End If
  ElseIf DI_KSTATE.Key(WorldControl.WalkForward) <> 0 And DI_KSTATE.Key(WorldControl.Dock) = 0 And DI_MSTATE.buttons(0) = 0 And Push = False Then
      CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, -WSpeed * GSpeed
      CharFrames(CharINX).GetPosition Nothing, CurPos
      If IsBlock(GetXY(CurPos)) = True Then
          Select Case ShallMoveTo(CharName)
          Case 1
            CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z - 0.1
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = 0: LatestOldPos.y = 0: LatestOldPos.Z = 0.1
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case 2
            CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z + 0.1
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = 0: LatestOldPos.y = 0: LatestOldPos.Z = -0.1
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case 3
            CharFrames(CharINX).SetPosition Nothing, OldPos.x + 0.1, OldPos.y, OldPos.Z
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = 0.1: LatestOldPos.y = 0: LatestOldPos.Z = 0
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case 4
            CharFrames(CharINX).SetPosition Nothing, OldPos.x - 0.1, OldPos.y, OldPos.Z
            CharFrames(CharINX).GetPosition Nothing, CurPos
            LatestOldPos.x = -0.1: LatestOldPos.y = 0: LatestOldPos.Z = 0
            If IsBlock(GetXY(CurPos)) = True Then CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z: CharFrames(CharINX).SetOrientation CharFrames(CharINX), Polar * Sin5 * 0.01, 0, Cos5 * 0.01, 0, 1, 0
          Case Else
            CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, LatestOldPos.x, LatestOldPos.y, LatestOldPos.Z
          End Select
          tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(2).AniName)
          PSpeed = 80: PStart = tmp.x: PEnd = tmp.y
      Else
        If WorldAni(CharINX).AniStruct(2).AniName <> NONE Then
          tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(2).AniName)
          PSpeed = 80: PStart = tmp.x: PEnd = tmp.y
          Moved = True
        End If
      End If
  ElseIf DI_KSTATE.Key(WorldControl.WalkBackward) <> 0 And DI_KSTATE.Key(WorldControl.Dock) = 0 Then
      CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, BSpeed * GSpeed
      CharFrames(CharINX).GetPosition Nothing, CurPos
      If IsBlock(GetXY(CurPos)) = True Then
          CharFrames(CharINX).SetPosition Nothing, OldPos.x, OldPos.y, OldPos.Z
          tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(2).AniName)
          PSpeed = 80: PStart = tmp.y: PEnd = tmp.x
        Else
        If WorldAni(CharINX).AniStruct(2).AniName <> NONE Then
          tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(2).AniName)
          PSpeed = 80: PStart = tmp.y: PEnd = tmp.x
          Moved = True
        End If
      End If
  
  ElseIf DI_MSTATE.buttons(0) <> 0 And IsM(GetFront(Char & "1")) = True And IsBlank(GetFrontX2(Char & "1")) = True And DI_KSTATE.Key(WorldControl.WalkForward) = 0 Then
      If WorldAni(CharINX).AniStruct(4).AniName <> NONE Then
        tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(4).AniName)
        PSpeed = 30: PStart = tmp.x: PEnd = tmp.y
        PUSHKEY = True
      End If
  ElseIf DI_MSTATE.buttons(0) = 0 And Push = True Then
      If WorldAni(CharINX).AniStruct(4).AniName <> NONE Then
        tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(4).AniName)
        PSpeed = 30: PStart = tmp.y: PEnd = tmp.x
        PUSHKEY = True
      End If
  Else
      If DI_KSTATE.Key(WorldControl.RotateLeft) <> 0 Or DI_KSTATE.Key(WorldControl.RotateRight) <> 0 Then
          PStart = 1
          PEnd = 1

      Else
        If WorldAni(CharINX).AniStruct(2).AniName <> NONE Then
          tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(1).AniName)
          PSpeed = 10: PStart = tmp.x: PEnd = tmp.y
          WorldAni(CharINX).GlobalKey = 0
          Moved = False
        End If
      End If
  End If
  
  
  If DI_KSTATE.Key(WorldControl.RotateLeft) <> 0 And DI_MSTATE.buttons(0) = 0 Then
      CharFrames(CharINX).SetOrientation CharFrames(CharINX), -Sin5 * 0.5, 0, Cos5 * 0.5, 0, 1, 0
      LastRotate = LEFT_
  ElseIf DI_KSTATE.Key(WorldControl.RotateRight) <> 0 And DI_MSTATE.buttons(0) = 0 Then
      CharFrames(CharINX).SetOrientation CharFrames(CharINX), Sin5 * 0.5, 0, Cos5 * 0.5, 0, 1, 0
      LastRotate = RIGHT_
  End If
  
  If DI_MSTATE.buttons(0) = 0 And Push = False Then
        PUSHKEY = False
  End If
  
  If DI_KSTATE.Key(WorldControl.Dock) = 0 And Dock = False Then
        DOCKKEY = False
  End If
  
  CharFrames(CharINX).GetPosition Nothing, CurPos
  OldPos = CurPos
  Layer(1).ObjKey(OldCharPos.x, OldCharPos.y) = ""
  OldCharPos = GetMtxXY(CurPos)
  Layer(1).ObjKey(OldCharPos.x, OldCharPos.y) = Char & CharINX
  
  If DI_KSTATE.Key(WorldControl.Dock) <> 0 And Dock = True Then
        
        Exit Sub
  End If
  
  If DI_MSTATE.buttons(0) <> 0 And Push = True Then
        Exit Sub
  End If
  
    If PStart < PEnd Then
        DoEvents
        If (GetTickCount() - LastTick) >= PSpeed Then
          WorldAni(CharINX).GlobalKey = ((WorldAni(CharINX).GlobalKey) + 1)
          WorldAni(CharINX).NowChar = WorldAni(CharINX).GlobalKey + PStart
          If WorldAni(CharINX).NowChar > PEnd Then
            WorldAni(CharINX).NowChar = PStart: WorldAni(CharINX).GlobalKey = 0
            If PUSHKEY = True Then
              Push = True
              WorldAni(CharINX).NowChar = PEnd
            Else
              Push = False
            End If
            If DOCKKEY = True Then
              Dock = True
              WorldAni(CharINX).NowChar = PEnd
            Else
              Dock = False
              
            End If
          End If
          CharFrames(CharINX).DeleteVisual WorldAni(CharINX).AniSet(WorldAni(CharINX).PrevChar)
          CharFrames(CharINX).AddVisual WorldAni(CharINX).AniSet(WorldAni(CharINX).NowChar)
          WorldAni(CharINX).PrevChar = WorldAni(CharINX).NowChar
          LastTick = GetTickCount
        End If
    Else
        DoEvents
        If (GetTickCount() - LastTick) >= PSpeed Then
          WorldAni(CharINX).GlobalKey = ((WorldAni(CharINX).GlobalKey) + 1)
          WorldAni(CharINX).NowChar = (PStart - WorldAni(CharINX).GlobalKey)
          If WorldAni(CharINX).NowChar < PEnd Then
            WorldAni(CharINX).NowChar = PStart: WorldAni(CharINX).GlobalKey = 0:
            If PUSHKEY = True Then
              Push = False
              WorldAni(CharINX).NowChar = PEnd
            Else
              Push = False
            End If
            If DOCKKEY = True Then
              Dock = False
              WorldAni(CharINX).NowChar = PEnd
              DOCKKEY = False
            End If
          End If
          CharFrames(CharINX).DeleteVisual WorldAni(CharINX).AniSet(WorldAni(CharINX).PrevChar)
          CharFrames(CharINX).AddVisual WorldAni(CharINX).AniSet(WorldAni(CharINX).NowChar)
          WorldAni(CharINX).PrevChar = WorldAni(CharINX).NowChar
          LastTick = GetTickCount
        End If
    End If
    
    If DI_KSTATE.Key(WorldControl.Walk_Run) <> 0 Then
       If GetTickCount() - LastKeyPress >= 400 Then
          If Run = True Then
            Run = False
          Else
            Run = True
          End If
          LastKeyPress = GetTickCount()
       End If
    End If
     
    If DI_KSTATE.Key(WorldControl.LockCam) <> 0 Then
       If GetTickCount() - LastKeyPress >= 400 Then
          If CamLock = True Then
            CamLock = False
          Else
            CamLock = True
          End If
          LastKeyPress = GetTickCount()
       End If
    End If
    
    
    If DI_KSTATE.Key(DIK_F1) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(1)"
    ElseIf DI_KSTATE.Key(DIK_F2) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(2)"
    ElseIf DI_KSTATE.Key(DIK_F3) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(3)"
    ElseIf DI_KSTATE.Key(DIK_F4) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(4)"
    ElseIf DI_KSTATE.Key(DIK_F5) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(5)"
    ElseIf DI_KSTATE.Key(DIK_F6) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(6)"
    ElseIf DI_KSTATE.Key(DIK_F7) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(7)"
    ElseIf DI_KSTATE.Key(DIK_F8) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(8)"
    ElseIf DI_KSTATE.Key(DIK_F9) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(9)"
    ElseIf DI_KSTATE.Key(DIK_F10) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(10)"
    ElseIf DI_KSTATE.Key(DIK_F11) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(11)"
    ElseIf DI_KSTATE.Key(DIK_F12) <> 0 And DI_KSTATE.Key(DIK_LSHIFT) <> 0 Or (DI_KSTATE.Key(DIK_RSHIFT) <> 0) Then
      GameSave "(12)"
    ElseIf DI_KSTATE.Key(DIK_F1) <> 0 Then
      GameLoad "(1)"
    ElseIf DI_KSTATE.Key(DIK_F2) <> 0 Then
      GameLoad "(2)"
    ElseIf DI_KSTATE.Key(DIK_F3) <> 0 Then
      GameLoad "(3)"
    ElseIf DI_KSTATE.Key(DIK_F4) <> 0 Then
      GameLoad "(4)"
    ElseIf DI_KSTATE.Key(DIK_F5) <> 0 Then
      GameLoad "(5)"
    ElseIf DI_KSTATE.Key(DIK_F6) <> 0 Then
      GameLoad "(6)"
    ElseIf DI_KSTATE.Key(DIK_F7) <> 0 Then
      GameLoad "(7)"
    ElseIf DI_KSTATE.Key(DIK_F8) <> 0 Then
      GameLoad "(8)"
    ElseIf DI_KSTATE.Key(DIK_F9) <> 0 Then
      GameLoad "(9)"
    ElseIf DI_KSTATE.Key(DIK_F10) <> 0 Then
      GameLoad "(10)"
    ElseIf DI_KSTATE.Key(DIK_F11) <> 0 Then
      GameLoad "(11)"
    ElseIf DI_KSTATE.Key(DIK_F12) <> 0 Then
      GameLoad "(12)"
    End If
    
    If DI_KSTATE.Key(DIK_TAB) <> 0 Then
      If CurTaskName = "" Then
        ShowTask "TaskNone"
      Else
        ShowTask CurTaskName
      End If
      NewTask = False
    End If
    
    If DI_KSTATE.Key(DIK_H) <> 0 Then GameHelp
    
    'If DI_KSTATE.Key(DIK_P) <> 0 Then ShowScores
    
Exit Sub
ErrMsg:
BackUpNow
MsgBox "Out Of Memory." & Chr(10) + Chr(13) & "Please close other running applications then restart the game." & Chr(10) + Chr(13) & "A back-up/Auto Save is generated. Load it to continue your current game state.", vbCritical, "Out Of Memory"
End
End Sub

Public Sub RotateChar()
Dim tmpX As Double, tmpY As Double
Dim tmpPos As D3DVECTOR
tmpX = 0.15 * (Abs(DI_MSTATE.x) / 4)
tmpY = 0.15 * (Abs(DI_MSTATE.y) / 4)
    If DI_MSTATE.x < -1 Then
        CharPointer.SetOrientation CharPointer, -Sin5 * tmpX, 0, Cos5, 0, 1, 0
        If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), -Sin5 * tmpX, 0, Cos5, 0, 1, 0: LastRotate = LEFT_
    ElseIf DI_MSTATE.x > 1 Then
        CharPointer.SetOrientation CharPointer, Sin5 * tmpX, 0, Cos5, 0, 1, 0
        If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), Sin5 * tmpX, 0, Cos5, 0, 1, 0: LastRotate = RIGHT_
    End If
    
    If DI_KSTATE.Key(WorldControl.RotateCamLeft) <> 0 Then
    tmpX = 0.15 * 2
        CharPointer.SetOrientation CharPointer, -Sin5 * tmpX, 0, Cos5, 0, 1, 0
        If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), -Sin5 * tmpX, 0, Cos5, 0, 1, 0: LastRotate = LEFT_
    ElseIf DI_KSTATE.Key(WorldControl.RotateCamRight) <> 0 Then
    tmpX = 0.15 * 2
        CharPointer.SetOrientation CharPointer, Sin5 * tmpX, 0, Cos5, 0, 1, 0
        If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), Sin5 * tmpX, 0, Cos5, 0, 1, 0: LastRotate = RIGHT_
    End If
    
    If DI_MSTATE.buttons(1) <> 0 And CamLock = False Then
      If DI_MSTATE.y < -1 Then
         FR_Cam.AddTranslation D3DRMCOMBINE_BEFORE, 0, tmpY * 4, 0
         FR_Cam.GetPosition CharPointer, OldCPos
         If OldCPos.y >= HMousePos Then OldCPos.y = HMousePos - 0.1
          If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), -Sin5 * tmpX, 0, Cos5, 0, 1, 0
      ElseIf DI_MSTATE.y > 1 Then
          FR_Cam.AddTranslation D3DRMCOMBINE_BEFORE, 0, -tmpY * 4, 0
          FR_Cam.GetPosition CharPointer, OldCPos
          If OldCPos.y <= LMousePos Then OldCPos.y = LMousePos + 0.1
          If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), Sin5 * tmpX, 0, Cos5, 0, 1, 0
      End If
    End If
    
    If DI_KSTATE.Key(WorldControl.MoveCamDown) <> 0 Then
    tmpY = 0.15 * 2
    FR_Cam.AddTranslation D3DRMCOMBINE_BEFORE, 0, -tmpY * 4, 0
    FR_Cam.GetPosition CharPointer, OldCPos
    If OldCPos.y <= LMousePos Then OldCPos.y = LMousePos + 0.1
    If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), Sin5 * tmpX, 0, Cos5, 0, 1, 0
    ElseIf DI_KSTATE.Key(WorldControl.MoveCamUp) <> 0 Then
    tmpY = 0.15 * 2
    FR_Cam.AddTranslation D3DRMCOMBINE_BEFORE, 0, tmpY * 4, 0
    FR_Cam.GetPosition CharPointer, OldCPos
    If OldCPos.y >= HMousePos Then OldCPos.y = HMousePos - 0.1
    If Moved = True Then CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), -Sin5 * tmpX, 0, Cos5, 0, 1, 0
    End If
    
End Sub

Public Sub ControlLook()
Dim tmpX As Double
  If CamLock = True Then
    TFrm.SetPosition CharPointer, 0, 15, -10
    FR_Cam.LookAt TFrm, Nothing, D3DRMCONSTRAIN_Z
    Exit Sub
  ElseIf DI_KSTATE.Key(WorldControl.Look) <> 0 Then
    tmpX = 0.0000001 * (Abs(DI_MSTATE.x) / 4)
    If DI_MSTATE.x < -1 Then
        CharPointer.SetOrientation CharPointer, -Sin5 * tmpX, 0, Cos5, 0, 1, 0
        CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), -Sin5 * tmpX, 0, Cos5, 0, 1, 0
    ElseIf DI_MSTATE.x > 1 Then
        CharPointer.SetOrientation CharPointer, Sin5 * tmpX, 0, Cos5, 0, 1, 0
        CharFrames(LBound(CharFrames)).SetOrientation CharFrames(LBound(CharFrames)), Sin5 * tmpX, 0, Cos5, 0, 1, 0: LastRotate = RIGHT_
    End If
    TFrm.SetPosition CharFrames(LBound(CharFrames)), 0, 15, -10
    FR_Cam.SetPosition CharFrames(LBound(CharFrames)), 0, 15, -1.5
    FR_Cam.LookAt TFrm, Nothing, D3DRMCONSTRAIN_Z
    Moved = True
    Exit Sub
  Else
    OldCPos = CamCollided
    FR_Cam.SetPosition CharPointer, OldCPos.x, OldCPos.y, OldCPos.Z
    FR_Cam.GetPosition CharPointer, OldCPos
    TFrm.SetPosition CharPointer, 0, 5, -15
    TFrm.GetPosition CharPointer, OldTPos
    FR_Cam.LookAt TFrm, Nothing, D3DRMCONSTRAIN_Z
  End If
  If F_Start = 0 And F_End = 0 Then
    FogON 100, 400, 20, 20
  Else
    FogON F_Start, F_End, F_FColor, F_BColor
  End If
End Sub

Public Function GetAniStartEnd(CharName As String, AniName As String) As XY
Dim i As Integer, tmp As XY, CharNum%
For i = LBound(WorldAni) To UBound(WorldAni)
  If WorldAni(i).AniName = CharName Then
    CharNum = i
    Exit For
  Else
    CharNum = 1
  End If
Next
For i = LBound(WorldAni(CharNum).AniStruct) To UBound(WorldAni(CharNum).AniStruct)
  If WorldAni(CharNum).AniStruct(i).AniName = AniName Then
    tmp.x = WorldAni(CharNum).AniStruct(i).AniStart
    tmp.y = WorldAni(CharNum).AniStruct(i).AniEnd
    GetAniStartEnd = tmp
    Exit Function
  End If
Next
End Function

Public Sub DX_Input()
  DI_KBOARD.GetDeviceStateKeyboard DI_KSTATE 'Get the array of keyboard keys and their current states
  DI_MOUSE.GetDeviceStateMouse DI_MSTATE
End Sub

Public Sub DX_GameInput()
Dim Pos As D3DVECTOR, tmpPos As D3DVECTOR, tmpNewPos As D3DVECTOR, tmpOldPos As D3DVECTOR
Dim tmpObjPos As D3DVECTOR, tmpINX As Integer, tmpOldXY As XY, tmpNewXY As XY
  GameInput = True
  DI_KBOARD.GetDeviceStateKeyboard DI_KSTATE 'Get the array of keyboard keys and their current states
  DI_MOUSE.GetDeviceStateMouse DI_MSTATE
  If DI_KSTATE.Key(WorldControl.Cancel) <> 0 Then
    If GetTickCount() - LastKeyPress >= 600 Then
          ShowItems
          LastKeyPress = GetTickCount()
       End If
  End If
  If GameInput = True Then
    MoveChar
    RotateChar
    ControlLook
    CharFrames(1).GetPosition Nothing, Pos
       If IsEvent(GetXY(Pos)) = True Then
        If MapEvents(GetEMapINX(CurEvent)).Action = 0 Then
         ExecuteEvent CurEvent
         DeleteALLEventFromList CurEvent
         On Local Error Resume Next
         Close
         CopyAllEvents
         If MapEvents(GetEMapINX(CurEvent)).Repeat = False Then
          DeleteEvent CurEvent
         Else
          LoadEvents CurEvent
         End If
        ElseIf MapEvents(GetEMapINX(CurEvent)).Action = 1 Then
            If GetTickCount() - LastKeyPress >= 400 Then
              If DI_MSTATE.buttons(0) <> 0 Or DI_KSTATE.Key(WorldControl.Interact) <> 0 Then
                DX_Input
                ExecuteEvent CurEvent
                DeleteALLEventFromList CurEvent
                On Local Error Resume Next
                Close
                CopyAllEvents
                  If MapEvents(GetEMapINX(CurEvent)).Repeat = False Then
                   DeleteEvent CurEvent
                  Else
                   
                   LoadEvents CurEvent
                  End If
                LastKeyPress = GetTickCount()
              End If
            End If
        End If
       End If
       
  Else
  
  End If
  If IsM(GetFront(Char & "1")) = True And Push = True And IsBlank(GetFrontX2(Char & "1")) = True Then
    PlaySound "BoxMove"
    Select Case GetCurDir(GetCharName(LBound(WorldAni)))
    Case North
      tmpINX = GetValFromString(GetM(GetFront("C1")))
      While MoveObject(tmpINX, GetFrontX2("C1")) <> True
      Wend
      tmpObjPos = WorldLObj(tmpINX).ObjPos
      WorldLObj(tmpINX).ObjPos.Z = WorldLObj(tmpINX).ObjPos.Z - 1
      tmpObjPos.x = tmpObjPos.x * 10
      tmpObjPos.y = tmpObjPos.y * 10
      tmpObjPos.Z = tmpObjPos.Z * 10
      tmpOldPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      tmpOldXY = GetMtxXY(tmpObjPos)
      tmpObjPos.Z = tmpObjPos.Z - 10
      tmpNewXY = GetMtxXY(tmpObjPos)
      tmpPos = GetObjPos(GetLObjName(tmpINX), tmpOldPos, North)
      tmpNewPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      ObjFrames(tmpINX).SetPosition Nothing, tmpNewPos.x, tmpNewPos.y, tmpNewPos.Z
      Layer(1).ObjKey(tmpNewXY.x, tmpNewXY.y) = Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y)
      Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y) = ""
    Case South
      tmpINX = GetValFromString(GetM(GetFront("C1")))
      While MoveObject(tmpINX, GetFrontX2("C1")) <> True
      Wend
      tmpObjPos = WorldLObj(tmpINX).ObjPos
      WorldLObj(tmpINX).ObjPos.Z = WorldLObj(tmpINX).ObjPos.Z + 1
      tmpObjPos.x = tmpObjPos.x * 10
      tmpObjPos.y = tmpObjPos.y * 10
      tmpObjPos.Z = tmpObjPos.Z * 10
      tmpOldPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      tmpOldXY = GetMtxXY(tmpObjPos)
      tmpObjPos.Z = tmpObjPos.Z + 10
      tmpNewXY = GetMtxXY(tmpObjPos)
      tmpPos = GetObjPos(GetLObjName(tmpINX), tmpOldPos, North)
      tmpNewPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      ObjFrames(tmpINX).SetPosition Nothing, tmpNewPos.x, tmpNewPos.y, tmpNewPos.Z
      Layer(1).ObjKey(tmpNewXY.x, tmpNewXY.y) = Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y)
      Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y) = ""
    Case West
      tmpINX = GetValFromString(GetM(GetFront("C1")))
      While MoveObject(tmpINX, GetFrontX2("C1")) <> True
      Wend
      tmpObjPos = WorldLObj(tmpINX).ObjPos
      WorldLObj(tmpINX).ObjPos.x = WorldLObj(tmpINX).ObjPos.x + 1
      tmpObjPos.x = tmpObjPos.x * 10
      tmpObjPos.y = tmpObjPos.y * 10
      tmpObjPos.Z = tmpObjPos.Z * 10
      tmpOldPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      tmpOldXY = GetMtxXY(tmpObjPos)
      tmpObjPos.x = tmpObjPos.x + 10
      tmpNewXY = GetMtxXY(tmpObjPos)
      tmpPos = GetObjPos(GetLObjName(tmpINX), tmpOldPos, North)
      tmpNewPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      ObjFrames(tmpINX).SetPosition Nothing, tmpNewPos.x, tmpNewPos.y, tmpNewPos.Z
      Layer(1).ObjKey(tmpNewXY.x, tmpNewXY.y) = Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y)
      Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y) = ""
    Case East
      tmpINX = GetValFromString(GetM(GetFront("C1")))
      While MoveObject(tmpINX, GetFrontX2("C1")) <> True
      Wend
      tmpObjPos = WorldLObj(tmpINX).ObjPos
      WorldLObj(tmpINX).ObjPos.x = WorldLObj(tmpINX).ObjPos.x - 1
      tmpObjPos.x = tmpObjPos.x * 10
      tmpObjPos.y = tmpObjPos.y * 10
      tmpObjPos.Z = tmpObjPos.Z * 10
      tmpOldPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      tmpOldXY = GetMtxXY(tmpObjPos)
      tmpObjPos.x = tmpObjPos.x - 10
      tmpNewXY = GetMtxXY(tmpObjPos)
      tmpPos = GetObjPos(GetLObjName(tmpINX), tmpOldPos, North)
      tmpNewPos = GetObjPos(GetLObjName(tmpINX), tmpObjPos, North)
      ObjFrames(tmpINX).SetPosition Nothing, tmpNewPos.x, tmpNewPos.y, tmpNewPos.Z
      Layer(1).ObjKey(tmpNewXY.x, tmpNewXY.y) = Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y)
      Layer(1).ObjKey(tmpOldXY.x, tmpOldXY.y) = ""
    End Select
    
  Else
  End If
End Sub

Public Function CamCollided() As D3DVECTOR
Dim i As Double, tmp As D3DVECTOR
Dim tmpPos As D3DVECTOR

For i = 15 To 25 Step 0.5
  tmpCam.SetPosition CharPointer, 0, OldCPos.y, i
  tmpCam.GetPosition Nothing, tmpPos
  If IsCBlock(GetXY(tmpPos)) = True Then
    tmpCam.SetPosition CharPointer, 0, OldCPos.y, i - 4.5
    tmpCam.GetPosition CharPointer, tmp
    CamCollided = tmp
    Exit Function
  End If
Next
tmpCam.SetPosition CharPointer, 0, OldCPos.y, 25
tmpCam.GetPosition CharPointer, tmp
CamCollided = tmp
End Function

Public Function GetMtxXY(XYZ As D3DVECTOR) As XY
Dim tmp As XY
tmp.x = CInt(Abs(XYZ.x \ 10))
tmp.y = CInt(Abs(XYZ.Z \ 10))
GetMtxXY = tmp
End Function
