Attribute VB_Name = "mdlAI"
Option Explicit
Option Base 1
Option Compare Text

Public Type AIMovements
  TargetPos As XY
  RotateTo As String
End Type

Public Type AIList
  CharName As String
  CharIndex As Integer
  AIAction As String
  AIEvent As String
  AIReaction As String
  AIDirection As String
  AITimer As Long
  LastDirection As String
  OldCharPos As XY
  RndVal As Integer
  AICommand As AIMovements
End Type: Public WorldAI() As AIList
Public NumAI As Integer, LastAIRND As Integer

Public Sub AI()
Dim i As Integer, AIDir As String, PStart As Integer, PEnd As Integer
Dim tmp As XY, CharINX As Integer, Pos As D3DVECTOR
If NumAI <= 1 Then Exit Sub
For i = 1 To UBound(WorldAI)
AIDir = GetCurDir3(WorldAI(i).CharName)
CharINX = WorldAI(i).CharIndex
LastAIRND = RotateTo(CharINX, AIDir)

  Select Case WorldAI(i).AIAction
    Case AIROTATECLOCK
        If WorldAI(i).AIDirection = AIDir Then
            CharFrames(CharINX).SetOrientation CharFrames(CharINX), Sin5 * 0.5, 0, Cos5 * 0.5, 0, 1, 0
        Else
          If GetTickCount() - WorldAI(i).AITimer >= 3000 Then
            WorldAI(i).LastDirection = AIDir
            WorldAI(i).AIDirection = AIDir
            WorldAI(i).AITimer = GetTickCount()
          End If
        End If
    Case AIROTATECOUNTER
      If WorldAI(i).AIDirection = AIDir Then
            CharFrames(CharINX).SetOrientation CharFrames(CharINX), -Sin5 * 0.5, 0, Cos5 * 0.5, 0, 1, 0
        Else
          If GetTickCount() - WorldAI(i).AITimer >= 3000 Then
            WorldAI(i).LastDirection = AIDir
            WorldAI(i).AIDirection = AIDir
            WorldAI(i).AITimer = GetTickCount()
          End If
        End If
    Case AISEARCH
      tmp = GetAniStartEnd(WorldAni(CharINX).AniName, WorldAni(CharINX).AniStruct(2).AniName)
      PStart = tmp.x: PEnd = tmp.y
      If (GetTickCount() - WorldAI(i).AITimer) >= 80 Then
          WorldAni(CharINX).GlobalKey = ((WorldAni(CharINX).GlobalKey) + 1)
          WorldAni(CharINX).NowChar = WorldAni(CharINX).GlobalKey + PStart
          If WorldAni(CharINX).NowChar > PEnd Then
            WorldAni(CharINX).NowChar = PStart: WorldAni(CharINX).GlobalKey = 0
          End If
          CharFrames(CharINX).DeleteVisual WorldAni(CharINX).AniSet(WorldAni(CharINX).PrevChar)
          CharFrames(CharINX).AddVisual WorldAni(CharINX).AniSet(WorldAni(CharINX).NowChar)
          WorldAni(CharINX).PrevChar = WorldAni(CharINX).NowChar
          WorldAI(i).AITimer = GetTickCount
      End If
      CharFrames(CharINX).GetPosition Nothing, Pos
      If IsBlank(GetFront(Char & CharINX)) = True Then
        Select Case AIDir
          Case North
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            WorldAI(i).OldCharPos = tmp
            CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, -0.1
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            Layer(1).ObjKey(WorldAI(i).OldCharPos.x, WorldAI(i).OldCharPos.y) = ""
            Layer(1).ObjKey(tmp.x, tmp.y) = "C" & CharINX
          Case South
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            WorldAI(i).OldCharPos = tmp
            CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, -0.1
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            Layer(1).ObjKey(WorldAI(i).OldCharPos.x, WorldAI(i).OldCharPos.y) = ""
            Layer(1).ObjKey(tmp.x, tmp.y) = "C" & CharINX
          Case West
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            WorldAI(i).OldCharPos = tmp
            CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, -0.1
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            Layer(1).ObjKey(WorldAI(i).OldCharPos.x, WorldAI(i).OldCharPos.y) = ""
            Layer(1).ObjKey(tmp.x, tmp.y) = "C" & CharINX
          Case East
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            WorldAI(i).OldCharPos = tmp
            CharFrames(CharINX).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, -0.1
            CharFrames(CharINX).GetPosition Nothing, Pos
            tmp = GetMtxXY(Pos)
            Layer(1).ObjKey(WorldAI(i).OldCharPos.x, WorldAI(i).OldCharPos.y) = ""
            Layer(1).ObjKey(tmp.x, tmp.y) = "C" & CharINX
          Case Else
          
              CharFrames(CharINX).SetOrientation CharFrames(CharINX), LastAIRND * WorldAI(i).RndVal * Sin5 * 0.5, 0, Cos5 * 0.5, 0, 1, 0

        End Select
      Else
        If WorldAI(i).AIDirection = AIDir Then
        WorldAI(i).RndVal = (Rnd(WorldAI(i).RndVal) * 10) Mod 2
        If WorldAI(i).RndVal = 1 Then WorldAI(i).RndVal = -1 Else WorldAI(i).RndVal = 1
            CharFrames(CharINX).SetOrientation CharFrames(CharINX), LastAIRND * WorldAI(i).RndVal * Sin5 * 0.5, 0, Cos5 * 0.5, 0, 1, 0
            Pos = GetCenterPos(WorldAI(i).CharName)
            CharFrames(CharINX).SetPosition Nothing, Pos.x, Pos.y, Pos.Z
        Else
            WorldAI(i).LastDirection = AIDir
            WorldAI(i).AIDirection = AIDir
        End If
      End If
    Case AIFOLLOW
    
    Case AIIDLE
      CharLookAt WorldAI(i).CharName, WorldAni(1).AniName
  End Select
  
  If (InSight(CharINX, AIDir) = True And IsCovered(AIDir) = False) Or (InSight(CharINX, WorldAI(i).LastDirection) = True And IsCovered(WorldAI(i).LastDirection) = False) And WorldAI(i).AIEvent <> "" Then
    If WorldAI(i).AIEvent <> NONE Then
      CharLookAt WorldAI(i).CharName, WorldAni(1).AniName
      ExecuteEvent WorldAI(i).AIEvent
      DeleteEvent WorldAI(i).AIEvent
      WorldAI(i).AIEvent = ""
    End If
  End If
