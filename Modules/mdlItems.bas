Attribute VB_Name = "mdlItems"
Option Explicit
Option Base 1
Option Compare Text

Public Type ItemArrayStruct
  ItemName As String
  ItemXY As XY
End Type

Public ItemArray(3, 10) As ItemArrayStruct
Public IconArray(3) As ItemArrayStruct


Public Sub IniItems()
  Dim x As Integer, y As Integer, PosX As Integer, PosY As Integer
  PosX = 90 + 55: PosY = 110 + 5
  For x = 1 To 3
    For y = 1 To 10
      ItemArray(x, y).ItemXY.x = PosY
      ItemArray(x, y).ItemXY.y = PosX
      ItemArray(x, y).ItemName = ""
      PosY = PosY + 40
    Next
    PosX = PosX + 40
    PosY = 110 + 5
  Next
  
  
  IconArray(1).ItemXY.x = 517
  IconArray(1).ItemXY.y = 127
  
  IconArray(2).ItemXY.x = 516
  IconArray(2).ItemXY.y = 173
  
  IconArray(3).ItemXY.x = 516
  IconArray(3).ItemXY.y = 222
End Sub

Public Sub ShowItems()
Dim i%, j%, ExitMenu As Boolean, MenuIcon As Integer
Dim cursorPos As XY, IsInMenu As Boolean, tmpPos As XY
Dim x%, y%
DX_Input
MenuIcon = 1
cursorPos.x = 1: cursorPos.y = 1
PlaySound "Menu"
Wait 200

Do Until ExitMenu = True
    DX_Input
      If DI_KSTATE.Key(WorldControl.Cancel) <> 0 Then
        ExitMenu = True
        PlaySound "Cancel"
        Wait 200
      ElseIf DI_KSTATE.Key(DIK_H) <> 0 Then
        PlaySound "Cancel"
        GameHelp
        Wait 200
      ElseIf DI_KSTATE.Key(WorldControl.WalkForward) <> 0 Then
        If GetTickCount() - LastKeyPress >= 200 Then
          PlaySound "Select-Item"
          If IsInMenu = True Then
            If MenuIcon = 1 Then
              MenuIcon = 3
            Else
              MenuIcon = MenuIcon - 1
            End If
          Else
            If cursorPos.x <= 1 Then cursorPos.x = 3 Else cursorPos.x = cursorPos.x - 1
          End If
          LastKeyPress = GetTickCount()
        End If
      ElseIf DI_KSTATE.Key(WorldControl.WalkBackward) <> 0 Then
        If GetTickCount() - LastKeyPress >= 200 Then
          PlaySound "Select-Item"
          If IsInMenu = True Then
            If MenuIcon = 3 Then
              MenuIcon = 1
            Else
              MenuIcon = MenuIcon + 1
            End If
          Else
          If cursorPos.x >= 3 Then cursorPos.x = 1 Else cursorPos.x = cursorPos.x + 1
          End If
          LastKeyPress = GetTickCount()
        End If
      ElseIf DI_KSTATE.Key(WorldControl.RotateLeft) <> 0 Then
        If GetTickCount() - LastKeyPress >= 200 Then
          PlaySound "Select-Item"
          If IsInMenu = True Then
            tmpPos = GetPresentItem(NONE)
            If tmpPos.x <> -1 Then
              IsInMenu = False
              cursorPos = tmpPos
            End If
          Else
          If cursorPos.y <= 1 Then IsInMenu = True: MenuIcon = 1 Else cursorPos.y = cursorPos.y - 1
        End If
        LastKeyPress = GetTickCount()
        End If
      ElseIf DI_KSTATE.Key(WorldControl.RotateRight) <> 0 Then
        If GetTickCount() - LastKeyPress >= 200 Then
          PlaySound "Select-Item"
          If IsInMenu = True Then
            tmpPos = GetPresentItem(NONE)
            If tmpPos.x <> -1 Then
              IsInMenu = False
              cursorPos = tmpPos
            End If
          Else
          If cursorPos.y >= 10 Then IsInMenu = True: MenuIcon = 1 Else cursorPos.y = cursorPos.y + 1
        End If
        LastKeyPress = GetTickCount()
        End If
      ElseIf DI_KSTATE.Key(WorldControl.Interact) <> 0 Then
        If GetTickCount() - LastKeyPress >= 200 Then
              Wait 200
              DX_Input
          If IsInMenu = True Then
                Select Case MenuIcon
                Case 1
                  GameSave "(QuickSave)"
                Case 2
                  GameLoad "(QuickSave)"
                  If ItemOnLoading = True Then
                    ExitMenu = True: ItemOnLoading = False
                  End If
                Case 3
                  GameMenu
                End Select
          Else
              If WorldItems(GetItemIndex(ItemArray(cursorPos.x, cursorPos.y).ItemName)).ItemDetail <> "" Then
                ItemsShown = True
                Message "                                                                                                                                                                                                                                            "
                MessageBox WorldItems(GetItemIndex(ItemArray(cursorPos.x, cursorPos.y).ItemName)).ItemDetail, True
                ItemsShown = False
              ElseIf WorldItems(GetItemIndex(ItemArray(cursorPos.x, cursorPos.y).ItemName)).ItemPreview <> "" Then
                ShowPreview WorldItems(GetItemIndex(ItemArray(cursorPos.x, cursorPos.y).ItemName)).ItemPreview
              End If
        End If
        LastKeyPress = GetTickCount()
        End If
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
    i = GetSpriteIndex("Form-Items")
    DS_Back.BltFast 80, 100, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    
    For x = 1 To 3
      For y = 1 To 10
        If ItemPresent(ItemArray(x, y).ItemName) = True Then
          i = GetSpriteIndex(ItemArray(x, y).ItemName)
          DS_Back.BltFast ItemArray(x, y).ItemXY.x - 1, ItemArray(x, y).ItemXY.y - 1, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
        End If
      Next
    Next
    
    i = GetSpriteIndex("Cursor")
    If IsInMenu = False Then
      DS_Back.BltFast ItemArray(cursorPos.x, cursorPos.y).ItemXY.x - 1, ItemArray(cursorPos.x, cursorPos.y).ItemXY.y - 1, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    Else
      DS_Back.BltFast IconArray(MenuIcon).ItemXY.x - 1, IconArray(MenuIcon).ItemXY.y - 1, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    End If
    
    If IsInMenu = False Then
      If ItemPresent(ItemArray(cursorPos.x, cursorPos.y).ItemName) = True Then DS_Back.DrawText 90 + 14, 290, WorldItems(GetItemIndex(ItemArray(cursorPos.x, cursorPos.y).ItemName)).ItemCaption, False
    Else
      Select Case MenuIcon
      Case 1
        DS_Back.DrawText 90 + 14, 290, "Save Game", False
      Case 2
        DS_Back.DrawText 90 + 14, 290, "Load Game", False
      Case 3
        DS_Back.DrawText 90 + 14, 290, "Exit Game", False
      End Select
    End If
    'DS_Back.DrawText 90 + 14, 310, "Press H For Help", False
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Sub

