Attribute VB_Name = "mdlMatrix"
Option Explicit
Option Base 1
Option Compare Text

Public Type MatrixList
  ObjNum As Integer
  MtxSize As XY
  MapObj() As Integer  'Represents the object in the world
  ObjStruct() As XY 'The structure of the object
  ObjKey() As String
End Type: Public WorldObjMatrix() As MatrixList, NumMatrix As Integer

Public Function GenMatrix(ObjName As String, ObjNum As Integer, Size As XY) As MatrixList
  Dim tmpObj As MatrixList, FileNum%, Intext$
  Dim blk%, i%, j%
  ReDim tmpObj.MapObj(Size.x, Size.y): ReDim tmpObj.ObjStruct(Size.x, Size.y)
  ReDim tmpObj.ObjKey(Size.x, Size.y)
  tmpObj.ObjNum = ObjNum
  tmpObj.MtxSize = Size
  For i = 1 To Size.x
    For j = 1 To Size.y
      tmpObj.MapObj(i, j) = ObjNum
      tmpObj.ObjStruct(i, j).x = i
      tmpObj.ObjStruct(i, j).y = j
    Next j
  Next i
  
  FileNum = FreeFile
  AddFile ObjName, FileNum
  Open App.Path & "\Objects\" & ObjName & ".txt" For Input As FileNum
        Do Until EOF(FileNum)
            Line Input #FileNum, Intext
            If (Not (Intext = "") Or (Intext = ";")) Then
                Select Case (Intext)
                  Case BLOCKROW
                     Input #FileNum, blk
                     For i = 1 To Size.x
                        tmpObj.ObjKey(i, blk) = Block
                     Next
                  Case BLOCKCOL
                     Input #FileNum, blk
                     For i = 1 To Size.y
                        tmpObj.ObjKey(blk, i) = Block
                     Next
                  Case BLOCKROWNOCAM
                     Input #FileNum, blk
                     For i = 1 To Size.x
                        tmpObj.ObjKey(i, blk) = BlockNoCam
                     Next
                  Case BLOCKCOLNOCAM
                     Input #FileNum, blk
                     For i = 1 To Size.y
                        tmpObj.ObjKey(blk, i) = BlockNoCam
                     Next
                  Case BLOCKCAMROW
                     Input #FileNum, blk
                     For i = 1 To Size.x
                        tmpObj.ObjKey(i, blk) = BlockCam
                     Next
                  Case BLOCKCAMCOL
                     Input #FileNum, blk
                     For i = 1 To Size.y
                        tmpObj.ObjKey(blk, i) = BlockCam
                     Next
                  Case MOVEABLE
                    For i = 1 To Size.x
                      For j = 1 To Size.y
                        tmpObj.ObjKey(Size.x, Size.y) = Movable
                      Next j
                    Next i
                End Select
            End If
        Loop
Close #FileNum
GenMatrix = tmpObj
End Function

Public Sub InsertMatrix(Pos As XY, Matrix As MatrixList, LNum As Integer)
Dim i%, j%
Pos.x = Pos.x: Pos.y = Abs(Pos.y)
For i = 0 To Matrix.MtxSize.x - 1
  For j = 0 To Matrix.MtxSize.y - 1
    Layer(LNum).MapObj(Pos.x + i, Pos.y + j) = Matrix.MapObj(i + 1, j + 1)
    Layer(LNum).ObjStruct(Pos.x + i, Pos.y + j) = Matrix.ObjStruct(i + 1, j + 1)
    If Matrix.ObjKey(1, 1) = Movable Then
      Layer(LNum).ObjKey(Pos.x + i, Pos.y + j) = Matrix.ObjKey(i + 1, j + 1) & NumFrames
    Else
      Layer(LNum).ObjKey(Pos.x + i, Pos.y + j) = Matrix.ObjKey(i + 1, j + 1)
    End If
  Next
Next
End Sub

Public Function IsBlock(CurPos As XY) As Boolean
Dim NumL As Integer, i%, j%
On Error GoTo Err
For NumL = 1 To 1
    For i = 1 To 4
    Select Case i
      Case 1
        If (Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) <> "" And Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) <> BlockCam) And Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) <> Char & "1" Then
          IsBlock = True
          Exit Function
        End If
      Case 2
        If (Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) <> "" And Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) <> BlockCam) And Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) <> Char & "1" Then
          IsBlock = True
          Exit Function
        End If
      Case 3
        If (Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) <> "" And Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) <> BlockCam) And Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) <> Char & "1" Then
          IsBlock = True
          Exit Function
        End If
      Case 4
        If (Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) <> "" And Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) <> BlockCam) And Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) <> Char & "1" Then
          IsBlock = True
          Exit Function
        End If
      End Select
    Next
