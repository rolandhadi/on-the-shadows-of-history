Attribute VB_Name = "mdlObjects"
Option Explicit
Option Base 1
Option Compare Text
Public F_Start As Double, F_End As Double, F_FColor%, F_BColor%
Public MapLoaded As Boolean, curBG As String, curMapName As String
Public LoadingGame As Boolean, tmpLoadingGame As Boolean
Public CanSave As Boolean


Public Const NewMap = "NewMap"
Public Const ConMap = "ContinueMap"
Public Const North = "N"
Public Const South = "S"
Public Const East = "E"
Public Const West = "W"
Public Const Block = "B"
Public Const BlockNoCam = "Q"
Public Const BlockCam = "O"
Public Const Char = "C"
Public Const EVENT_ = "<EVENT>"
Public Const ENABLESAVE = "<ENABLESAVE>"
Public Const TIME_ = "<TIME>"
Public Const BGVOL = "<BGVOL>"
Public Const SEVOL = "<SEVOL>"
Public Const LANG = "<LANGUAGE>"
Public Const STARTEVENT = "<STARTEVENT>"
Public Const BGMUSIC = "<BGMUSIC>"
Public Const NOPROGRESS = "<NOPROGRESS>"
Public Const AMBIENT = "AMBIENT"
Public Const SPOT = "SPOT"
Public Const DIRECTIONAL = "DIRECTIONAL"
Public Const POINT = "POINT"
Public Const NONE = "NONE"
Public Const OBJECT = "<OBJECT>"
Public Const LAYER1 = "<LAYER1>"
Public Const LAYER2 = "<LAYER2>"
Public Const LAYER3 = "<LAYER3>"
Public Const SOUND_ = "<SOUND>"
Public Const FLOADMAP = "<FORCELOADMAP>"
Public Const FPLAYBG = "<FORCEPLAYBG>"
Public Const CREATEOBJ = "<CREATEOBJ>"
Public Const MAKEBLOCK = "<MAKEBLOCK>"
Public Const MAKEDUMMY = "<DUMMY>"
Public Const KEY_ = "<KEY>"
Public Const IF_ = "<IF>"
Public Const THEN_ = "<THEN>"
Public Const CONDITIONAL_ = "<CONDITIONAL>"
Public Const E_ = "E-"
Public Const Dummy_ = "DUMMY"
Public Const LMOUSE = "<LMOUSE>"
Public Const HMOUSE = "<HMOUSE>"
Public Const PLAYBG = "<PLAYBG>"
Public Const GTIME = "<GAMETIME>"
Public Const TASK = "<TASK>"

Public Const CHARACTER = "<CHARACTER>"
Public Const ANIMATION = "<ANIMATION>"

Public Const AI_ = "<AI>"
Public Const SETCHARPOS = "<SETCHARPOS>"
Public Const AIReaction = "<REACTION>"
Public Const AIIDLE = "AIIDLE"
Public Const AISEARCH = "AISEARCH"
Public Const AIFOLLOW = "AIFOLLOW"
Public Const AIMOVEAWAY = "AIMOVEAWAY"
Public Const AIRANDOM = "AIRANDOM"
Public Const AIROTATECLOCK = "AIROTATE+"
Public Const AIROTATECOUNTER = "AIROTATE-"

Public Const NAMEMAP = "<MAPNAME>"
Public Const Size = "<SIZE>"
Public Const LIGHT = "<LIGHT>"
Public Const SURFACE = "<SURFACE>"
Public Const BLOCKROW = "<BLOCKROW>"
Public Const BLOCKCOL = "<BLOCKCOL>"
Public Const BLOCKROWNOCAM = "<BLOCKROWNOCAM>"
Public Const BLOCKCOLNOCAM = "<BLOCKCOLNOCAM>"
Public Const BLOCKCAMROW = "<BLOCKCAMROW>"
Public Const BLOCKCAMCOL = "<BLOCKCAMCOL>"
Public Const Fog_ON = "<FOG>"
Public Const DRAWBACK = "<DRAWBACK>"
Public Const MOVEABLE = "<MOVABLE>"
Public Const Movable = "M"
Public Const ICAPTION = "<CAPTION>"
Public Const IDETAIL = "<DETAILS>"
Public Const IPREVIEW = "<PREVIEW>"

Public StartEventName As String
Public curPrintMapName As String

Public LMousePos As Single
Public HMousePos As Single

Public NameOfMap As String

Public Type XY
  x As Long
  y As Long
End Type
Public Type ConditionalList
  ObjName As String
  ObjNum As Integer
  ConditionalPos As XY
End Type

Public Type ConditionalEvents
  ConditionNum As Integer
  ConSet() As ConditionalList
  NumCondition As Integer
  ConEvent As String
  ConTrue As Boolean
End Type: Public WorldConditions() As ConditionalEvents



Public Type Direction
  dx As Integer: uX As Integer
  dy As Integer: uy As Integer
  dz As Integer: uz As Integer
End Type



Public Type PosDir
  Size As D3DVECTOR
  Direction As String
End Type



Public Type World 'The main matrix that represent the world
  MapObj(60, 60) As Integer  'Represents the object in the world
  ObjStruct(60, 60) As XY 'The structure of the object
  ObjKey(60, 60) As String
End Type: Public Layer(2) As World 'The 3 layered world
                                   'Layer 1 = Ground & Objects
                                   'Layer 2 = Events
Public Type ObjList
  ObjNum As Integer
  ObjName As String
  ObjSize As D3DVECTOR
End Type: Public WorldObj() As ObjList
Public NumObjects As Integer

Public Type LObjList
  ObjNum As Integer
  ObjName As String
  ObjTag As String
  ObjPos  As D3DVECTOR
End Type: Public WorldLObj() As LObjList
Public NumLObjects As Integer

Public Type AniStructure
  AniNum As Integer
  AniName As String
  AniStart As Integer
  AniEnd As Integer
End Type

Public Type AniList
  AniNum As Integer
  AniName As String
  AniSet() As Direct3DRMMeshBuilder3
  AniStruct() As AniStructure
  AniSize As D3DVECTOR
  NowChar As Integer
  PrevChar As Integer
  GlobalKey As Integer
End Type: Public WorldAni() As AniList

Public Type LightList
  LightName As String
  LightPos As D3DVECTOR
  LightVal As D3DCOLORVALUE
  LIGHT As Direct3DRMLight
  LookingAt As String
  CharDummyNum As Integer
End Type: Public WorldLight() As LightList

Public Type CharacterPosition
  PStartPos As PosDir
  ContinueMap As Boolean
  EventNum As Integer
End Type: Public CharacterPos() As CharacterPosition
Public NumCharPos As Integer

Public CurCharPos As CharacterPosition