Next
End Sub

Public Sub CharLookAt(CharName As String, TargetName As String)
Dim CInx%, TInx%
CInx = GetCharIndex(CharName)
TInx = GetCharIndex(TargetName)
CharFrames(CInx).LookAt CharFrames(TInx), Nothing, D3DRMCONSTRAIN_Z
CharFrames(CInx).SetOrientation CharFrames(CInx), -1.55, 0, -17.95, 0, 1, 0
End Sub

Public Function CheckCondition(ConNum As Integer) As Boolean
  Dim i As Integer, Pos As XY, ConTrue As Integer
  For i = 1 To WorldConditions(ConNum).NumCondition
    Pos = WorldConditions(ConNum).ConSet(i).ConditionalPos
    If Layer(1).ObjKey(Pos.x, Pos.y) = Movable & WorldConditions(ConNum).ConSet(i).ObjNum And WorldConditions(ConNum).ConTrue = False Then
      ConTrue = ConTrue + 1
      If ConTrue >= WorldConditions(ConNum).NumCondition Then
        CheckCondition = True
        WorldConditions(ConNum).ConTrue = True
        Exit Function
      End If
    End If
  Next
End Function

Public Sub ExecuteConditions()
Dim i As Integer
On Local Error Resume Next
For i = 1 To UBound(WorldConditions)
  If CheckCondition(i) = True Then ExecuteEvent WorldConditions(i).ConEvent
Next
End Sub

Public Function InSight(AINum As Integer, AIDir As String) As Boolean
Dim x%, y%, Xo%, Yo%, X1%, Y1%, CharXY As XY, Pos As D3DVECTOR, PlayerXY As XY
CharFrames(AINum).GetPosition Nothing, Pos
CharXY = GetMtxXY(Pos)
CharFrames(1).GetPosition Nothing, Pos
PlayerXY = GetMtxXY(Pos)
Yo = CharXY.x: Xo = CharXY.y
Y1 = PlayerXY.x: X1 = PlayerXY.y

