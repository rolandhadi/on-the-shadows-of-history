Attribute VB_Name = "mdl2D"
Option Explicit
Option Base 1
Option Compare Text

Public AniX%, AniY%
Public GFont As New StdFont, PanelINX As Integer, PanelPic As String
Public SFont As New StdFont
Dim HasBeep As Boolean, AniTCompass As Long

Public Type SpriteObj
  Sname As String
  SSurf As DirectDrawSurface4
  SSurfDesc As DDSURFACEDESC2
  SRect As RECT
End Type: Public WorldSprite() As SpriteObj

Public Type PanelObj
  SPanel(4) As SpriteObj
  SOpen As SpriteObj
  SCheck As SpriteObj
  STalk As SpriteObj
  SPush As SpriteObj
End Type: Public Panel As PanelObj

Public NumSprites As Integer, AniTimer As Long, tLen As Integer

Public Sub LoadSprite(Sname As String, H As Integer, W As Integer)
  ReDim Preserve WorldSprite(NumSprites)
  WorldSprite(NumSprites).Sname = Sname
  WorldSprite(NumSprites).SRect.Bottom = H
  WorldSprite(NumSprites).SRect.Top = 0
  WorldSprite(NumSprites).SRect.Right = W
  WorldSprite(NumSprites).SRect.Left = 0
  WorldSprite(NumSprites).SSurfDesc.lFlags = DDSD_CAPS
  WorldSprite(NumSprites).SSurfDesc.ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN
  Set WorldSprite(NumSprites).SSurf = DD_Main.CreateSurfaceFromFile(App.Path & "/" & Sname & ".bmp", WorldSprite(NumSprites).SSurfDesc)
  WorldSprite(NumSprites).SSurf.SetColorKey DDCKEY_SRCBLT, cKey
  NumSprites = NumSprites + 1
End Sub

Public Sub LoadPanel()
Dim i As Integer

For i = 0 To 4
  Panel.SPanel(i).SRect.Bottom = 130
  Panel.SPanel(i).SRect.Top = 0
  Panel.SPanel(i).SRect.Right = 106
  Panel.SPanel(i).SRect.Left = 0
  Panel.SPanel(i).SSurfDesc.lFlags = DDSD_CAPS
  Panel.SPanel(i).SSurfDesc.ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN
  Set Panel.SPanel(i).SSurf = DD_Main.CreateSurfaceFromFile(App.Path & "/" & "Panel-" & i + 1 & ".bmp", Panel.SPanel(i).SSurfDesc)
  Panel.SPanel(i).SSurf.SetColorKey DDCKEY_SRCBLT, cKey
Next

i = 6

Panel.SOpen.SRect.Bottom = 130
Panel.SOpen.SRect.Top = 0
Panel.SOpen.SRect.Right = 106
Panel.SOpen.SRect.Left = 0
Panel.SOpen.SSurfDesc.lFlags = DDSD_CAPS
Panel.SOpen.SSurfDesc.ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN
Set Panel.SOpen.SSurf = DD_Main.CreateSurfaceFromFile(App.Path & "/" & "Open-" & i & ".bmp", Panel.SOpen.SSurfDesc)
Panel.SOpen.SSurf.SetColorKey DDCKEY_SRCBLT, cKey

Panel.SCheck.SRect.Bottom = 130
Panel.SCheck.SRect.Top = 0
Panel.SCheck.SRect.Right = 106
Panel.SCheck.SRect.Left = 0
Panel.SCheck.SSurfDesc.lFlags = DDSD_CAPS
Panel.SCheck.SSurfDesc.ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN
Set Panel.SCheck.SSurf = DD_Main.CreateSurfaceFromFile(App.Path & "/" & "Check-" & i & ".bmp", Panel.SCheck.SSurfDesc)
Panel.SCheck.SSurf.SetColorKey DDCKEY_SRCBLT, cKey

Panel.STalk.SRect.Bottom = 130
Panel.STalk.SRect.Top = 0
Panel.STalk.SRect.Right = 106
Panel.STalk.SRect.Left = 0
Panel.STalk.SSurfDesc.lFlags = DDSD_CAPS
Panel.STalk.SSurfDesc.ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN
Set Panel.STalk.SSurf = DD_Main.CreateSurfaceFromFile(App.Path & "/" & "Talk-" & i & ".bmp", Panel.STalk.SSurfDesc)
Panel.STalk.SSurf.SetColorKey DDCKEY_SRCBLT, cKey

