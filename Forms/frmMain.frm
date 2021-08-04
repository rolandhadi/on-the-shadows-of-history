VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "On The Shadows Of History"
   ClientHeight    =   3165
   ClientLeft      =   3510
   ClientTop       =   3585
   ClientWidth     =   4680
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MouseIcon       =   "frmMain.frx":0CCA
   MousePointer    =   99  'Custom
   Picture         =   "frmMain.frx":1594
   ScaleHeight     =   3165
   ScaleWidth      =   4680
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Option Base 1
Option Compare Text

Dim BlinkTask As Boolean, BlinkTime As Long

Private Sub Form_Load()
  'Me.Show 'Some computers do weird stuff if you don't show the form.
  DoEvents 'Give the computer time to do what it needs to do
  DX_Init 'Initialize DirectX
  LoadMap LoadThisMap  'Make frames, lights, and mesh(es)"
  DX_Render 'The Main Loop
End Sub

Private Sub DX_Render()
Dim Pos As D3DVECTOR, i%, j%
 Unload frmStart
 Do While esc = False
 
   'On Local Error Resume Next 'Incase there is an error
   DoEvents 'Give the computer time to do what it needs to do.
ReturnToLoad:
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
    
   If ChangeMap = True Then
    ChangeMap = False
    LoadMap ChangeMapName
    If tmpLoadingGame = True Then GoTo ReturnToLoad
    ChangeMapName = ""
    BlankTheScreen = False
    'Exit Sub
   End If
   
   CharFrames(1).GetPosition Nothing, Pos
   MoveLights
   GetTick
   GSpeed = GetGameSpeed
   DX_GameInput
   DX_Input 'Call the input sub
   
   If StartEventName <> "" Then
    LoadEvents StartEventName
    BlankTheScreen = True
    ShowBlankScreen
    ExecuteEvent StartEventName
    StartEventName = ""
  Else
    BlankTheScreen = False
  End If
   
   
   
   If IsM(GetFront(Char & "1")) = True Then
    AnimPanel "Push"
   ElseIf IsTalk(GetMtxXY(Pos)) = True Then
    AnimPanel "Talk"
   ElseIf IsLoadMap(GetMtxXY(Pos)) = True Then
     AnimPanel "Open"
   ElseIf IsBlank2(GetMtxXY(Pos)) = False Then
     AnimPanel "Check"
   Else
    AnimPanel NONE
   End If
   
   
   If BlankTheScreen = True Then
    ShowBlankScreen
   Else
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
   End If
   
   If MapLoaded = True Then
      If PanelPic = "" Then
       DS_Back.BltFast 640 - 116, 0, Panel.SPanel(PanelINX).SSurf, Panel.SPanel(PanelINX).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      Else
       Select Case PanelPic
         Case "Open"
           DS_Back.BltFast 640 - 116, 0, Panel.SOpen.SSurf, Panel.SOpen.SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
         Case "Check"
           DS_Back.BltFast 640 - 116, 0, Panel.SCheck.SSurf, Panel.SCheck.SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
         Case "Talk"
           DS_Back.BltFast 640 - 116, 0, Panel.STalk.SSurf, Panel.STalk.SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
         Case "Push"
           DS_Back.BltFast 640 - 116, 0, Panel.SPush.SSurf, Panel.SPush.SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
         Case Else
           DS_Back.BltFast 640 - 116, 0, Panel.SPanel(PanelINX).SSurf, Panel.SPanel(PanelINX).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
       End Select
      End If
      
      i = GetSpriteIndex("Compass")
      DS_Back.BltFast 1, 1, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      
      i = GetSpriteIndex("GMenu")
      DS_Back.BltFast 0, 440, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      
      If GetTickCount() - BlinkTime <= 600 Then
          If BlinkTask = True And NewTask = True Then
            i = GetSpriteIndex("NewTask")
            DS_Back.BltFast 5, 300, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
          End If
      Else

         BlinkTime = GetTickCount
          If BlinkTask = True Then
           BlinkTask = False
          Else
           BlinkTask = True
          End If
          
      End If
      
      i = GetSpriteIndex("Chicken")
      WorldSprite(i).SRect = AnimCompass(LastDirection)
      DS_Back.BltFast 24, 16, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      
      'DS_Back.DrawText 1, 100, "Character Position:  X:" & Int(Pos.Z) & " Y:" & Int(Pos.x), False
      DS_Back.DrawText 29, 449, curPrintMapName, False
'      DS_Back.DrawText 1, 30, "FPS: " & Format(LastFrameCount, "00"), False
      DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
      ExecuteConditions
      AI
  End If
  CheckBGMusicLoop
  
  UpdateGameTimer
  EventCancel = False
  
  If GameWillForceExit = True Then
      GameWillForceExit = False
      DX_Exit
      Exit Sub
  End If
  
 Loop
End Sub