Next NumL
Exit Function
Err:
IsBlock = True
End Function

Public Function IsCBlock(CurPos As XY) As Boolean
Dim NumL As Integer, i%, j%
On Error GoTo Err
For NumL = 1 To 1
    For i = 1 To 4
    Select Case i
      Case 1
        If Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = Block Or Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = BlockCam Then
          IsCBlock = True
          Exit Function
        End If
      Case 2
        If Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = Block Or Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = BlockCam Then
          IsCBlock = True
          Exit Function
        End If
      Case 3
        If Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = Block Or Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = BlockCam Then
          IsCBlock = True
          Exit Function
        End If
      Case 4
        If Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = Block Or Layer(NumL).ObjKey(((CurPos.x \ 10)), Abs(((CurPos.y) \ 10))) = BlockCam Then
          IsCBlock = True
          Exit Function
        End If
      End Select
    Next
Next NumL
Exit Function
Err:
IsCBlock = True
End Function

Public Function MakeLayerBlock(SizeX As Integer, SizeY As Integer, StartX As Integer, StartY As Integer)
Dim i%, j%
For i = StartY To SizeY + StartY - 1
  For j = StartX To SizeX + StartX - 1
    Layer(1).ObjKey(i, j) = Block
  Next
Next
End Function

Public Function InsertEvent(EName As String)
Dim Inx As Integer, x%, y%
Inx = GetEMapINX(EName)
For x = 0 To MapEvents(Inx).Size.x - 1
  For y = 0 To MapEvents(Inx).Size.y - 1
    Layer(2).ObjKey(MapEvents(Inx).Position.x + x, MapEvents(Inx).Position.y + y) = "E-" & EName
  Next
Next
End Function

Public Function DeleteEvent(EName As String)
Dim Inx As Integer, x%, y%
On Local Error Resume Next
Inx = GetEMapINX(EName)
For x = 0 To MapEvents(Inx).Size.x - 1
  For y = 0 To MapEvents(Inx).Size.y - 1
    Layer(2).ObjKey(MapEvents(Inx).Position.x + x, MapEvents(Inx).Position.y + y) = ""
  Next
Next
End Function

Public Function GetEMapINX(EName As String) As Integer
Dim i%
For i = LBound(MapEvents) To UBound(MapEvents)
  If MapEvents(i).EventName = EName Then
    GetEMapINX = i
    Exit Function
  End If
Next
End Function

Public Function IsEvent(CurPos As XY) As Boolean
Dim NumL As Integer, i%, j%
On Error GoTo Err
For NumL = 2 To 2
    For i = 1 To 4
    Select Case i
      Case 1
        If Left(Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))), 2) = E_ Then
          IsEvent = True
          CurEvent = Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10)))
          CurEvent = Right(CurEvent, Len(CurEvent) - 2)
          Exit Function
        End If
      Case 2
        If Left(Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))), 2) = E_ Then
          IsEvent = True
          CurEvent = Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10)))
          CurEvent = Right(CurEvent, Len(CurEvent) - 2)
          Exit Function
        End If
      Case 3
        If Left(Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))), 2) = E_ Then
          IsEvent = True
          CurEvent = Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10)))
          CurEvent = Right(CurEvent, Len(CurEvent) - 2)
          Exit Function
        End If
      Case 4
        If Left(Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))), 2) = E_ Then
          IsEvent = True
          CurEvent = Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10)))
          CurEvent = Right(CurEvent, Len(CurEvent) - 2)
          Exit Function
        End If
      End Select
    Next
Next NumL
Exit Function
Err:
IsEvent = False
CurEvent = ""
End Function

Public Function RotateMatrix(Mtx As MatrixList, Direction As String) As MatrixList
Dim tmpMtx As MatrixList, Xo As Integer, Yo As Integer, X1 As Integer, Y1 As Integer
Dim x%, y%, ObjNum%