Select Case AIDir
  Case North
    For x = 1 To 10
        If (Yo - 3 = Y1) And (Xo - x = X1) Then
          GoTo GoOut
        ElseIf (Yo - 2 = Y1) And (Xo - x = X1) Then GoTo GoOut
        ElseIf (Yo - 1 = Y1) And (Xo - x = X1) Then GoTo GoOut
        ElseIf (Yo = Y1) And (Xo - x = X1) Then GoTo GoOut
        ElseIf (Yo + 1 = Y1) And (Xo - x = X1) Then GoTo GoOut
        ElseIf (Yo + 2 = Y1) And (Xo - x = X1) Then GoTo GoOut
        ElseIf (Yo + 3 = Y1) And (Xo - x = X1) Then GoTo GoOut
        End If
    Next
  Case South
    For x = 1 To 10
        If (Yo - 3 = Y1) And (Xo + x = X1) Then
          GoTo GoOut
        ElseIf (Yo - 2 = Y1) And (Xo + x = X1) Then GoTo GoOut
        ElseIf (Yo - 1 = Y1) And (Xo + x = X1) Then GoTo GoOut
        ElseIf (Yo = Y1) And (Xo + x = X1) Then GoTo GoOut
        ElseIf (Yo + 1 = Y1) And (Xo + x = X1) Then GoTo GoOut
        ElseIf (Yo + 2 = Y1) And (Xo + x = X1) Then GoTo GoOut
        ElseIf (Yo + 3 = Y1) And (Xo + x = X1) Then GoTo GoOut
        End If
    Next
  Case West
    For y = 1 To 10
        If (Xo - 3 = X1) And (Yo + y = Y1) Then
          GoTo GoOut
        ElseIf (Xo - 2 = X1) And (Yo + y = Y1) Then GoTo GoOut
        ElseIf (Xo - 1 = X1) And (Yo + y = Y1) Then GoTo GoOut
        ElseIf (Xo = X1) And (Yo + y = Y1) Then GoTo GoOut
        ElseIf (Xo + 1 = X1) And (Yo + y = Y1) Then GoTo GoOut
        ElseIf (Xo + 2 = X1) And (Yo + y = Y1) Then GoTo GoOut
        ElseIf (Xo + 3 = X1) And (Yo + y = Y1) Then GoTo GoOut
        End If
    Next
  Case East
    For y = 1 To 10
        If (Xo - 3 = X1) And (Yo - y = Y1) Then
          GoTo GoOut
        ElseIf (Xo - 2 = X1) And (Yo - y = Y1) Then GoTo GoOut
        ElseIf (Xo - 1 = X1) And (Yo - y = Y1) Then GoTo GoOut
        ElseIf (Xo = X1) And (Yo - y = Y1) Then GoTo GoOut
        ElseIf (Xo + 1 = X1) And (Yo - y = Y1) Then GoTo GoOut
        ElseIf (Xo + 2 = X1) And (Yo - y = Y1) Then GoTo GoOut
        ElseIf (Xo + 3 = X1) And (Yo - y = Y1) Then GoTo GoOut
        End If
    Next
End Select

Exit Function
GoOut:
InSight = True
End Function

Public Function IsCovered(AIDir As String) As Boolean
Dim CharXY As XY, Pos As D3DVECTOR
CharFrames(1).GetPosition Nothing, Pos
CharXY = GetMtxXY(Pos)
On Local Error Resume Next
If DOCKKEY = True Then
  Select Case AIDir
    Case North
      If Layer(1).ObjKey(CharXY.x, CharXY.y + 1) <> "" Then IsCovered = True: Exit Function
    Case South
      If Layer(1).ObjKey(CharXY.x, CharXY.y - 1) <> "" Then IsCovered = True: Exit Function
    Case East
      If Layer(1).ObjKey(CharXY.x + 1, CharXY.y) <> "" Then IsCovered = True: Exit Function
    Case West
      If Layer(1).ObjKey(CharXY.x - 1, CharXY.y) <> "" Then IsCovered = True: Exit Function
  End Select
End If
Select Case AIDir
    Case North
      If Layer(1).ObjKey(CharXY.x, CharXY.y + 1) = Block Then IsCovered = True: Exit Function
    Case South
      If Layer(1).ObjKey(CharXY.x, CharXY.y - 1) = Block Then IsCovered = True: Exit Function
    Case East
      If Layer(1).ObjKey(CharXY.x + 1, CharXY.y) = Block Then IsCovered = True: Exit Function
    Case West
      If Layer(1).ObjKey(CharXY.x - 1, CharXY.y) = Block Then IsCovered = True: Exit Function
  End Select
End Function

Public Function RotateTo(CharNum As Integer, CharDir As String) As Integer
  Dim CharCode As String, tmp As XY
  CharCode = Char & CharNum
  tmp = GetCharXY(CharCode)
  On Local Error Resume Next
  Select Case CharDir
    Case North
      If Layer(1).ObjKey(tmp.x, tmp.y + 2) = "" Then RotateTo = 1: Exit Function
      If Layer(1).ObjKey(tmp.x, tmp.y - 2) = "" Then RotateTo = -1: Exit Function
    Case South
      If Layer(1).ObjKey(tmp.x, tmp.y + 2) = "" Then RotateTo = 1: Exit Function
      If Layer(1).ObjKey(tmp.x, tmp.y - 2) = "" Then RotateTo = -1: Exit Function
    Case West
      If Layer(1).ObjKey(tmp.x + 2, tmp.y) = "" Then RotateTo = 1: Exit Function
      If Layer(1).ObjKey(tmp.x - 2, tmp.y) = "" Then RotateTo = -1: Exit Function
    Case East
      If Layer(1).ObjKey(tmp.x + 2, tmp.y) = "" Then RotateTo = 1: Exit Function
      If Layer(1).ObjKey(tmp.x - 2, tmp.y) = "" Then RotateTo = -1: Exit Function
  End Select
RotateTo = -1
End Function