Public ObjFrames() As Direct3DRMFrame3, NumFrames As Integer
Public SrfFrames() As Direct3DRMFrame3, NumSrfFrames As Integer
Public CharFrames() As Direct3DRMFrame3, NumChar As Integer
Public LightFrames() As Direct3DRMFrame3
Public NumLights As Integer, NumConditions As Integer
Public tmpCam As Direct3DRMFrame3, FLoaded As Boolean

Public Sub LoadMap(MapName As String)
Dim FileNum As Integer, Intext As String, tmpStr As String, FileNum2 As Integer
Dim ObjCnt As Integer, a%, PType As String, XXX As Integer
Dim tmpMsh As Direct3DRMMeshBuilder3
Dim tmpPos As PosDir, tmpVec As D3DVECTOR
Dim tmpDir As Direction, H%, i%, j%
Dim Z As XY, tmpLight As LightList
Dim StartXYZ As D3DVECTOR, NumXYZ As D3DVECTOR, SIZEXYZ As D3DVECTOR
Dim tmpAni As Direct3DRMAnimationSet2, tmpAniStruct As AniStructure
Dim HasPass As Boolean, LastCommand As String
Dim tmp As String, tmpVal As XVal, tmpPar As String
Dim Sname$, S3D$, SAttached$, WLooping$
Dim tmpSurface As D3DVECTOR, ProgressBarHidden As Boolean

FileNum = FreeFile
AddFile MapName, FileNum

Set FR_Root = Nothing
Set FR_Cam = Nothing
Set CharPointer = Nothing
Set CharPointerHead = Nothing
Set CharPointerFoot = Nothing
Set tmpCam = Nothing
Set TFrm = Nothing


Set FR_Root = D3D_Main.CreateFrame(Nothing)
Set FR_Cam = D3D_Main.CreateFrame(FR_Root)
Set CharPointer = D3D_Main.CreateFrame(FR_Root)
Set CharPointerHead = D3D_Main.CreateFrame(FR_Root)
Set CharPointerFoot = D3D_Main.CreateFrame(FR_Root)
FR_Root.SetSceneBackgroundRGB 0, 0, 0
Set tmpCam = D3D_Main.CreateFrame(FR_Root)

'FR_Root.SetSceneBackgroundImage D3D_Main.LoadTexture(App.Path & "\sky.bmp")
Set D3D_ViewPort = D3D_Main.CreateViewport(D3D_Device, FR_Cam, 0, 0, SWidth, SHeight) 'Make our viewport and set
D3D_ViewPort.SetBack 400 'How far back it will draw the image. (Kinda like a visibility limit)

      

Z.x = 0: Z.y = 0
   For H = 1 To 2
     For i = 1 To 60
       For j = 1 To 60
         Layer(H).MapObj(i, j) = 0
         Layer(H).ObjKey(i, j) = ""
         Layer(H).ObjStruct(i, j) = Z
       Next
     Next
   Next
    Set TFrm = D3D_Main.CreateFrame(FR_Root)
    INIVar
      
      D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
      XXX = GetSpriteIndex("Chicken")
    
'*******************************************************************************
If LoadingGame = True Then
  On Local Error Resume Next
  Open App.Path & "\Saves\" & MapName & ".txt" For Input As FileNum
  If Err.Number = 53 Then GoTo ELSELMap
  tmpLoadingGame = True
  LoadingGame = False
Else
ELSELMap:
  Open App.Path & "\Maps\" & MapName & ".txt" For Input As FileNum
  If tmpLoadingGame = True Then
    tmpLoadingGame = False
    LoadingGame = True
  End If