tmpMtx = Mtx
Select Case UCase(Direction)
  Case North
  x = tmpMtx.MtxSize.x: y = tmpMtx.MtxSize.y
  X1 = x: Y1 = y
    For Xo = 1 To x
      For Yo = 1 To y
        tmpMtx.ObjStruct(Xo, Yo).x = X1
        tmpMtx.ObjStruct(Xo, Yo).y = Y1
        tmpMtx.ObjKey(X1, Y1) = Mtx.ObjKey(Xo, Yo)
        Y1 = Y1 - 1
      Next
      X1 = X1 - 1
      Y1 = y
    Next

  Case East
    ObjNum = tmpMtx.MapObj(1, 1)
    tmpMtx.MtxSize.x = Mtx.MtxSize.y: tmpMtx.MtxSize.y = Mtx.MtxSize.x
    ReDim tmpMtx.MapObj(tmpMtx.MtxSize.x, tmpMtx.MtxSize.y)
    ReDim tmpMtx.ObjKey(tmpMtx.MtxSize.x, tmpMtx.MtxSize.y)
    ReDim tmpMtx.ObjStruct(tmpMtx.MtxSize.x, tmpMtx.MtxSize.y)
    x = tmpMtx.MtxSize.x: y = tmpMtx.MtxSize.y
    X1 = y: Y1 = 1
      For Xo = 1 To x
        For Yo = 1 To y
          tmpMtx.ObjStruct(Xo, Yo).x = X1
          tmpMtx.ObjStruct(Xo, Yo).y = Y1
          tmpMtx.MapObj(Xo, Yo) = ObjNum
          tmpMtx.ObjKey(Xo, Yo) = Mtx.ObjKey(X1, Y1)
          X1 = X1 - 1
        Next
        X1 = y
        Y1 = Y1 + 1
      Next
  Case West
    ObjNum = tmpMtx.MapObj(1, 1)
    tmpMtx.MtxSize.x = Mtx.MtxSize.y: tmpMtx.MtxSize.y = Mtx.MtxSize.x
    ReDim tmpMtx.MapObj(tmpMtx.MtxSize.x, tmpMtx.MtxSize.y)
    ReDim tmpMtx.ObjKey(tmpMtx.MtxSize.x, tmpMtx.MtxSize.y)
    ReDim tmpMtx.ObjStruct(tmpMtx.MtxSize.x, tmpMtx.MtxSize.y)
    x = tmpMtx.MtxSize.x: y = tmpMtx.MtxSize.y
    X1 = 1: Y1 = x
      For Xo = 1 To x
        For Yo = 1 To y
          tmpMtx.ObjStruct(Xo, Yo).x = X1
          tmpMtx.ObjStruct(Xo, Yo).y = Y1
          tmpMtx.MapObj(Xo, Yo) = ObjNum
          tmpMtx.ObjKey(Xo, Yo) = Mtx.ObjKey(X1, Y1)
          X1 = X1 + 1
        Next
        X1 = 1
        Y1 = Y1 - 1
      Next
End Select
RotateMatrix = tmpMtx
End Function

Public Function IsMovable(CurPos As XY) As Boolean
Dim NumL As Integer, i%, j%
On Error GoTo Err
For NumL = 1 To 1
    For i = 1 To 4
    Select Case i
      Case 1
        If Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) = Movable Then
          IsMovable = True
          Exit Function
        End If
      Case 2
        If Layer(NumL).ObjKey(((CurPos.x + WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) = Movable Then
          IsMovable = True
          Exit Function
        End If
      Case 3
        If Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y + WorldAni(1).AniSize.y) \ 10))) = Movable Then
          IsMovable = True
          Exit Function
        End If
      Case 4
        If Layer(NumL).ObjKey(((CurPos.x - WorldAni(1).AniSize.x) \ 10), Abs(((CurPos.y - WorldAni(1).AniSize.y) \ 10))) = Movable Then
          IsMovable = True
          Exit Function
        End If
      End Select
    Next
Next NumL
Exit Function
Err:
IsMovable = False
End Function

Public Function GetCurDir2(ObjName As String) As String
Dim tmpDir As D3DVECTOR, tmpUp As D3DVECTOR
CharFrames(GetCharIndex(ObjName)).GetOrientation Nothing, tmpDir, tmpUp

If IsBetween(CDbl(tmpDir.x), 0.99, 1) = True Then
  GetCurDir2 = East
  Exit Function
ElseIf IsBetween(CDbl(tmpDir.x), -1, -0.99) = True Then
  GetCurDir2 = West
  Exit Function
End If

If IsBetween(CDbl(tmpDir.Z), 0.99, 1) = True Then
  GetCurDir2 = South
  Exit Function
ElseIf IsBetween(CDbl(tmpDir.Z), -1, -0.99) = True Then
  GetCurDir2 = North
  Exit Function
End If
GetCurDir2 = "NONE"
End Function

Public Function GetCurDir(ObjName As String) As String
Dim tmpDir As D3DVECTOR, tmpUp As D3DVECTOR
CharFrames(GetCharIndex(ObjName)).GetOrientation Nothing, tmpDir, tmpUp

If IsBetween(CDbl(tmpDir.x), 0.95, 1) = True Then
  GetCurDir = East
  Exit Function
ElseIf IsBetween(CDbl(tmpDir.x), -1, -0.95) = True Then
  GetCurDir = West
  Exit Function
End If

If IsBetween(CDbl(tmpDir.Z), 0.95, 1) = True Then
  GetCurDir = South
  Exit Function
