Attribute VB_Name = "mdlFunctions"
Option Explicit
Option Base 1
Option Compare Text



Public Function GetValFromString(str As String) As Integer
Dim i As Integer, ltr As String, tmp As String
For i = 1 To Len(str)
  ltr = Mid(str, i, 1)
  If Val(ltr) > 0 Then
    tmp = tmp & ltr
  ElseIf ltr = "0" Then
    tmp = tmp & ltr
  End If
Next
GetValFromString = Val(tmp)
End Function

Public Function GetCenterPos(CharName As String) As D3DVECTOR
Dim CInx As Integer, tmpXY As XY, tmpPos As D3DVECTOR, tmpD3D As D3DVECTOR
CInx = GetCharIndex(CharName)
CharFrames(CInx).GetPosition Nothing, tmpPos
tmpXY = GetMtxXY(tmpPos)
tmpPos.x = tmpXY.x * 10
tmpPos.Z = tmpXY.y * 10
tmpD3D = WorldAni(CInx).AniSize
WorldAni(CInx).AniSize.x = 10
WorldAni(CInx).AniSize.y = 10
WorldAni(CInx).AniSize.Z = 10
tmpPos = GetAniPos(CharName, tmpPos, GetCurDir((GetCharName(CInx))))
WorldAni(CInx).AniSize = tmpD3D
GetCenterPos = tmpPos
End Function

Public Function GetCenterPos2(Pos As D3DVECTOR) As D3DVECTOR
Dim tmpPos As D3DVECTOR
tmpPos.x = Pos.x + 5
tmpPos.Z = Pos.Z + 5
GetCenterPos2 = tmpPos
End Function

Public Function GetDummyCenterPos(Pos As D3DVECTOR) As D3DVECTOR
Dim tmpPos As D3DVECTOR
tmpPos.x = Pos.x + 5
tmpPos.y = Pos.y + 5
tmpPos.Z = Pos.Z + 5
GetDummyCenterPos = tmpPos
End Function

Public Function ShallMoveTo(ObjName As String) As String
Dim tmpDir As D3DVECTOR, tmpUp As D3DVECTOR, tmp As String
CharFrames(GetCharIndex(ObjName)).GetOrientation Nothing, tmpDir, tmpUp

If IsBetween(CDbl(tmpDir.Z), -1, 1) = True And (LastDirection = West Or LastDirection = East) And (LastDirection <> South Or LastDirection <> North) Then
  If IsBetween(CDbl(tmpDir.Z), 0, 1) = True Then
    tmp = 1
  End If
  If IsBetween(CDbl(tmpDir.Z), -1, 0) = True Then
    tmp = 2
  End If
Else
  If IsBetween(CDbl(tmpDir.x), 0, 1) = True Then
  tmp = 4
  End If
  If IsBetween(CDbl(tmpDir.x), -1, 0) = True Then
  tmp = 3
  End If
End If
ShallMoveTo = tmp
End Function

Public Function DeleteLetter(Letter As String, Word As String) As String
Dim i As Integer, tmp As String, ltr As String
For i = 1 To Len(Word)
  ltr = Mid(Word, i, 1)
  If ltr = Letter Then
    tmp = tmp & " "
  Else
    tmp = tmp & ltr
  End If
Next
DeleteLetter = Trim(tmp)
End Function

Public Sub SaveNewEname(Txt As String, EName As String, Inx As Integer)
  Dim FileNum As Integer
  FileNum = FreeFile
  AddFile EName, FileNum
  Open App.Path & "\Events\" & NameOfMap & "\" & EName & "xxx" & Inx & ".txt" For Output As FileNum
      Write #FileNum, Txt
      Close #FileNum
End Sub

Public Sub GetNextEvent(EName As String, NumOf As Integer)
Dim FileNum As Integer, StartCopy As Boolean, CopyTxt As String, NumOfNext As Integer
Dim Intext As String, tmp As String
FileNum = FreeFile
AddFile EName, FileNum
Open App.Path & "\Events\" & NameOfMap & "\" & EName & ".txt" For Input As FileNum
Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Then
      
      
      
      If Intext = TERMINATOR And StartCopy = True Then
        SaveNewEname CopyTxt, EName, NumOf
        Exit Sub
      End If
      
      If StartCopy = True Then
        CopyTxt = Chr(13) + Chr(10) & CopyTxt & Intext & Chr(13) + Chr(10)
      End If
    
      tmp = GetCommand(Intext)
      If tmp = NEXTEVENT Then
      NumOfNext = NumOfNext + 1
      If NumOf = NumOfNext Then StartCopy = True
      End If
      
      
    End If
Loop
End Sub

Public Sub PushInx(x As Integer)
Dim i%, k%
If UBound(IndexArray) <= 1 And IndexArray(LBound(IndexArray)) = -1 Then
IndexArray(LBound(IndexArray)) = x
Else
ReDim Preserve IndexArray(UBound(IndexArray) + 1)
For i = UBound(IndexArray) To 2 Step -1
  k = i - 1
  IndexArray(i) = IndexArray(k)
  IndexArray(k) = -1
Next
IndexArray(LBound(IndexArray)) = x
End If
End Sub

Public Function PopInx() As Integer
Dim i%, tmp%, k%
tmp = IndexArray(LBound(IndexArray))
IndexArray(LBound(IndexArray)) = -1

For i = LBound(IndexArray) To UBound(IndexArray) - 1
  k = i + 1
  IndexArray(i) = IndexArray(k)
  IndexArray(k) = -1