Public Function GetPresentItem(CurItem As String) As XY
Dim x%, y%, tmp As XY
For x = 1 To 3
  For y = 1 To 10
    If ItemArray(x, y).ItemName <> "" And ItemArray(x, y).ItemName <> CurItem Then
      tmp.x = x
      tmp.y = y
      GetPresentItem = tmp
      Exit Function
    End If
  Next
Next
      tmp.x = -1
      tmp.y = -1
      GetPresentItem = tmp
End Function

Public Sub InsertItem(IName As String)
Dim x%, y%
If ItemOnArray(IName) = False Then
  For x = 1 To 3
    For y = 1 To 10
      If ItemArray(x, y).ItemName = "" Then
        ItemArray(x, y).ItemName = IName
        Exit Sub
      End If
    Next
  Next
End If
End Sub

Public Sub DeleteItem(IName As String)
Dim x%, y%
If ItemOnArray(IName) = True Then
  For x = 1 To 3
    For y = 1 To 10
      If ItemArray(x, y).ItemName = IName Then
        ItemArray(x, y).ItemName = ""
        Exit Sub
      End If
    Next
  Next
End If
End Sub

Public Function ItemOnArray(IName As String) As Boolean
Dim x%, y%
  For x = 1 To 3
    For y = 1 To 10
      If ItemArray(x, y).ItemName = IName Then
        ItemOnArray = True
        Exit Function
      End If
    Next
  Next
End Function

Public Sub ShowPreview(PName As String)
  Dim i%, j%, ExitMenu As Boolean
Wait 200
DX_Input
PlaySound "Menu"
LoadSprite PName, 480, 640
Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_RETURN) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      DeleteSprite PName
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
    i = GetSpriteIndex(PName)
      DS_Back.BltFast 0, 0, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    End If
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Sub

Public Sub GameHelp()
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
    ElseIf DI_KSTATE.Key(DIK_RETURN) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
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
          DD_Main.RestoreAllSurfaces 'this just re-allocates memory back to us. we must
      End If
    
    On Local Error Resume Next 'Incase there is an error
    DoEvents 'Give the computer time to do what it needs to do.
    DS_Back.SetForeColor RGB(255, 255, 255)
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
    i = GetSpriteIndex("Form-Help")
    DS_Back.BltFast 80, 100, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Sub

Public Sub ShowIntroScreen(IntroName As String)
Dim i%, j%, ExitMenu As Boolean
Wait 200
DX_Input
PlaySound "Menu"
LoadSprite IntroName, 256, 480
Do Until ExitMenu = True
    DX_Input
    If DI_KSTATE.Key(DIK_ESCAPE) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      Wait 200
      DeleteSprite IntroName
    ElseIf DI_KSTATE.Key(DIK_RETURN) <> 0 Then
      ExitMenu = True
      PlaySound "Cancel"
      Wait 200
      DeleteSprite IntroName
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
    i = GetSpriteIndex(IntroName)
    DS_Back.BltFast 80, 100, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
    DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    CheckBGMusicLoop
    
Loop
Wait 100
DX_Input
End Sub