End If
NameOfMap = ""
curPrintMapName = ""
curMapName = MapName
Do Until EOF(FileNum)
    If HasPass = True Then
    Intext = LastCommand
    Else
    Line Input #FileNum, Intext
    Intext = (Intext)
    End If
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
    
        Select Case (tmp)
         Case NOPROGRESS
          ProgressBarHidden = True
         Case GTIME
          GameTime = Val(tmpVal.val1)
         Case NAMEMAP
          curPrintMapName = tmpVal.val1
         Case TASK
          CurTaskName = (tmpVal.val1)
         Case FLOADMAP
          tmpPar = tmpVal.val1
          ChangeMap = True
          ChangeMapName = tmpPar
          If FLoaded = True Then
            tmpLoadingGame = True
          End If
          FLoaded = True
          Exit Sub
         Case FPLAYBG
          tmpPar = tmpVal.val1
          tmpVal.val1 = GetBGINX(curBG)
          If Val(tmpVal.val1) >= 1 Then
            Call WorldBG(Val(tmpVal.val1)).v_dmp.Stop(WorldBG(Val(tmpVal.val1)).v_dms, WorldBG(Val(tmpVal.val1)).v_dmss, 0, 0)
          End If
          StopAllBG
          PlayBGMusic tmpPar
          curBG = tmpPar
         Case SETCHARPOS
          ReDim Preserve CharacterPos(NumCharPos)
          CharacterPos(NumCharPos).EventNum = GetLatestGoto
          tmpPar = tmpVal.val1
          CharacterPos(NumCharPos).PStartPos.Size.Z = Val(tmpPar) * -10
          tmpPar = tmpVal.val2
          CharacterPos(NumCharPos).PStartPos.Size.y = Val(tmpPar) * 10
          tmpPar = tmpVal.val3
          CharacterPos(NumCharPos).PStartPos.Size.x = Val(tmpPar) * 10
          tmpPar = tmpVal.val4
          CharacterPos(NumCharPos).PStartPos.Direction = tmpPar
          tmpPar = tmpVal.val5
          If tmpPar = ConMap Then
            CharacterPos(NumCharPos).ContinueMap = True
          Else
            CharacterPos(NumCharPos).ContinueMap = False
          End If
          If tmpLoadingGame = True Then
            CurCharPos = CharacterPos(NumCharPos)
          End If
          NumCharPos = NumCharPos + 1
         Case BGMUSIC
          tmpPar = tmpVal.val1
          LoadBGMusic tmpPar, frmMain, tmpVal.val2
         Case STARTEVENT
          tmpPar = tmpVal.val1
          StartEventName = tmpPar
         Case SWITCH
          LoadSwitch tmpVal.val1, tmpVal.val2
         Case ITEM
          LoadItemFromFile tmpVal.val1, GetON(tmpVal.val2)
         Case LMOUSE
          tmpPar = tmpVal.val1
          LMousePos = Val(tmpPar)
         Case HMOUSE
          tmpPar = tmpVal.val1
          HMousePos = Val(tmpPar)
         Case AI_
            ReDim Preserve WorldAI(NumAI)
            WorldAI(NumAI).CharName = tmpVal.val1
            WorldAI(NumAI).CharIndex = GetCharIndex(WorldAI(NumAI).CharName)
            WorldAI(NumAI).AIAction = tmpVal.val2
            WorldAI(NumAI).AIReaction = tmpVal.val3
            WorldAI(NumAI).AIEvent = tmpVal.val4
            If WorldAI(NumAI).AIEvent <> NONE Then LoadEvents tmpVal.val4
            NumAI = NumAI + 1
         Case CONDITIONAL_
            a = 1
            ReDim Preserve WorldConditions(NumConditions)
            tmp = IF_
                  Do Until tmp <> IF_
                    Line Input #FileNum, Intext
                      If Intext <> "" Then
                        tmp = GetCommand(Intext)
                        If tmp = IF_ Then
                          tmpVal = GetOBJValues(Intext)
                          ReDim Preserve WorldConditions(NumConditions).ConSet(a)
                          tmpPar = tmpVal.val1
                          WorldConditions(NumConditions).ConSet(a).ObjName = tmpPar
                          WorldConditions(NumConditions).ConSet(a).ObjNum = GetTagNum(tmpPar)
                          tmpPar = tmpVal.val2
                          WorldConditions(NumConditions).ConSet(a).ConditionalPos.y = Int(Val(tmpPar))  ' h is the offset)
                          tmpPar = tmpVal.val3
                          WorldConditions(NumConditions).ConSet(a).ConditionalPos.x = Int(Val(tmpPar))  ' h is the offset
                          
                          WorldConditions(NumConditions).ConditionNum = a
                          a = a + 1
                        ElseIf tmp = THEN_ Then
                          tmpVal = GetOBJValues(Intext)
                          WorldConditions(NumConditions).ConEvent = tmpVal.val1
                          LoadEvents WorldConditions(NumConditions).ConEvent
                        Else
                          LastCommand = Intext
                        End If
                      End If
                  Loop
                  WorldConditions(NumConditions).NumCondition = a - 1
                  NumConditions = NumConditions + 1
         Case SOUND_
            tmpPar = tmpVal.val1
            Sname = (tmpPar)
            tmpPar = tmpVal.val2
            S3D = (tmpPar)
            tmpPar = tmpVal.val3
            SAttached = (tmpPar)
            tmpPar = tmpVal.val4
            WLooping = (tmpPar)
            If S3D = "3D" Then
              
            Else
              LoadSound Sname, WLooping
            End If
         Case EVENT_
            tmpPar = tmpVal.val1
            tmpStr = tmpPar ' Ename
            tmpPar = tmpVal.val2
            SIZEXYZ.y = Val(tmpVal.val2) 'x
            tmpPar = tmpVal.val3
            SIZEXYZ.x = Val(tmpVal.val3) 'y
            tmpPar = tmpVal.val4
            NumXYZ.y = Val(tmpVal.val4)
            tmpPar = tmpVal.val5
            NumXYZ.x = Val(tmpVal.val5)
            tmpPar = tmpVal.val6
            SIZEXYZ.Z = Val(tmpVal.val6) 'Trigger
            tmpPar = tmpVal.val7
            NumXYZ.Z = Val(tmpVal.val7) ' Repeat
            ReDim Preserve MapEvents(NumMapEvents)
            MapEvents(NumMapEvents).EventName = tmpStr
            MapEvents(NumMapEvents).Position.x = SIZEXYZ.x
            MapEvents(NumMapEvents).Position.y = SIZEXYZ.y
            MapEvents(NumMapEvents).Size.x = NumXYZ.x
            MapEvents(NumMapEvents).Size.y = NumXYZ.y
            MapEvents(NumMapEvents).Action = CInt(SIZEXYZ.Z)
            If NumXYZ.Z >= 1 Then
              MapEvents(NumMapEvents).Repeat = True
            Else
              MapEvents(NumMapEvents).Repeat = False
            End If
            InsertEvent tmpStr
            LoadEvents tmpStr
            NumMapEvents = NumMapEvents + 1
         Case MAKEBLOCK
            tmpPar = tmpVal.val1
            NumXYZ.x = Val(tmpVal.val1)
            tmpPar = tmpVal.val2
            NumXYZ.y = Val(tmpVal.val2)
            tmpPar = tmpVal.val3
            SIZEXYZ.x = Val(tmpVal.val3)
            tmpPar = tmpVal.val4
            SIZEXYZ.y = Val(tmpVal.val4)
            MakeLayerBlock Int(SIZEXYZ.x), Int(SIZEXYZ.y), Int(NumXYZ.x), Int(NumXYZ.y)
         Case Fog_ON
            tmpPar = tmpVal.val1
            F_Start = Val(tmpPar)
            tmpPar = tmpVal.val2
            F_End = Val(tmpPar)
            tmpPar = tmpVal.val3
            F_FColor = Val(tmpPar)
            tmpPar = tmpVal.val4
            F_BColor = Val(tmpPar)
         Case DRAWBACK
            tmpPar = tmpVal.val1
            a = Val(tmpPar)
            D3D_ViewPort.SetBack a 'How far back it will draw the image. (Kinda like a visibility limit)
         Case OBJECT
            tmpPar = tmpVal.val1
            tmpStr = tmpPar
            ReDim Preserve WorldObj(NumObjects)
            WorldObj(NumObjects) = LoadObject(tmpStr, NumObjects)
            NumObjects = NumObjects + 1
          Case LIGHT
            tmpPar = tmpVal.val1
            tmpLight.LightName = tmpPar
            tmpPar = tmpVal.val2
            tmpLight.LightPos.x = Val(tmpPar)
            tmpPar = tmpVal.val3
            tmpLight.LightPos.y = Val(tmpPar)
            tmpPar = tmpVal.val4
            tmpLight.LightPos.Z = Val(tmpPar)
            tmpPar = tmpVal.val5
            tmpLight.LightVal.R = Val(tmpPar)
            tmpPar = tmpVal.val6
            tmpLight.LightVal.g = Val(tmpPar)
            tmpPar = tmpVal.val7
            tmpLight.LightVal.b = Val(tmpPar)
            tmpPar = tmpVal.val8
            tmpLight.LookingAt = tmpPar
            If UCase(Left(tmpPar, 5)) <> Dummy_ Then
              tmpLight.CharDummyNum = GetCharIndex(tmpPar)
            Else
              tmpLight.CharDummyNum = GetDummyIndex(Right(tmpPar, Len(tmpPar) - 5))
            End If
                ReDim Preserve WorldLight(NumLights)
                ReDim Preserve LightFrames(NumLights)
                    Select Case (tmpLight.LightName)
                    Case AMBIENT
                      Set tmpLight.LIGHT = D3D_Main.CreateLightRGB(D3DRMLIGHT_AMBIENT, tmpLight.LightVal.R, tmpLight.LightVal.g, tmpLight.LightVal.b)     'Create our ambient light.
                    Case SPOT
                      Set tmpLight.LIGHT = D3D_Main.CreateLightRGB(D3DRMLIGHT_SPOT, tmpLight.LightVal.R, tmpLight.LightVal.g, tmpLight.LightVal.b)     'Create our ambient light.
                    Case POINT
                      Set tmpLight.LIGHT = D3D_Main.CreateLightRGB(D3DRMLIGHT_POINT, tmpLight.LightVal.R, tmpLight.LightVal.g, tmpLight.LightVal.b)     'Create our ambient light.
                    Case DIRECTIONAL
                      Set tmpLight.LIGHT = D3D_Main.CreateLightRGB(D3DRMLIGHT_DIRECTIONAL, tmpLight.LightVal.R, tmpLight.LightVal.g, tmpLight.LightVal.b)     'Create our ambient light.
                    Case Else
                      Set tmpLight.LIGHT = D3D_Main.CreateLightRGB(D3DRMLIGHT_DIRECTIONAL, tmpLight.LightVal.R, tmpLight.LightVal.g, tmpLight.LightVal.b)     'Create our ambient light.
                    End Select
                tmpLight.LightPos.x = tmpLight.LightPos.x * 10
                tmpLight.LightPos.y = tmpLight.LightPos.y * 10
                tmpLight.LightPos.Z = tmpLight.LightPos.Z * 10
                tmpLight.LightPos.Z = -(tmpLight.LightPos.Z)
                WorldLight(NumLights) = tmpLight
                Set LightFrames(NumLights) = D3D_Main.CreateFrame(FR_Root)
                LightFrames(NumLights).AddLight WorldLight(NumLights).LIGHT
                LightFrames(NumLights).SetPosition Nothing, WorldLight(NumLights).LightPos.x, WorldLight(NumLights).LightPos.y, WorldLight(NumLights).LightPos.Z
                If UCase(Left(tmpLight.LookingAt, 5)) = "DUMMY" Then
                  LightFrames(NumLights).LookAt WorldDummy(WorldLight(NumLights).CharDummyNum).ObjFrame, Nothing, D3DRMCONSTRAIN_Z
                Else
                  LightFrames(NumLights).LookAt CharFrames(WorldLight(NumLights).CharDummyNum), Nothing, D3DRMCONSTRAIN_Z
                End If
                NumLights = NumLights + 1
         Case SURFACE
            tmpPar = tmpVal.val1
            PType = tmpPar
            tmpPar = tmpVal.val2
            tmpStr = tmpPar
            If Left(PType, 1) <> "P" And Left(PType, 1) <> "T" And Left(PType, 1) <> "Z" Then
              tmpPar = tmpVal.val3
              tmpPos.Size.x = Val(tmpPar)
              tmpPar = tmpVal.val4
              tmpPos.Size.y = Val(tmpPar)
              tmpPar = tmpVal.val5
              tmpPos.Size.Z = Val(tmpPar)
              tmpPar = tmpVal.val6
              SIZEXYZ.y = Val(tmpPar)
              tmpPar = tmpVal.val7
              SIZEXYZ.y = Val(tmpPar)
              tmpPar = tmpVal.val8
              SIZEXYZ.x = Val(tmpPar)
            Else
              tmpPar = tmpVal.val3
              tmpPos.Size.Z = Val(tmpPar)
              tmpPar = tmpVal.val4
              tmpPos.Size.y = Val(tmpPar)
              tmpPar = tmpVal.val5
              tmpPos.Size.x = Val(tmpPar)
              tmpPar = tmpVal.val6
              SIZEXYZ.Z = Val(tmpPar)
              tmpPar = tmpVal.val7
              SIZEXYZ.y = Val(tmpPar)
              tmpPar = tmpVal.val8
              SIZEXYZ.x = Val(tmpPar)
            End If
            tmpPar = tmpVal.val9
            tmpPos.Direction = tmpPar
            If tmpPos.Direction = West Or tmpPos.Direction = East Then
              tmpPar = tmpPos.Size.x
              tmpPos.Size.x = tmpPos.Size.Z
              tmpPos.Size.Z = Val(tmpPar)
            End If
                tmpSurface = SIZEXYZ
                If Left(PType, 1) = "W" Or Left(PType, 1) = "Y" Then
                  If tmpPos.Size.x = SIZEXYZ.x Then
                    SIZEXYZ.x = (tmpSurface.Z - tmpPos.Size.Z) + 1
                    SIZEXYZ.Z = tmpSurface.y
                  ElseIf tmpPos.Size.Z = SIZEXYZ.Z Then
                    SIZEXYZ.x = (tmpSurface.x - tmpPos.Size.x) + 1
                    SIZEXYZ.Z = tmpSurface.y
                  End If
                  If tmpPos.Direction = South Then
                    tmpSurface.x = tmpPos.Size.x + 1
                    tmpPos.Size.x = tmpPos.Size.Z
                    tmpPos.Size.Z = tmpSurface.x
                  ElseIf tmpPos.Direction = North Then
                    tmpSurface.x = tmpPos.Size.x
                    tmpPos.Size.x = tmpPos.Size.Z
                    tmpPos.Size.Z = tmpSurface.x
                  ElseIf tmpPos.Direction = West Then
                    tmpPos.Size.Z = tmpPos.Size.Z + 1
                  ElseIf tmpPos.Direction = East Then
                    
                  End If
                End If
                
                
                tmpPos.Size.x = tmpPos.Size.x * 10: tmpPos.Size.y = tmpPos.Size.y * 10: tmpPos.Size.Z = tmpPos.Size.Z * 10
                SIZEXYZ.x = SIZEXYZ.x * 10: SIZEXYZ.y = SIZEXYZ.y * 10: SIZEXYZ.Z = SIZEXYZ.Z * 10
                                
                Set tmpMsh = Nothing
                  tmpDir = GetDirection(tmpPos.Direction)
                Set tmpMsh = D3D_Main.CreateMeshBuilder
                SIZEXYZ.y = SIZEXYZ.y + 2
                Select Case Left((PType), 1)
                  Case "P"
                    tmpMsh.LoadFromFile App.Path & "\Meshes\" & PType & ".x", 0, D3DRMLOAD_FROMFILE, Nothing, Nothing
                    tmpMsh.ScaleMesh SIZEXYZ.x / 10, SIZEXYZ.y / 10, SIZEXYZ.Z / 10
                    tmpPos.Size = GetPlanePos(tmpPos.Size, SIZEXYZ, tmpPos.Direction)
                  Case "Z"
                    NumXYZ.x = Val(Mid(PType, 2, 1))
                    NumXYZ.x = NumXYZ.x ^ 2
                    NumXYZ.y = NumXYZ.x
                    PType = Right(PType, Len(PType) - 2)
                    tmpMsh.LoadFromFile App.Path & "\Meshes\" & PType & ".x", 0, D3DRMLOAD_FROMFILE, Nothing, Nothing
                    tmpMsh.ScaleMesh SIZEXYZ.x / 10, SIZEXYZ.y / 10, SIZEXYZ.Z / 10
                    tmpPos.Size = GetPlanePos(tmpPos.Size, SIZEXYZ, tmpPos.Direction)
                    tmpMsh.SetTextureCoordinates 0, 0, 0
                    tmpMsh.SetTextureCoordinates 1, NumXYZ.x, 0
                    tmpMsh.SetTextureCoordinates 2, 0, NumXYZ.y
                    tmpMsh.SetTextureCoordinates 3, NumXYZ.x, NumXYZ.y
                  Case "T"
                    tmpMsh.LoadFromFile App.Path & "\Meshes\" & PType & ".x", 0, D3DRMLOAD_FROMFILE, Nothing, Nothing
                    tmpMsh.ScaleMesh SIZEXYZ.x / 10, SIZEXYZ.y / 10, SIZEXYZ.Z / 10
                    tmpPos.Size = GetPlanePos(tmpPos.Size, SIZEXYZ, tmpPos.Direction)
                  Case "R"
                    tmpMsh.LoadFromFile App.Path & "\Meshes\" & PType & ".x", 0, D3DRMLOAD_FROMFILE, Nothing, Nothing
                    tmpMsh.ScaleMesh SIZEXYZ.x / 10, SIZEXYZ.y / 10, SIZEXYZ.Z / 10
                    tmpPos.Size = GetPlanePos(tmpPos.Size, SIZEXYZ, tmpPos.Direction)
                  Case "W"
                    tmpMsh.LoadFromFile App.Path & "\Meshes\" & PType & ".x", 0, D3DRMLOAD_FROMFILE, Nothing, Nothing
                    tmpMsh.ScaleMesh SIZEXYZ.x / 10, SIZEXYZ.Z / 10, SIZEXYZ.y / 10
                    tmpPos.Size = GetWallPos(tmpPos.Size, SIZEXYZ, tmpPos.Direction)
                  Case "Y"
                    NumXYZ.x = Val(Mid(PType, 2, 1))
                    NumXYZ.x = NumXYZ.x ^ 2
                    NumXYZ.y = NumXYZ.x
                    PType = Right(PType, Len(PType) - 2)
                    tmpMsh.LoadFromFile App.Path & "\Meshes\" & PType & ".x", 0, D3DRMLOAD_FROMFILE, Nothing, Nothing
                    tmpMsh.ScaleMesh SIZEXYZ.x / 10, SIZEXYZ.Z / 10, SIZEXYZ.y / 10
                    tmpPos.Size = GetWallPos(tmpPos.Size, SIZEXYZ, tmpPos.Direction)
                    tmpMsh.SetTextureCoordinates 0, 0, 0
                    tmpMsh.SetTextureCoordinates 1, NumXYZ.x, 0
                    tmpMsh.SetTextureCoordinates 2, 0, NumXYZ.y
                    tmpMsh.SetTextureCoordinates 3, NumXYZ.x, NumXYZ.y
                End Select
                
                tmpMsh.SetTexture D3D_Main.LoadTexture(App.Path & "\" & tmpStr & ".bmp")
                
                ReDim Preserve SrfFrames(NumSrfFrames)
                Set SrfFrames(NumSrfFrames) = D3D_Main.CreateFrame(FR_Root)
                SrfFrames(NumSrfFrames).AddVisual tmpMsh
                SrfFrames(NumSrfFrames).SetPosition Nothing, tmpPos.Size.x, tmpPos.Size.y, tmpPos.Size.Z
                SrfFrames(NumSrfFrames).SetOrientation Nothing, tmpDir.dx, tmpDir.dy, tmpDir.dz, tmpDir.uX, tmpDir.uy, tmpDir.uz
                NumSrfFrames = NumSrfFrames + 1
                Set tmpMsh = Nothing
          
         Case LAYER1
            tmpPar = tmpVal.val1
            tmpStr = tmpPar
            tmpPar = tmpVal.val2
            tmpPos.Size.Z = Val(tmpPar)
            tmpPar = tmpVal.val3
            tmpPos.Size.y = Val(tmpPar)
            tmpPar = tmpVal.val4
            tmpPos.Size.x = Val(tmpPar)
            tmpPar = tmpVal.val5
            tmpPos.Direction = tmpPar
            tmpPar = tmpVal.val6
            ReDim Preserve WorldLObj(NumLObjects)
            WorldLObj(NumLObjects).ObjName = tmpStr
            WorldLObj(NumLObjects).ObjNum = NumFrames
            WorldLObj(NumLObjects).ObjPos = tmpPos.Size
            If tmpVal.val7 = tmpPar Then
              tmpVal.val7 = ""
            Else
              tmpPos.Direction = South
            End If
            WorldLObj(NumLObjects).ObjTag = tmpVal.val7
            NumLObjects = NumLObjects + 1
                Set tmpMsh = Nothing
                Z = GetXY(tmpPos.Size)
                tmpPos.Size.x = tmpPos.Size.x * 10: tmpPos.Size.y = tmpPos.Size.y * 10: tmpPos.Size.Z = tmpPos.Size.Z * 10
                tmpDir = GetDirection(tmpPos.Direction)
                tmpPos.Size = GetObjPos(tmpStr, tmpPos.Size, tmpPos.Direction)
                ReDim Preserve ObjFrames(NumFrames)
                Set ObjFrames(NumFrames) = D3D_Main.CreateFrame(FR_Root)
                Set tmpMsh = D3D_Main.CreateMeshBuilder
                tmpMsh.LoadFromFile App.Path & "\Meshes\" & tmpStr & ".x", 0, D3DRMLOAD_FROMFILE, Nothing, Nothing
                tmpMsh.SetTexture D3D_Main.LoadTexture(App.Path & "\" & tmpPar & ".bmp")
                tmpMsh.ScaleMesh 1, 1, 1
                ObjFrames(NumFrames).AddVisual tmpMsh
                ObjFrames(NumFrames).SetPosition Nothing, tmpPos.Size.x, tmpPos.Size.y, tmpPos.Size.Z
                ObjFrames(NumFrames).SetOrientation Nothing, tmpDir.dx, tmpDir.dy, tmpDir.dz, tmpDir.uX, tmpDir.uy, tmpDir.uz
                InsertMatrix Z, RotateMatrix(WorldObjMatrix(GetObjIndex(tmpStr)), tmpPos.Direction), 1
                NumFrames = NumFrames + 1
            
        Case CHARACTER
            a = 1
            tmpPar = tmpVal.val1
            tmpStr = tmpPar
            tmpPar = tmpVal.val2
            tmpPos.Size.Z = Val(tmpPar) * -10
            tmpPar = tmpVal.val3
            tmpPos.Size.y = Val(tmpPar) * 10
            tmpPar = tmpVal.val4
            tmpPos.Size.x = Val(tmpPar) * 10
            tmpPar = tmpVal.val5
            tmpPos.Direction = tmpPar
                'tmpPos.Size.x = tmpPos.Size.x * 10: tmpPos.Size.y = tmpPos.Size.y * 10: tmpPos.Size.Z = -(tmpPos.Size.Z * 10)
                tmpDir = GetDirection(tmpPos.Direction)
                ReDim Preserve CharFrames(NumChar)
                ReDim Preserve WorldAni(NumChar)
                tmp = ANIMATION
                  Do Until tmp <> ANIMATION
                    Line Input #FileNum, Intext
                      If Intext <> "" Then
                        tmp = GetCommand(Intext)
                        If tmp = ANIMATION Then
                          tmpVal = GetOBJValues(Intext)
                          tmpPar = tmpVal.val1
                          tmpAniStruct.AniName = tmpPar
                          tmpPar = tmpVal.val2
                          H = Val(tmpPar) ' h is the offset
                          
                          If UBound(WorldAni(NumChar).AniSet) <= 1 Then
                            tmpAniStruct.AniStart = UBound(WorldAni(NumChar).AniSet)
                            tmpAniStruct.AniEnd = H
                          Else
                            tmpAniStruct.AniStart = UBound(WorldAni(NumChar).AniSet)
                            tmpAniStruct.AniEnd = UBound(WorldAni(NumChar).AniSet) + H - 1
                          End If
                          
                              tmpAniStruct.AniNum = a
                              LoadAnim tmpStr, tmpAniStruct, NumChar, CLng(30 / H)
                              a = a + 1
                        Else
                        LastCommand = Intext
                        End If
                      End If
                  Loop
                    FileNum2 = FreeFile
                    Open App.Path & "\Animations\" & tmpStr & "\" & tmpStr & ".txt" For Input As FileNum2
                          Do Until EOF(FileNum2)
                              Line Input #FileNum2, Intext
                              If (Not (Intext = "") Or (Intext = ";")) Then
                                  Select Case (Intext)
                                    Case Size
                                       Input #FileNum2, WorldAni(NumChar).AniSize.x, WorldAni(NumChar).AniSize.y, WorldAni(NumChar).AniSize.Z
                                       WorldAni(NumChar).AniSize.x = WorldAni(NumChar).AniSize.x * 10
                                       WorldAni(NumChar).AniSize.y = WorldAni(NumChar).AniSize.y * 10
                                       WorldAni(NumChar).AniSize.Z = WorldAni(NumChar).AniSize.Z * 10
                                  End Select
                              End If
                          Loop
                    Close #FileNum2
                WorldAni(NumChar).PrevChar = WorldAni(NumChar).AniStruct(LBound(WorldAni(NumChar).AniStruct)).AniStart
                WorldAni(NumChar).NowChar = WorldAni(NumChar).PrevChar
                tmpPos.Size = GetAniPos(tmpStr, tmpPos.Size, tmpPos.Direction)
                CharFrames(NumChar).AddVisual WorldAni(NumChar).AniSet(WorldAni(NumChar).PrevChar)
                If CurCharPos.ContinueMap = True Then
                  tmpPos = CurCharPos.PStartPos
                  tmpDir = GetDirection(tmpPos.Direction)
                  CurCharPos.ContinueMap = False
                  CurCharPos.EventNum = 0
                  CurCharPos.PStartPos.Direction = ""
                  CurCharPos.PStartPos.Size.x = 0
                  CurCharPos.PStartPos.Size.y = 0
                  CurCharPos.PStartPos.Size.Z = 0
                ElseIf LoadingGame = True Then
                  tmpPos = CurCharPos.PStartPos
                  tmpDir = GetDirection(tmpPos.Direction)
                  CurCharPos.ContinueMap = False
                  CurCharPos.EventNum = 0
                  CurCharPos.PStartPos.Direction = ""
                  CurCharPos.PStartPos.Size.x = 0
                  CurCharPos.PStartPos.Size.y = 0
                  CurCharPos.PStartPos.Size.Z = 0
                  LoadingGame = False
                End If
                CharFrames(NumChar).SetPosition Nothing, tmpPos.Size.x, tmpPos.Size.y, tmpPos.Size.Z
                tmpPos.Size = GetCenterPos(tmpStr)
                CharFrames(NumChar).SetPosition Nothing, tmpPos.Size.x, tmpPos.Size.y, tmpPos.Size.Z
                Z = GetMtxXY(tmpPos.Size)
                Layer(1).ObjKey(CInt(Z.x), (CInt(Z.y))) = Char & NumChar
                CharFrames(NumChar).SetOrientation Nothing, tmpDir.dx, tmpDir.dy, tmpDir.dz, tmpDir.uX, tmpDir.uy, tmpDir.uz
                CharPointer.SetPosition Nothing, tmpPos.Size.x, tmpPos.Size.y, tmpPos.Size.Z
                CharPointer.SetOrientation Nothing, tmpDir.dx, tmpDir.dy, tmpDir.dz, tmpDir.uX, tmpDir.uy, tmpDir.uz
                NumChar = NumChar + 1
                a = 1
                ReDim Preserve WorldAni(NumChar)
                ReDim Preserve WorldAni(NumChar).AniSet(a)
                tmpAniStruct.AniName = ""
                tmp = GetCommand(LastCommand)
                If tmp = CHARACTER Then
                  HasPass = True
                Else
                  HasPass = False
                End If
        Case BLOCKROW
            tmpPar = tmpVal.val1
            ObjCnt = Val(tmpPar)
            For a = 1 To 60
              Layer(1).ObjKey(ObjCnt, a) = Block
            Next
        Case ENABLESAVE
            CanSave = True
        Case BLOCKCOL
            tmpPar = tmpVal.val1
            ObjCnt = Val(tmpPar)
            For a = 1 To 60
              Layer(1).ObjKey(a, ObjCnt) = Block
            Next
        Case MAKEDUMMY
            tmpPar = tmpVal.val1
            tmpStr = tmpPar
            tmpPar = tmpVal.val2
            tmpPos.Size.Z = Val(tmpPar) * 10
            tmpPar = tmpVal.val3
            tmpPos.Size.y = Val(tmpPar) * 10
            tmpPar = tmpVal.val4
            tmpPos.Size.x = Val(tmpPar) * 10
            tmpPos.Size = GetDummyCenterPos(tmpPos.Size)
            tmpPos.Size.Z = tmpPos.Size.Z * -1
            CreateDummy tmpStr, tmpPos.Size
        End Select
    End If
    
    If ProgressBarHidden = False Then
      D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
      WorldSprite(XXX).SRect = AnimCompass("W")
      DS_Back.BltFast 20, 400, WorldSprite(XXX).SSurf, WorldSprite(XXX).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
      DS_Back.DrawText 20, 450, "Loading...", False
      DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
    End If

Loop

Close #FileNum
  FR_Cam.SetPosition CharFrames(LBound(CharFrames)), 0, LMousePos - 0.1, 30
  TFrm.SetPosition CharFrames(LBound(CharFrames)), 0, -1, -20
  TFrm.GetPosition CharFrames(LBound(CharFrames)), TPos
  FR_Cam.GetPosition CharFrames(LBound(CharFrames)), CPos
  OldCPos = CPos: OldTPos = TPos
  FR_Cam.LookAt TFrm, Nothing, D3DRMCONSTRAIN_Z
  If HMousePos = 0 Or LMousePos = 0 Then
    LMousePos = 30: HMousePos = 60
  End If
MapLoaded = True
Close
End Sub

Public Function LoadObject(ObjName As String, Index As Integer) As ObjList
Dim FileNum As Integer, Intext As String
Dim ObjCnt As Integer, Z As XY
Dim tmpObj As ObjList
tmpObj.ObjName = ObjName
tmpObj.ObjNum = Index
FileNum = FreeFile
AddFile ObjName, FileNum
Open App.Path & "\Objects\" & ObjName & ".txt" For Input As FileNum
        Do Until EOF(FileNum)
            Line Input #FileNum, Intext
            If (Not (Intext = "") Or (Intext = ";")) Then
                Select Case (Intext)
                  Case Size
                  Input #FileNum, tmpObj.ObjSize.Z, tmpObj.ObjSize.y, tmpObj.ObjSize.x
                  Exit Do
                End Select
            End If
        Loop
Close #FileNum
Z = GetXY(tmpObj.ObjSize)
tmpObj.ObjSize.x = tmpObj.ObjSize.x * 10: tmpObj.ObjSize.y = tmpObj.ObjSize.y * 10
tmpObj.ObjSize.Z = tmpObj.ObjSize.Z * 10
ReDim Preserve WorldObjMatrix(NumMatrix)
WorldObjMatrix(NumMatrix) = GenMatrix(ObjName, Index, Z)
NumMatrix = NumMatrix + 1
LoadObject = tmpObj
End Function

Public Sub LoadAnim(ObjName As String, Ani As AniStructure, Index As Integer, Offset As Integer)
Dim FileNum%, Intext$, i%, j%

  Set CharFrames(Index) = D3D_Main.CreateFrame(FR_Root)
  WorldAni(Index).AniName = (ObjName)
  ReDim Preserve WorldAni(Index).AniStruct(Ani.AniNum)
  
  WorldAni(Index).AniStruct(Ani.AniNum) = Ani
  If Ani.AniName = NONE Then
    Exit Sub
  End If
  
  For i = Ani.AniStart To Ani.AniEnd
    ReDim Preserve WorldAni(Index).AniSet(i)
    Set WorldAni(Index).AniSet(i) = D3D_Main.CreateMeshBuilder
    WorldAni(Index).AniSet(i).LoadFromFile App.Path & "\Animations\" & ObjName & "\" & Ani.AniName & "\" & ObjName & "_" & Ani.AniName & "_" & j & ".x", Index, D3DRMLOAD_FROMFILE, Nothing, Nothing
    WorldAni(Index).AniSet(i).ScaleMesh 1, 1, 1
    WorldAni(Index).AniNum = Index
    j = j + Offset
  Next
  ReDim Preserve WorldAni(Index).AniSet(i)
End Sub

Public Function GetDirection(ObjDir As String) As Direction
Dim tmp As Direction
  Select Case UCase(ObjDir)
    Case North
      tmp.dx = 0: tmp.dy = 0: tmp.dz = -1
      tmp.uX = 0: tmp.uy = 1: tmp.uz = 0
    Case South
      tmp.dx = 0: tmp.dy = 0: tmp.dz = 1
      tmp.uX = 0: tmp.uy = 1: tmp.uz = 0
    Case East
      tmp.dx = 1: tmp.dy = 0: tmp.dz = 0
      tmp.uX = 0: tmp.uy = 1: tmp.uz = 0
    Case West
      tmp.dx = -1: tmp.dy = 0: tmp.dz = 0
      tmp.uX = 0: tmp.uy = 1: tmp.uz = 0
    Case Else
      tmp.dx = 0: tmp.dy = 0: tmp.dz = 1
      tmp.uX = 0: tmp.uy = 1: tmp.uz = 0
  End Select
  GetDirection = tmp
End Function

Public Function GetObjPos(ObjName As String, tmpPos As D3DVECTOR, ObjDir As String) As D3DVECTOR
Dim i As Integer, tmp As D3DVECTOR
  For i = LBound(WorldObj) To UBound(WorldObj)
    If WorldObj(i).ObjName = ObjName Then
        If (ObjDir = North Or ObjDir = South) Or (ObjDir = LCase(North) Or ObjDir = LCase(South)) Then
          tmp.x = (WorldObj(i).ObjSize.x / 2) + tmpPos.x
          tmp.y = tmpPos.y
          tmp.Z = -(Abs(((WorldObj(i).ObjSize.Z / 2) + tmpPos.Z)))
          GetObjPos = tmp
          Exit Function
        Else
          tmp.Z = -(Abs((WorldObj(i).ObjSize.x / 2) + tmpPos.Z))
          tmp.y = tmpPos.y
          tmp.x = Abs(((WorldObj(i).ObjSize.Z / 2) + tmpPos.x))
          GetObjPos = tmp
          Exit Function
        End If
    End If
  Next
End Function



Public Function GetAniPos(AniName As String, tmpPos As D3DVECTOR, ObjDir As String) As D3DVECTOR
Dim i As Integer, tmp As D3DVECTOR
  For i = LBound(WorldAni) To UBound(WorldAni)
    If WorldAni(i).AniName = AniName Then
        If (ObjDir = North Or ObjDir = South) Or (ObjDir = LCase(North) Or ObjDir = LCase(South)) Then
          tmp.x = (WorldAni(i).AniSize.x / 2) + tmpPos.x
          tmp.y = tmpPos.y
          tmp.Z = -(Abs(((WorldAni(i).AniSize.Z / 2) + tmpPos.Z)))
          GetAniPos = tmp
          Exit Function
        Else
          tmp.Z = -(Abs((WorldAni(i).AniSize.x / 2) + tmpPos.Z))
          tmp.y = tmpPos.y
          tmp.x = Abs(((WorldAni(i).AniSize.Z / 2) + tmpPos.x))
          GetAniPos = tmp
          Exit Function
        End If
    End If
  Next
End Function


Public Function GetXY(XYZ As D3DVECTOR) As XY
Dim tmp As XY
tmp.x = XYZ.x
tmp.y = XYZ.Z
GetXY = tmp
End Function

Public Function GetPlanePos(tmpPos As D3DVECTOR, tmpSize As D3DVECTOR, ObjDir As String) As D3DVECTOR
Dim i As Integer, tmp As D3DVECTOR
        If (ObjDir = North Or ObjDir = South) Or (ObjDir = LCase(North) Or ObjDir = LCase(South)) Then
          tmp.x = (tmpSize.x / 2) + tmpPos.x
          tmp.y = tmpPos.y
          tmp.Z = -(Abs(((tmpSize.Z / 2) + tmpPos.Z)))
          GetPlanePos = tmp
          Exit Function
        Else
          tmp.Z = -(Abs((tmpSize.x / 2) + tmpPos.x))
          tmp.y = tmpPos.y
          tmp.x = Abs(((tmpSize.Z / 2) + tmpPos.Z))
          GetPlanePos = tmp
          Exit Function
        End If
End Function

Public Function GetWallPos(tmpPos As D3DVECTOR, tmpSize As D3DVECTOR, ObjDir As String) As D3DVECTOR
Dim i As Integer, tmp As D3DVECTOR
        If ((ObjDir) = North Or (ObjDir) = South) Then
          tmp.x = (tmpSize.x / 2) + tmpPos.x
          tmp.y = tmpPos.y
          tmp.Z = -(Abs(tmpPos.Z))
          GetWallPos = tmp
          Exit Function
        Else
          tmp.Z = -(Abs((tmpSize.x / 2) + tmpPos.x))
          tmp.y = tmpPos.y
          tmp.x = Abs(tmpPos.Z)
          GetWallPos = tmp
          Exit Function
        End If
End Function

Public Function GetObjIndex(ObjName As String) As Integer
Dim i As Integer
For i = LBound(WorldObj) To UBound(WorldObj)
  If WorldObj(i).ObjName = ObjName Then
    GetObjIndex = i
    Exit Function
  End If
Next
End Function
Public Function GetLObjIndex(ObjName As String) As Integer
Dim i As Integer
For i = LBound(WorldLObj) To UBound(WorldLObj)
  If WorldLObj(i).ObjName = ObjName Then
    GetLObjIndex = i
    Exit Function
  End If
Next
End Function

Public Function GetTagNum(ObjTag As String) As Integer
Dim i As Integer
For i = LBound(WorldLObj) To UBound(WorldLObj)
  If WorldLObj(i).ObjTag = ObjTag Then
    GetTagNum = i
    Exit Function
  End If
Next
End Function


Public Function GetLObjName(ObjNum As Integer) As String
    GetLObjName = WorldLObj(ObjNum).ObjName
End Function

Public Function GetInText(x As String) As String
Dim i As Integer, tmp As String, L As String
For i = 1 To Len(x)
  L = Mid(x, i, 1)
  If L <> "," Then
    tmp = tmp & L
  Else
    GetInText = (Trim(tmp))
    Exit Function
  End If
Next
End Function

Public Function GetOBJValues(x As String) As XVal
Dim tmp As String, tmpVal As XVal
tmp = GetCommand(x)
Select Case (tmp)
  Case CASE_
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case FPLAYBG
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetOBJValues = tmpVal
  Case TASK
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetOBJValues = tmpVal
  Case FLOADMAP
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case NAMEMAP
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case LMOUSE
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case GTIME
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case HMOUSE
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case SOUND_
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetOBJValues = tmpVal
  Case CREATEOBJ
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetOBJValues = tmpVal
  Case Fog_ON
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetOBJValues = tmpVal
  Case EVENT_
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      tmpVal.val6 = GetParam(x, 6)
      tmpVal.val7 = GetParam(x, 7)
      GetOBJValues = tmpVal
  Case DRAWBACK
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case LAYER1
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      tmpVal.val6 = GetParam(x, 6)
      tmpVal.val7 = GetParam(x, 7)
      GetOBJValues = tmpVal
  Case LIGHT
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      tmpVal.val6 = GetParam(x, 6)
      tmpVal.val7 = GetParam(x, 7)
      tmpVal.val8 = GetParam(x, 8)
      GetOBJValues = tmpVal
  Case SURFACE
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      tmpVal.val6 = GetParam(x, 6)
      tmpVal.val7 = GetParam(x, 7)
      tmpVal.val8 = GetParam(x, 8)
      tmpVal.val9 = GetParam(x, 9)
      GetOBJValues = tmpVal
    Case MAKEBLOCK
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetOBJValues = tmpVal
  Case AI_
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetOBJValues = tmpVal
  Case CHARACTER
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      GetOBJValues = tmpVal
  Case SETCHARPOS
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      GetOBJValues = tmpVal
  Case IF_
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      GetOBJValues = tmpVal
  Case THEN_
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case OBJECT
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case ANIMATION
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      GetOBJValues = tmpVal
  Case BLOCKROW
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case BLOCKCOL
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case ENABLESAVE
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case BGMUSIC
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetOBJValues = tmpVal
  Case MAKEDUMMY
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetOBJValues = tmpVal
  Case KEY_
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetOBJValues = tmpVal
  Case Size
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      GetOBJValues = tmpVal
  Case BLOCKROW
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case BLOCKCOL
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case BGVOL
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case SEVOL
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case LANG
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case STARTEVENT
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case SWITCH
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetOBJValues = tmpVal
  Case ITEM
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetOBJValues = tmpVal
  Case TERMINATOR
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case ICAPTION
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case IDETAIL
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
  Case IPREVIEW
      tmpVal.val1 = GetParam(x, 1)
      GetOBJValues = tmpVal
End Select
End Function

Public Function GetCharNumPos(EventNum As Integer) As Integer
Dim i As Integer
For i = 1 To UBound(CharacterPos)
  If CharacterPos(i).EventNum = EventNum Then
    GetCharNumPos = i
    Exit Function
  End If
Next
GetCharNumPos = -1
End Function

Public Function GetLatestGoto() As Integer
Dim i As Integer
For i = UBound(WorldEvents) To 1 Step -1
  If Left(WorldEvents(i).EventName, 4) = "Goto" Then
    GetLatestGoto = i
    Exit Function
  End If
Next
GetLatestGoto = -1
End Function
