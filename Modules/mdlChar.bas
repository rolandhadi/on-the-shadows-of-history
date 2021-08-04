Attribute VB_Name = "mdlChar"
Option Explicit
Option Base 1
Option Compare Text
Public CharPointer As Direct3DRMFrame3
Public CharPointerHead As Direct3DRMFrame3
Public CharPointerFoot As Direct3DRMFrame3

Public Type InvisibleObject
  ObjFrame As Direct3DRMFrame3
  ObjName As String
  ObjPos As D3DVECTOR
End Type: Public WorldDummy() As InvisibleObject
Public NumDummy As Integer

Public Sub AlignPointer(CharName As String)
Dim CharINX As Integer
CharINX = GetCharIndex(CharName)
CharPointer.SetPosition CharFrames(CharINX), 0, -1.5, 0
CharPointerHead.SetPosition CharFrames(CharINX), 0, 10, 0
CharPointerFoot.SetPosition CharFrames(CharINX), 0, -10, 0
End Sub

Public Function GetCharPointerPos(CharName As String, AniName As String) As XY
Dim i%, j%, tmp As XY
For i = LBound(WorldAni) To UBound(WorldAni)
  If WorldAni(i).AniName = (CharName) Then
    For j = LBound(WorldAni(i).AniStruct) To UBound(WorldAni(i).AniStruct)
      If (WorldAni(i).AniStruct(j).AniName) = (AniName) Then
        tmp.x = WorldAni(i).AniStruct(j).AniStart
        tmp.y = WorldAni(i).AniStruct(j).AniEnd
        GetCharPointerPos = tmp
        Exit Function
      End If
    Next
  End If
Next
tmp.x = 1
tmp.y = 1
GetCharPointerPos = tmp
End Function

Public Function GetCharIndex(CharName As String) As Integer
Dim i As Integer
For i = LBound(WorldAni) To UBound(WorldAni)
  If WorldAni(i).AniName = (CharName) Then
    GetCharIndex = i
    Exit Function
  End If
Next
GetCharIndex = LBound(WorldAni)
End Function

Public Function GetCharName(CharIndex As Integer) As String
GetCharName = WorldAni(CharIndex).AniName
End Function

Public Function AniPresent(CharName As String, AniName As String) As Boolean
Dim i%, j%
For i = LBound(WorldAni) To UBound(WorldAni)
  If WorldAni(i).AniName = (CharName) Then
    For j = LBound(WorldAni(i).AniStruct) To UBound(WorldAni(i).AniStruct)
      If (WorldAni(i).AniStruct(j).AniName) = (AniName) Then
        AniPresent = True
        Exit Function
      End If
    Next
  End If
Next
End Function

Public Sub AniAdd(CharName As String, AniName As String)

End Sub

Public Sub CreateDummy(DummyName As String, DummyPos As D3DVECTOR)
ReDim Preserve WorldDummy(NumDummy)
WorldDummy(NumDummy).ObjName = DummyName
WorldDummy(NumDummy).ObjPos = DummyPos
Set WorldDummy(NumDummy).ObjFrame = D3D_Main.CreateFrame(FR_Root)
WorldDummy(NumDummy).ObjFrame.SetPosition Nothing, DummyPos.x, DummyPos.y, DummyPos.Z
NumDummy = NumDummy + 1
End Sub

Public Function GetDummyIndex(DummyName As String) As Integer
Dim i As Integer
For i = LBound(WorldDummy) To UBound(WorldDummy)
  If WorldDummy(i).ObjName = UCase(DummyName) Then
    GetDummyIndex = i
    Exit Function
  End If
Next
End Function

Public Sub MoveLights()
Dim i As Integer
  For i = 1 To NumLights - 1
      If UCase(Left(WorldLight(i).LookingAt, 5)) <> "DUMMY" Then
        LightFrames(i).SetPosition CharFrames(WorldLight(i).CharDummyNum), WorldLight(i).LightPos.x, WorldLight(i).LightPos.y, WorldLight(i).LightPos.Z
        LightFrames(i).LookAt CharFrames(WorldLight(i).CharDummyNum), Nothing, D3DRMCONSTRAIN_Z
      End If
    Next
End Sub