Next
If LBound(IndexArray) <= 1 Then
ReDim Preserve IndexArray(UBound(IndexArray))
Else
ReDim Preserve IndexArray(UBound(IndexArray) - 1)
End If

PopInx = tmp
End Function

Public Function GetFreeEvent() As Integer
Dim i As Integer
For i = LBound(WorldEvents) To UBound(WorldEvents)
  If WorldEvents(i).Allocated = False Then
    GetFreeEvent = i
    Exit Function
  End If
Next
GetFreeEvent = UBound(WorldEvents)
End Function

Public Function MoveObject(ObjNum As Integer, TargetXY As XY) As Boolean
Dim ObjPos As D3DVECTOR
Dim TargetPos As D3DVECTOR, ObjINX As Integer
ObjINX = GetObjIndex(GetLObjName(ObjNum))

  TargetPos.x = (WorldObj(ObjINX).ObjSize.x / 2) + (TargetXY.x * 10)
  TargetPos.Z = (WorldObj(ObjINX).ObjSize.Z / 2) + (TargetXY.y * 10)
  ObjFrames(ObjNum).GetPosition Nothing, ObjPos
  
  Select Case GetCurDir(GetCharName(LBound(WorldAni)))
    Case North
      'z = -
      ObjFrames(ObjNum).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, 0.8 * GSpeed
      ObjFrames(ObjNum).GetPosition Nothing, ObjPos
      If Abs(ObjPos.Z) <= TargetPos.Z Then MoveObject = True
    Case South
      'z = +
      ObjFrames(ObjNum).AddTranslation D3DRMCOMBINE_BEFORE, 0, 0, -0.8 * GSpeed
      ObjFrames(ObjNum).GetPosition Nothing, ObjPos
      If Abs(ObjPos.Z) >= TargetPos.Z Then MoveObject = True
    Case West
      'x = -
      ObjFrames(ObjNum).AddTranslation D3DRMCOMBINE_BEFORE, 0.8 * GSpeed, 0, 0
      ObjFrames(ObjNum).GetPosition Nothing, ObjPos
      If ObjPos.x >= TargetPos.x Then MoveObject = True
    Case East
      'x = +
      ObjFrames(ObjNum).AddTranslation D3DRMCOMBINE_BEFORE, -0.8 * GSpeed, 0, 0
      ObjFrames(ObjNum).GetPosition Nothing, ObjPos
      If ObjPos.x <= TargetPos.x Then MoveObject = True
  End Select
      AI
      D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
      D3D_Device.Update 'Update the Direct3D Device.
      D3D_ViewPort.Render FR_Root
      DS_Front.Flip Nothing, DDFLIP_WAIT
End Function

Public Function GetNumWords(x As String) As Integer
Dim L As String, i As Integer, tmp As Integer
For i = 1 To Len(x)
  L = Mid(x, i, 1)
  If L = " " Then tmp = tmp + 1
Next
GetNumWords = tmp
End Function

Public Function GetWord(Sentence As String, Num As Integer) As String
Dim i As Integer, tmp As String, L As String, WordNum As Integer, T As Boolean
If Len(Sentence) >= 80 Then Sentence = Sentence & " .. ": T = True
WordNum = -1
For i = 1 To Len(Sentence)
  L = Mid(Sentence, i, 1)
  tmp = tmp & L
  If L = " " Then
    WordNum = WordNum + 1
    If WordNum = Num Then
      GetWord = tmp
      If T = True Then Sentence = Left(Sentence, Len(Sentence) - 4)
      Exit Function
    Else
      tmp = ""
    End If
  End If
Next

End Function

Public Function GetMessage(Language As String, MName As String) As String
Dim FileNum As Integer, tmpVal As XVal, tmpMsg As String
Dim Intext As String, tmp As String, MNum As String, ValLocked As Boolean
FileNum = FreeFile
AddFile MName, FileNum
Open App.Path & "\Dialogs\" & NameOfMap & "\" & GetMessageText(MName) & ".txt" For Input As FileNum
MNum = GetMessageNum(MName)
Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Then
      tmp = GetCommand(Intext)
      If ValLocked = True And tmp = TERMINATOR Then
        Exit Function
      End If
      If tmp = MNum Or ValLocked = True Then
        ValLocked = True
        Select Case tmp
          Case Lang1
            If Language = "A" Then
              tmpVal = GetEventValues(Intext)
              tmpMsg = tmpVal.val1
              GoTo ENDFUNC
            End If
          Case Lang2
            If Language = "B" Then
              tmpVal = GetEventValues(Intext)
              tmpMsg = tmpVal.val1
              GoTo ENDFUNC
            End If
          Case Lang3
            If Language = "C" Then
              tmpVal = GetEventValues(Intext)
              tmpMsg = tmpVal.val1
              GoTo ENDFUNC
            End If
        End Select
      End If
    End If
Loop
ENDFUNC:
Close #FileNum
GetMessage = tmpMsg
End Function

Public Function GetMessageText(MName As String) As String
Dim i As Integer, L As String, tmp As String
For i = 1 To Len(MName)
  L = Mid(MName, i, 1)
  If L = "<" Then
    GetMessageText = tmp
    Exit Function
  Else
    tmp = tmp & L
  End If
Next
GetMessageText = tmp
End Function

Public Function GetMessageNum(MName As String) As String
Dim i As Integer, L As String, tmp As String, HasVal As Boolean
For i = 1 To Len(MName)
  L = Mid(MName, i, 1)
  If L = "<" Then
    tmp = "<"
    HasVal = True
  Else
    tmp = tmp & L
  End If
Next
If HasVal = True Then
  GetMessageNum = (tmp)
Else
  GetMessageNum = ""
End If
End Function

