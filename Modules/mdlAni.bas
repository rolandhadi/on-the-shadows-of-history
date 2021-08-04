Attribute VB_Name = "mdlAni"
Option Explicit
Option Base 1
Option Compare Text

Public Declare Function GetTickCount Lib "kernel32" () As Long
Public LastTickCount As Long
Public LastFrameCount As Long
Public FrameCount As Long, tmpT As Long


Public Sub Wait(Sec As Double)
Dim lngTickStore As Long
  lngTickStore = GetTickCount()
    Do While lngTickStore + Sec > GetTickCount()
    Loop
End Sub

Public Sub GetTick()
If (GetTickCount() - LastTickCount) >= 1000 Then
            LastFrameCount = FrameCount
            FrameCount = 0
            LastTickCount = GetTickCount()
Else: FrameCount = FrameCount + 1: tmpT = tmpT + 1
End If
End Sub

Public Function GetGameSpeed() As Double
If LastFrameCount <= 30 Then
  GetGameSpeed = 2
Else
  GetGameSpeed = 1
End If
End Function