ElseIf IsBetween(CDbl(tmpDir.Z), -1, -0.95) = True Then
  GetCurDir = North
  Exit Function
End If
GetCurDir = "NONE"
End Function

Public Function GetCurDir3(ObjName As String) As String
Dim tmpDir As D3DVECTOR, tmpUp As D3DVECTOR
CharFrames(GetCharIndex(ObjName)).GetOrientation Nothing, tmpDir, tmpUp

If IsBetween(CDbl(tmpDir.x), 1, 1) = True Then
  GetCurDir3 = East
  Exit Function
ElseIf IsBetween(CDbl(tmpDir.x), -1, -1) = True Then
  GetCurDir3 = West
  Exit Function
End If

If IsBetween(CDbl(tmpDir.Z), 1, 1) = True Then
  GetCurDir3 = South
  Exit Function
ElseIf IsBetween(CDbl(tmpDir.Z), -1, -1) = True Then
  GetCurDir3 = North
  Exit Function
End If
GetCurDir3 = "NONE"
End Function

Public Function IsBetween(OrigVal As Double, StartVal As Double, EndVal As Double) As Boolean
If OrigVal >= StartVal And OrigVal <= EndVal Then IsBetween = True
End Function

Public Function GetFront(CharName As String) As XY
Dim tmpDir As String, tmpCharXY As XY
tmpDir = GetCurDir(GetCharName(Val(Right(CharName, Len(CharName) - 1))))
tmpCharXY = GetCharXY(CharName)
Select Case tmpDir
  Case North
    tmpCharXY.y = tmpCharXY.y - 1
  Case South
    tmpCharXY.y = tmpCharXY.y + 1
  Case West
    tmpCharXY.x = tmpCharXY.x + 1
  Case East
    tmpCharXY.x = tmpCharXY.x - 1
End Select
GetFront = tmpCharXY
End Function

Public Function GetFrontX2(CharName As String) As XY
Dim tmpDir As String, tmpCharXY As XY
tmpDir = GetCurDir(GetCharName(Val(Right(CharName, Len(CharName) - 1))))
tmpCharXY = GetCharXY(CharName)
Select Case tmpDir
  Case North
    tmpCharXY.y = tmpCharXY.y - 2
  Case South
    tmpCharXY.y = tmpCharXY.y + 2
  Case West
    tmpCharXY.x = tmpCharXY.x + 2
  Case East
    tmpCharXY.x = tmpCharXY.x - 2
End Select
GetFrontX2 = tmpCharXY
End Function

Public Function IsM(CurPos As XY) As Boolean
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Left(Layer(1).ObjKey(CurPos.x, CurPos.y), 1) = Movable Then IsM = True
End Function

Public Function IsBlank(CurPos As XY) As Boolean
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Layer(1).ObjKey(CurPos.x, CurPos.y) = "" Then IsBlank = True
End Function
Public Function IsBlank2(CurPos As XY) As Boolean
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Layer(2).ObjKey(CurPos.x, CurPos.y) = "" Then IsBlank2 = True
End Function

Public Function IsChar(CurPos As XY) As Boolean
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Left(Layer(1).ObjKey(CurPos.x, CurPos.y), 1) = "C" And Layer(1).ObjKey(CurPos.x, CurPos.y) <> "C1" Then IsChar = True
End Function

Public Function IsMainChar(CurPos As XY) As Boolean
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Left(Layer(1).ObjKey(CurPos.x, CurPos.y), 1) = "C" And Layer(1).ObjKey(CurPos.x, CurPos.y) = "C1" Then IsMainChar = True
End Function

Public Function IsLoadMap(CurPos As XY) As Boolean
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Left(Layer(2).ObjKey(CurPos.x, CurPos.y), 6) = "E-Goto" Then IsLoadMap = True
End Function

Public Function IsTalk(CurPos As XY) As Boolean
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Left(Layer(2).ObjKey(CurPos.x, CurPos.y), 6) = "E-Talk" Then IsTalk = True
End Function


Public Function GetM(CurPos As XY) As String
CurPos.x = CInt(Abs(CurPos.x))
CurPos.y = CInt(Abs(CurPos.y))
  If Left(Layer(1).ObjKey(CurPos.x, CurPos.y), 1) = Movable Then GetM = Layer(1).ObjKey(CurPos.x, CurPos.y)
End Function


Public Function GetCharXY(CharCode As String) As XY
Dim x%, y%, tmpXY As XY
For x = 1 To 60
  For y = 1 To 60
    If Layer(1).ObjKey(x, y) = CharCode Then
      tmpXY.x = x: tmpXY.y = y
      GetCharXY = tmpXY
      Exit Function
    End If
  Next
Next
End Function