Panel.SPush.SRect.Bottom = 130
Panel.SPush.SRect.Top = 0
Panel.SPush.SRect.Right = 106
Panel.SPush.SRect.Left = 0
Panel.SPush.SSurfDesc.lFlags = DDSD_CAPS
Panel.SPush.SSurfDesc.ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN
Set Panel.SPush.SSurf = DD_Main.CreateSurfaceFromFile(App.Path & "/" & "Push-" & i & ".bmp", Panel.SPush.SSurfDesc)
Panel.SPush.SSurf.SetColorKey DDCKEY_SRCBLT, cKey


End Sub

Public Sub AnimPanel(Stat As String)
If GetTickCount() - AniTimer >= tLen Then
      If PanelPic = NONE Then
        If PanelINX >= 6 Then
            PanelINX = 0
          ElseIf PanelINX <= 3 Then
            PanelINX = PanelINX + 1
          ElseIf PanelINX >= 4 Then
          If PanelPic = NONE Then
            PanelINX = 0
            tLen = 120
          End If
        End If
      End If
  Select Case Stat
    Case "Open"
      If PanelINX = 4 Then
        PanelPic = "Open"
        PanelINX = 4
        If HasBeep = False Then
          HasBeep = True
          PlaySound "Check"
        End If
      End If
    Case "Check"
      If PanelINX = 4 Then
        PanelPic = "Check"
        PanelINX = 4
        If HasBeep = False Then
          HasBeep = True
          PlaySound "Check"
        End If
      End If
    Case "Talk"
      If PanelINX = 4 Then
        PanelPic = "Talk"
        PanelINX = 4
        If HasBeep = False Then
          HasBeep = True
          PlaySound "Check"
        End If
      End If
    Case "Push"
      If PanelINX = 4 Then
        PanelPic = "Push"
        PanelINX = 4
        If HasBeep = False Then
          HasBeep = True
          PlaySound "Check"
        End If
      End If
    Case Else
      PanelPic = NONE
      HasBeep = False
  End Select
  AniTimer = GetTickCount
End If
End Sub

Public Function GetSpriteIndex(Sname As String) As Integer
Dim i As Integer
For i = LBound(WorldSprite) To UBound(WorldSprite)
  If WorldSprite(i).Sname = Sname Then
    GetSpriteIndex = i
    Exit Function
  End If
Next
End Function

Public Function GetAniRect(ByVal x As Integer, ByVal y As Integer) As RECT
Dim tmpRect As RECT, tX%, tY%
tX = 32: tY = 48
x = x * tX
y = y * tY
With tmpRect
  .Top = y - tY
  .Bottom = y
  .Left = x - tX
  .Right = x
End With
GetAniRect = tmpRect
End Function


Public Function AnimCompass(CharDir As String) As RECT

If GetTickCount() - AniTCompass >= 300 Then
  Select Case CharDir
    Case North
        AniY = 4
        If AniX > 3 Then AniX = 1 Else AniX = AniX + 1
    Case South
        AniY = 1
        If AniX > 3 Then AniX = 1 Else AniX = AniX + 1
    Case West
        AniY = 3
        If AniX > 3 Then AniX = 1 Else AniX = AniX + 1
    Case East
        AniY = 2
        If AniX > 3 Then AniX = 1 Else AniX = AniX + 1
  End Select
  AniTCompass = GetTickCount
End If
AnimCompass = GetAniRect(AniX, AniY)
End Function

Public Sub DeleteSprite(Sname As String)
Dim i As Integer
  i = GetSpriteIndex(Sname)
  WorldSprite(i).Sname = ""
  WorldSprite(i).SRect.Bottom = 0
  WorldSprite(i).SRect.Top = 0
  WorldSprite(i).SRect.Right = 0
  WorldSprite(i).SRect.Left = 0
  WorldSprite(i).SSurfDesc.lFlags = DDSD_CAPS
  WorldSprite(i).SSurfDesc.ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN
  Set WorldSprite(i).SSurf = DD_Main.CreateSurfaceFromFile(App.Path & "/" & "Cursor" & ".bmp", WorldSprite(i).SSurfDesc)
End Sub
