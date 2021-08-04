Attribute VB_Name = "mdlEvents"
Option Explicit
Option Base 1
Option Compare Text
Public Const ON_ = "ON"
Public Const UP = "UP"
Public Const DOWN = "DOWN"
Public Const LEFT_ = "LEFT"
Public Const RIGHT_ = "RIGHT"
Public Const FRONT = "FRONT"
Public Const BACK = "BACK"
Public Const WLOOP = "LOOP"
Public Const PONCE = "ONCE"
Public Const REVERSE_ = "REVERSE"
Public Const SEESAW_ = "SEESAW"
Public Const CHOICE_ = "<CHOICE>"
Public Const AutoSave_ = "<AUTOSAVE>"
Public Const YES_ = "<YES>"
Public Const NO_ = "<NO>"
Public Const ShowIntro_ = "<SHOWINTRO>"
Public Const ShowEnd_ = "<SHOWEND>"
Public Const CHOICEEND = "<CHOICE END>"
Public Const Msg = "<MESSAGE>"
Public Const RCAM = "<ROTATECAM>"
Public Const CHARFACE = "<CHARFACE>"
Public Const MCAM = "<MOVECAM>"
Public Const Exit_ = "<EXIT>"
Public Const SPREV = "<SHOWPREVIEW>"
Public Const SSPRITE = "<SHOWSPRITE>"
Public Const MCHAR = "<MOVECHAR>"
Public Const SCAMPOS = "<SETCAMPOS>"
Public Const LOOKFACE = "<LOOKATFACE>"
Public Const CAML = "<CAMLOOK>"
Public Const CASE_ = "<CASE>"
Public Const CASEELSE_ = "<CASE ELSE>"
Public Const ENDSELECT_ = "<END SELECT>"
Public Const CHARANIM = "<CHARANIMATE>"
Public Const PSOUND = "<PLAYSOUND>"
Public Const LEVENT = "<LOADEVENT>"
Public Const LMap = "<LOADMAP>"
Public Const EEVENT = "<EXECUTEEVENT>"
Public Const NEXTEVENT = "<NEXTEVENT>"
Public Const SWITCH = "<SWITCH>"
Public Const RELOAD = "<RELOAD>"
Public Const ITEM = "<ITEM>"
Public Const StopBG = "<STOPBG>"
Public Const BLANKSCREEN = "<BlankScreen>"
Public Const TERMINATOR = "</>"
Public Const Lang1 = "<A>"
Public Const Lang2 = "<B>"
Public Const Lang3 = "<C>"
Public CurEvent As String, GameWillForceExit As Boolean
Public ChangeMap As Boolean, ChangeMapName As String
Public MessageFromEvent As String, MessageFromEventPrompt As Boolean, SpriteEnabled As Boolean
Public TemporarySprite As ShowSpriteStruct

Public Type XVal
  val1 As String: val7 As String
  val2 As String: val8 As String
  val3 As String: val9 As String
  val4 As String: val10 As String
  val5 As String: val11 As String
  val6 As String: val12 As String
End Type
Public NewTask As Boolean
Public Type ScreenMessage
  SMessage As String
  SPos As D3DVECTOR
End Type: Public ScreenText As ScreenMessage, ScreenText2 As ScreenMessage, ScreenText3 As ScreenMessage


Public Type MessageStruct
  On As Boolean
  Text As String
  PromtKey As Boolean
  Duration As Single
End Type


Public Type StopBGStruct
  On As Boolean
End Type

Public Type RotateCamStruct
  On As Boolean
  TargetChar As String
  Direction As String
  Speed As Single
  Duration As Integer
End Type

Public Type MoveCamStruct
  On As Boolean
  CamPos As D3DVECTOR
  Duration As Single
End Type

Public Type SetCamPosStruct
  On As Boolean
  CamPos As D3DVECTOR
  LookingAt As String
  TargetPos As D3DVECTOR
End Type

Public Type LookAtFaceStruct
  On As Boolean
  CamPos As String
  LookingAtFace As String
End Type

Public Type CamLookStruct
  On As Boolean
  Direction As String
  Speed As Integer
  Duration As Integer
End Type

Public Type MoveCharStruct
  On As Boolean
  CharName As String
  Speed As Single
  Direction As String
  Duration As Integer
End Type

Public Type SoundStruct
  On As Boolean
  SoundName As String
End Type

Public Type ReloadStruct
  On As Boolean
End Type

Public Type CharAnimateStruct
  On As Boolean
  HasINI As Boolean
  CharName As String
  CharAni As String
  Once As Boolean
  Loop As Boolean
  Reverse As Boolean
  SeeSaw As Boolean
  Speed As Integer
  Duration As Integer
  PStart As Integer
  PEnd As Integer
  tmpINX As Integer
End Type

Public Type ExtraEventStruct
  XEvent  As Boolean
  XName As String
End Type

Public Type LoadMapStruct
  LMap  As Boolean
  MapName As String
End Type

Public Type PlayBGStruct
  BGPlay As Boolean
  BGName As String
End Type

Public Type CharFaceStruct
  On As Boolean
  CharName As String
  FaceTo As String
  FaceAway As Boolean
  CharNum As Integer
  FaceToNum As Integer
End Type

Public Type ChoiceStruct
  On As Boolean
  ChoiceName As String
  ChoiceMsg As String
  ChoiceYes As String
  ChoiseNo As String
End Type

Public Type GameSwitchStruct
  On As Boolean
  SwitchNum As Integer
  SwitchName As String
  SwitchEnable  As Boolean
End Type: Public WorldSwitch() As GameSwitchStruct
Public NumSwitch As Integer

Public Type GameItemStruct
  On As Boolean
  ItemName As String
  ItemEnable As Boolean
End Type

Public Type SetCharPosStruct
  On As Boolean
  CharName As String
  CharPos As D3DVECTOR
  CharDir As String
End Type

Public Type ShowPrevStruct
  On As Boolean
  PrevName As String
End Type

Public Type ShowTaskStruct
  On As Boolean
  TName As String
End Type

Public Type ShowIntroStruct
  On As Boolean
  IName As String
End Type

Public Type GameFogStruct
  On As Boolean
  FogStart As Integer
  FogEnd As Integer
  FogFColor As Integer
  FogBColor As Integer
End Type

Public Type ShowSpriteStruct
  On As Boolean
  SHeight As Integer
  SWidth As Integer
  SX As Integer
  SY As Integer
  Spic As String
  Duration As Integer
End Type

Public Type ShowEndStruct
  On As Boolean
End Type

Public Type ExitStruct
  On As Boolean
End Type

Public Type AutoSaveStruct
  On As Boolean
End Type

Public Type EventStruct
  Message As MessageStruct
  SetCamPos As SetCamPosStruct
  RotateCam As RotateCamStruct
  MoveCam As MoveCamStruct
  CamLook As CamLookStruct
  LookAtFace As LookAtFaceStruct
  CharAnimate As CharAnimateStruct
  MoveChar As MoveCharStruct
  PlaySound As SoundStruct
  ExtraEvent As ExtraEventStruct
  MapLoad As LoadMapStruct
  PlayBGMusic As PlayBGStruct
  FaceChar As CharFaceStruct
  SwitchValue As GameSwitchStruct
  GameItem As GameItemStruct
  GameChoice As ChoiceStruct
  SetGameCharPos As SetCharPosStruct
  EventReload As ReloadStruct
  ShowPrev As ShowPrevStruct
  StopBG As StopBGStruct
  ShowTask As ShowTaskStruct
  ShowIntro As ShowIntroStruct
  ShowFog As GameFogStruct
  ShowSprite As ShowSpriteStruct
  ShowEnd As ShowEndStruct
  ExitGame As ExitStruct
  AutoSave As AutoSaveStruct
End Type

Public Type EventList
  EventNum As Integer
  NumEvents As Integer
  EventName As String
  Events() As EventStruct
  ExtraEventNum As Integer
  Allocated As Boolean
End Type: Public WorldEvents() As EventList
Public NumEvents As Integer

Public Type EventAction
  EventName As String
  Action As Integer
  Position As D3DVECTOR
  Size As D3DVECTOR
  Repeat As Boolean
End Type: Public MapEvents() As EventAction
Public NumMapEvents As Integer

Public IndexArray() As Integer, EventArray() As String
Public tmpRotate As Long, LastFileNum As Integer, EventCancel As Boolean

Public Sub Message(Msg As String)
Dim NumOfWords As Integer, T1 As String, T2 As String
Dim i As Integer
NumOfWords = GetNumWords(Msg)
ScreenText.SMessage = ""
If Len(Msg) >= 80 Then
  For i = 1 To NumOfWords \ 2
    T1 = T1 & " " & GetWord(Msg, i)
  Next
  
  For i = (NumOfWords \ 2) + 1 To NumOfWords
    T2 = T2 & " " & GetWord(Msg, i)
  Next
Else
  T1 = Msg
End If

  If Len(Msg) >= 80 Then
    ScreenText.SMessage = T1
    ScreenText.SPos.x = 8
    ScreenText.SPos.y = SHeight - 100

    ScreenText2.SMessage = T2
    ScreenText2.SPos.x = 8
    ScreenText2.SPos.y = SHeight - 80
  Else
    ScreenText.SMessage = T1
    ScreenText.SPos.x = 8
    ScreenText.SPos.y = SHeight - 100
  End If
End Sub

Public Sub LoadEvents(EName As String)
Dim FileNum%, Intext As String, i As Integer, tmp$
Dim tmpVal As XVal, tmpPar As String, j%, tmpNum As Integer
Dim R As Boolean, NumOfNext As Integer, NEvent As Boolean, NumZEvents As Integer

If EventPresent(EName) = True Then
  tmpNum = NumEvents
  NumZEvents = GetEIndex(EName)
  R = True
Else
  tmpNum = NumZEvents
  R = False
End If
FileNum = FreeFile
AddFile EName, FileNum
j = 0
i = 1
Open App.Path & "\Events\" & NameOfMap & "\" & EName & ".txt" For Input As FileNum
If R = False Then
  NumZEvents = GetFreeEvent
  ReDim Preserve WorldEvents(NumZEvents + 1)
  ReDim Preserve EventArray(NumZEvents + 1)
  WorldEvents(NumZEvents).EventName = (EName)
  WorldEvents(NumZEvents).EventNum = NumZEvents
  EventArray(NumZEvents) = EName
Else
  WorldEvents(NumZEvents).EventName = (EName)
  WorldEvents(NumZEvents).EventNum = NumZEvents
End If
Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Then
      If NEvent = True And Intext = TERMINATOR Then NEvent = False
      If NEvent = True Then Intext = ""
      tmp = GetCommand(Intext)
      tmpVal = GetEventValues(Intext)
      Select Case Trim((tmp))
        Case AutoSave_
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).AutoSave.On = True
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case Exit_
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ExitGame.On = True
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case ShowEnd_
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ShowEnd.On = True
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case SSPRITE
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ShowSprite.On = True
            WorldEvents(NumZEvents).Events(i).ShowSprite.SWidth = Val(tmpVal.val1)
            WorldEvents(NumZEvents).Events(i).ShowSprite.SHeight = Val(tmpVal.val2)
            WorldEvents(NumZEvents).Events(i).ShowSprite.SX = Val(tmpVal.val3)
            WorldEvents(NumZEvents).Events(i).ShowSprite.SY = Val(tmpVal.val4)
            WorldEvents(NumZEvents).Events(i).ShowSprite.Spic = (tmpVal.val5)
            WorldEvents(NumZEvents).Events(i).ShowSprite.Duration = Val(tmpVal.val6)
            LoadSprite WorldEvents(NumZEvents).Events(i).ShowSprite.Spic, WorldEvents(NumZEvents).Events(i).ShowSprite.SHeight, WorldEvents(NumZEvents).Events(i).ShowSprite.SWidth
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case Fog_ON
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ShowFog.On = True
            WorldEvents(NumZEvents).Events(i).ShowFog.FogStart = Val(tmpVal.val1)
            WorldEvents(NumZEvents).Events(i).ShowFog.FogEnd = Val(tmpVal.val2)
            WorldEvents(NumZEvents).Events(i).ShowFog.FogFColor = Val(tmpVal.val3)
            WorldEvents(NumZEvents).Events(i).ShowFog.FogBColor = Val(tmpVal.val4)
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case ShowIntro_
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ShowIntro.On = True
            WorldEvents(NumZEvents).Events(i).ShowIntro.IName = tmpVal.val1
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case TASK
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ShowTask.On = True
            WorldEvents(NumZEvents).Events(i).ShowTask.TName = tmpVal.val1
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case StopBG
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).StopBG.On = True
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case SWITCH
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).SwitchValue.On = True
            WorldEvents(NumZEvents).Events(i).SwitchValue.SwitchName = tmpPar
            tmpPar = tmpVal.val2
            If tmpPar = ON_ Then
              WorldEvents(NumZEvents).Events(i).SwitchValue.SwitchEnable = True
            Else
              WorldEvents(NumZEvents).Events(i).SwitchValue.SwitchEnable = False
            End If
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case CASE_
                tmpPar = tmpVal.val1
                Close #FileNum
                GetCase EName
                LoadEvents EName
                ReturnEName EName
                Exit Sub
        Case RELOAD
                ReDim Preserve WorldEvents(NumZEvents).Events(i)
                WorldEvents(NumZEvents).Events(i).EventReload.On = True
                WorldEvents(NumZEvents).Allocated = True
                i = i + 1
        Case SPREV
                ReDim Preserve WorldEvents(NumZEvents).Events(i)
                tmpPar = tmpVal.val1
                WorldEvents(NumZEvents).Events(i).ShowPrev.On = True
                WorldEvents(NumZEvents).Events(i).ShowPrev.PrevName = tmpPar
                WorldEvents(NumZEvents).Allocated = True
                i = i + 1
        Case CHOICE_
              ReDim Preserve WorldEvents(NumZEvents).Events(i)
              tmpPar = tmpVal.val1
              If Left(tmpPar, 1) = "&" Then
                WorldEvents(NumZEvents).Events(i).GameChoice.ChoiceMsg = GetMessage(CurLangLetter, Right(tmpPar, Len(tmpPar) - 1))
              Else
                WorldEvents(NumZEvents).Events(i).GameChoice.ChoiceMsg = tmpPar
              End If
              If Len(WorldEvents(NumZEvents).Events(i).GameChoice.ChoiceMsg) >= 80 Then WorldEvents(NumZEvents).Events(i).GameChoice.ChoiceMsg = ". " & WorldEvents(NumZEvents).Events(i).GameChoice.ChoiceMsg
              WorldEvents(NumZEvents).Events(i).GameChoice.On = True
              WorldEvents(NumZEvents).Events(i).GameChoice.ChoiceName = EName
              WorldEvents(NumZEvents).Allocated = True
              GetChoiceYes EName
              GetChoiceNo EName
              i = i + 1
        Case ITEM
                tmpPar = tmpVal.val1
                ReDim Preserve WorldEvents(NumZEvents).Events(i)
                WorldEvents(NumZEvents).Events(i).GameItem.On = True
                WorldEvents(NumZEvents).Events(i).GameItem.ItemName = tmpPar
                tmpPar = tmpVal.val2
                If tmpPar = ON_ Then
                  WorldEvents(NumZEvents).Events(i).GameItem.ItemEnable = True
                Else
                  WorldEvents(NumZEvents).Events(i).GameItem.ItemEnable = False
                End If
                i = i + 1
        Case NEXTEVENT
            NEvent = True
            NumOfNext = NumOfNext + 1
            If R = False Then ReDim Preserve WorldEvents(NumZEvents).Events(i) Else ReDim IndexArray(1)
            tmpPar = EName & "xxx" & NumOfNext
            PushInx NumZEvents
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ExtraEvent.XEvent = True
            WorldEvents(NumZEvents).Events(i).ExtraEvent.XName = tmpPar
            WorldEvents(NumZEvents).ExtraEventNum = WorldEvents(NumZEvents).ExtraEventNum + 1
            WorldEvents(NumZEvents).Allocated = True
            GetNextEvent EName, NumOfNext
            NumZEvents = GetFreeEvent
            LoadEvents tmpPar
            Kill App.Path & "\Events\" & NameOfMap & "\" & tmpPar & ".txt"
            NumZEvents = PopInx
            i = i + 1
        Case EEVENT
            If R = False Then ReDim Preserve WorldEvents(NumZEvents).Events(i) Else ReDim IndexArray(1)
            tmpPar = tmpVal.val1
            PushInx NumZEvents
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).ExtraEvent.XEvent = True
            WorldEvents(NumZEvents).Events(i).ExtraEvent.XName = tmpPar
            WorldEvents(NumZEvents).ExtraEventNum = WorldEvents(NumZEvents).ExtraEventNum + 1
            WorldEvents(NumZEvents).Allocated = True
            NumZEvents = GetFreeEvent
            LoadEvents tmpPar
            NumZEvents = PopInx
            i = i + 1
        Case LMap
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).MapLoad.LMap = True
            WorldEvents(NumZEvents).Events(i).MapLoad.MapName = tmpPar
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case PLAYBG
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).PlayBGMusic.BGPlay = True
            WorldEvents(NumZEvents).Events(i).PlayBGMusic.BGName = tmpPar
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Allocated = True
            LoadBGMusic WorldEvents(NumZEvents).Events(i).PlayBGMusic.BGName, frmMain, tmpPar
            i = i + 1
        Case SETCHARPOS
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).SetGameCharPos.On = True
            WorldEvents(NumZEvents).Events(i).SetGameCharPos.CharName = tmpPar
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).SetGameCharPos.CharPos.Z = Val(tmpPar) * -10
            tmpPar = tmpVal.val3
            WorldEvents(NumZEvents).Events(i).SetGameCharPos.CharPos.y = Val(tmpPar) * 10
            tmpPar = tmpVal.val4
            WorldEvents(NumZEvents).Events(i).SetGameCharPos.CharPos.x = Val(tmpPar) * 10
            tmpPar = tmpVal.val5
            WorldEvents(NumZEvents).Events(i).SetGameCharPos.CharDir = tmpPar
            WorldEvents(NumZEvents).Allocated = True
            WorldEvents(NumZEvents).Events(i).SetGameCharPos.CharPos = GetCenterPos2(WorldEvents(NumZEvents).Events(i).SetGameCharPos.CharPos)
            i = i + 1
        Case Msg
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).Message.On = True
            tmpPar = tmpVal.val1
            If Left(tmpPar, 1) = "&" Then
              WorldEvents(NumZEvents).Events(i).Message.Text = GetMessage(CurLangLetter, Right(tmpPar, Len(tmpPar) - 1))
            Else
              WorldEvents(NumZEvents).Events(i).Message.Text = tmpPar
            End If
              If Len(WorldEvents(NumZEvents).Events(i).Message.Text) >= 80 Then WorldEvents(NumZEvents).Events(i).Message.Text = ". " & WorldEvents(NumZEvents).Events(i).Message.Text
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).Message.Duration = Val(tmpPar)
            tmpPar = tmpVal.val3
            If tmpPar = NONE Then
              WorldEvents(NumZEvents).Events(i).Message.PromtKey = False
            Else
              WorldEvents(NumZEvents).Events(i).Message.PromtKey = True
            End If
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
        Case PSOUND
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).PlaySound.On = True
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).PlaySound.SoundName = tmpPar
            WorldEvents(NumZEvents).Allocated = True
            LoadSound WorldEvents(NumZEvents).Events(i).PlaySound.SoundName, NONE
            i = i + 1
        Case SCAMPOS
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).SetCamPos.On = True
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).SetCamPos.CamPos.Z = -(Val(tmpPar) * 10)
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).SetCamPos.CamPos.y = Val(tmpPar) * 10
            tmpPar = tmpVal.val3
            WorldEvents(NumZEvents).Events(i).SetCamPos.CamPos.x = (Val(tmpPar) * 10)
            tmpPar = tmpVal.val4
            If tmpPar = NONE Then
              WorldEvents(NumZEvents).Events(i).SetCamPos.LookingAt = NONE
              tmpPar = tmpVal.val5
              WorldEvents(NumZEvents).Events(i).SetCamPos.TargetPos.Z = -(Val(tmpPar) * 10)
              tmpPar = tmpVal.val6
              WorldEvents(NumZEvents).Events(i).SetCamPos.TargetPos.y = (Val(tmpPar) * 10)
              tmpPar = tmpVal.val7
              WorldEvents(NumZEvents).Events(i).SetCamPos.TargetPos.x = (Val(tmpPar) * 10)
            Else
              WorldEvents(NumZEvents).Events(i).SetCamPos.LookingAt = (tmpPar)
            End If
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
      Case CAML
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).CamLook.On = True
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).CamLook.Direction = (tmpPar)
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).CamLook.Duration = Val(tmpPar)
            tmpPar = tmpVal.val3
            WorldEvents(NumZEvents).Events(i).CamLook.Speed = Val(tmpPar)
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
      Case LOOKFACE
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).LookAtFace.On = True
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).LookAtFace.LookingAtFace = (tmpPar)
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).LookAtFace.CamPos = (tmpPar)
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
      Case CHARFACE
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).FaceChar.On = True
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).FaceChar.CharName = (tmpPar)
            WorldEvents(NumZEvents).Events(i).FaceChar.CharNum = GetCharIndex(tmpPar)
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).FaceChar.FaceTo = tmpPar
            WorldEvents(NumZEvents).Events(i).FaceChar.FaceToNum = GetCharIndex(tmpPar)
            tmpPar = tmpVal.val3
            If tmpPar = "BACK" Then WorldEvents(NumZEvents).Events(i).FaceChar.FaceAway = True
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
      Case CHARANIM
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).CharAnimate.On = True
            WorldEvents(NumZEvents).Events(i).CharAnimate.HasINI = False
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).CharAnimate.CharName = tmpPar
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).CharAnimate.CharAni = tmpPar
            tmpPar = tmpVal.val3
            Select Case (tmpPar)
              Case WLOOP
                WorldEvents(NumZEvents).Events(i).CharAnimate.Loop = True
              Case REVERSE_
                WorldEvents(NumZEvents).Events(i).CharAnimate.Reverse = True
              Case SEESAW_
                WorldEvents(NumZEvents).Events(i).CharAnimate.SeeSaw = True
              Case PONCE
                WorldEvents(NumZEvents).Events(i).CharAnimate.Once = True
            End Select
            tmpPar = tmpVal.val4
            WorldEvents(NumZEvents).Events(i).CharAnimate.Speed = Val(tmpPar)
            tmpPar = tmpVal.val5
            WorldEvents(NumZEvents).Events(i).CharAnimate.Duration = Val(tmpPar)
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
      Case RCAM
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).RotateCam.On = True
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).RotateCam.TargetChar = tmpPar
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).RotateCam.Direction = tmpPar
            tmpPar = tmpVal.val3
            WorldEvents(NumZEvents).Events(i).RotateCam.Speed = Val(tmpPar) / 10000
            tmpPar = tmpVal.val4
            WorldEvents(NumZEvents).Events(i).RotateCam.Duration = Val(tmpPar)
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
      Case MCHAR
            ReDim Preserve WorldEvents(NumZEvents).Events(i)
            WorldEvents(NumZEvents).Events(i).MoveChar.On = True
            tmpPar = tmpVal.val1
            WorldEvents(NumZEvents).Events(i).MoveChar.CharName = tmpPar
            tmpPar = tmpVal.val2
            WorldEvents(NumZEvents).Events(i).MoveChar.Direction = tmpPar
            tmpPar = tmpVal.val3
            WorldEvents(NumZEvents).Events(i).MoveChar.Speed = Val(tmpPar)
            tmpPar = tmpVal.val4
            WorldEvents(NumZEvents).Events(i).MoveChar.Duration = Val(tmpPar)
            WorldEvents(NumZEvents).Allocated = True
            i = i + 1
      End Select
    End If
    'debug.Print WorldEvents(NumZEvents).EventName
Loop
Close #FileNum

If R = True Then
  WorldEvents(NumZEvents).NumEvents = i - 1
  NumZEvents = tmpNum
Else
  WorldEvents(NumZEvents).NumEvents = i - 1
  NumEvents = NumEvents + 1
End If
End Sub

Public Function EventPresent(EName As String) As Boolean
Dim i As Integer
For i = LBound(EventArray) To UBound(EventArray)
  If EventArray(i) = EName Then
    EventPresent = True
    Exit Function
  End If
Next
End Function

Public Sub ExecuteEvent(EName As String)
Dim i%, j%, k%, IsRunning As Boolean, ETick As Long, ETime As Integer
Dim PStart%, PEnd%, tmpPointer As XY, tmpINX%, q%
Dim strTmp$, NumXEvents%, P%
Dim NumEv As Integer, tmpVector As D3DVECTOR, tmpPos As D3DVECTOR
Dim tmpDir As Direction, tmpNum As Integer, BlankSprite As ShowSpriteStruct

i = GetEIndex((EName))
NumXEvents = WorldEvents(i).ExtraEventNum
ETick = GetTickCount

    IsRunning = True
    DoEvents
    Do While IsRunning = True
    
    If GameWillForceExit = True Then
      Exit Sub
    End If
      
      On Local Error Resume Next
      
      For j = LBound(WorldEvents(i).Events) To UBound(WorldEvents(i).Events)
      
      If Err.Number = 9 Then Exit Sub
                
'          '+++++++++++++++++++++++++++++++++++++++++++++
'
'
'        EventCancel = True
'        For k = j To UBound(WorldEvents(i).Events)
'
'          'RotateCam
'          If WorldEvents(i).Events(k).RotateCam.On = True Then
'            WorldEvents(i).Events(k).RotateCam.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'SetCamPos
'          If WorldEvents(i).Events(k).SetCamPos.On = True Then
'            WorldEvents(i).Events(k).SetCamPos.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'ShowPrev
'          If WorldEvents(i).Events(k).ShowPrev.On = True Then
'            WorldEvents(i).Events(k).ShowPrev.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'Message
'          If WorldEvents(i).Events(k).Message.On = True Then
'            WorldEvents(i).Events(k).Message.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'Sound
'          If WorldEvents(i).Events(k).PlaySound.On = True Then
'            WorldEvents(i).Events(k).PlaySound.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'FaceChar
'          If WorldEvents(i).Events(k).FaceChar.On = True Then
'            WorldEvents(i).Events(k).FaceChar.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'LookAtFace
'          If WorldEvents(i).Events(k).LookAtFace.On = True Then
'            WorldEvents(i).Events(k).LookAtFace.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'CamLook
'          If WorldEvents(i).Events(k).CamLook.On = True Then
'            WorldEvents(i).Events(k).CamLook.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'Char Animate
'          If WorldEvents(i).Events(k).CharAnimate.On = True Then
'            WorldEvents(i).Events(k).CharAnimate.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'MoveChar
'          If WorldEvents(i).Events(k).MoveChar.On Then
'            WorldEvents(i).Events(k).MoveChar.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'ShowSprite
'          If WorldEvents(i).Events(k).ShowSprite.On = True Then
'            NumEv = NumEv + 1
'            WorldEvents(i).Events(k).ShowSprite.On = False
'          End If
'
'          'Fog
'          If WorldEvents(i).Events(k).ShowFog.On = True Then
'            WorldEvents(i).Events(k).ShowFog.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'ShowTask
'          If WorldEvents(i).Events(k).ShowTask.On = True Then
'            CurTaskName = WorldEvents(i).Events(k).ShowTask.TName
'            WorldEvents(i).Events(k).ShowTask.On = False
'            NumEv = NumEv + 1
'            NewTask = True
'          End If
'
'
'          'Item
'          If WorldEvents(i).Events(k).GameItem.On = True Then
'              LoadItemFromFile WorldEvents(i).Events(k).GameItem.ItemName, WorldEvents(i).Events(k).GameItem.ItemEnable
'              WorldEvents(i).Events(k).GameItem.On = False
'              NumEv = NumEv + 1
'          End If
'
'          'Switch
'          If WorldEvents(i).Events(k).SwitchValue.On = True Then
'            If GetSwitchIndex(WorldEvents(i).Events(k).SwitchValue.SwitchName) <= 0 Then
'              LoadSwitch WorldEvents(i).Events(k).SwitchValue.SwitchName, GetState(WorldEvents(i).Events(k).SwitchValue.SwitchEnable)
'            Else
'              WorldSwitch(GetSwitchIndex(WorldEvents(i).Events(k).SwitchValue.SwitchName)).SwitchEnable = WorldEvents(i).Events(k).SwitchValue.SwitchEnable
'            End If
'            NumEv = NumEv + 1
'            WorldEvents(i).Events(k).SwitchValue.On = False
'          End If
'
'          'SetCharPos
'          If WorldEvents(i).Events(k).SetGameCharPos.On = True Then
'            tmpDir = GetDirection(WorldEvents(i).Events(k).SetGameCharPos.CharDir)
'            CharFrames(GetCharIndex(WorldEvents(i).Events(k).SetGameCharPos.CharName)).SetPosition Nothing, WorldEvents(i).Events(k).SetGameCharPos.CharPos.x, WorldEvents(i).Events(k).SetGameCharPos.CharPos.y, WorldEvents(i).Events(k).SetGameCharPos.CharPos.Z
'            CharFrames(GetCharIndex(WorldEvents(i).Events(k).SetGameCharPos.CharName)).SetOrientation Nothing, tmpDir.dx, tmpDir.dy, tmpDir.dz, tmpDir.uX, tmpDir.uy, tmpDir.uz
'            NumEv = NumEv + 1
'            WorldEvents(i).Events(k).SetGameCharPos.On = False
'            BlankTheScreen = False
'          End If
'
'          'Choice
'          If WorldEvents(i).Events(k).GameChoice.On = True Then
'            ChoiceMenu WorldEvents(i).Events(k).GameChoice.ChoiceName, WorldEvents(i).Events(k).GameChoice.ChoiceMsg
'            D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
'            D3D_Device.Update 'Update the Direct3D Device.
'            D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
'            Exit Sub
'            NumEv = NumEv + 1
'            WorldEvents(i).Events(k).GameChoice.On = False
'          End If
'
'          'StopBG
'          If WorldEvents(i).Events(k).StopBG.On = True Then
'            StopAllBG
'            WorldEvents(i).Events(k).StopBG.On = False
'            NumEv = NumEv + 1
'          End If
'
'          'BGMusic
'          If WorldEvents(i).Events(k).PlayBGMusic.BGPlay = True Then
'            PlayBGMusic WorldEvents(i).Events(k).PlayBGMusic.BGName
'            WorldEvents(i).Events(k).PlayBGMusic.BGPlay = False
'            NumEv = NumEv + 1
'          End If
'
'          'ShowEnd
'          If WorldEvents(i).Events(k).ShowEnd.On = True Then
'            ShowScores
'            WorldEvents(i).Events(k).ShowEnd.On = False
'            NumEv = NumEv + 1
'            BlankTheScreen = False
'          End If
'
'          'ShowIntro
'          If WorldEvents(i).Events(k).ShowIntro.On = True Then
'            ShowIntroScreen (WorldEvents(i).Events(k).ShowIntro.IName)
'            WorldEvents(i).Events(k).ShowIntro.On = False
'            NumEv = NumEv + 1
'            BlankTheScreen = False
'          End If
'
'          'Reload
'          If WorldEvents(i).Events(k).EventReload.On = True Then
'              SaveGameToReload "TMP__RELOAD"
'              LoadGameFromReload "TMP__RELOAD"
'              Kill App.Path & "/Events/" & "TMP__RELOAD" & ".txt"
'              WorldEvents(i).Events(k).EventReload.On = False
'              NumEv = NumEv + 1
'              'BlankTheScreen = False
'          End If
'
'          'LoadMap
'          If WorldEvents(i).Events(k).MapLoad.LMap = True And NumEv = WorldEvents(i).NumEvents - 1 Then
'            strTmp = WorldEvents(i).Events(k).MapLoad.MapName
'            ChangeMap = True
'            ChangeMapName = strTmp
'            NumEv = NumEv + 1
'            On Local Error Resume Next
'            If GetCharNumPos(i) >= 1 Then
'              If CharacterPos(GetCharNumPos(i)).ContinueMap = True Then
'                CurCharPos = CharacterPos(GetCharNumPos(i))
'              Else
'                CurCharPos.ContinueMap = False
'                CurCharPos.EventNum = 0
'                CurCharPos.PStartPos.Direction = ""
'                CurCharPos.PStartPos.Size.x = 0
'                CurCharPos.PStartPos.Size.y = -1000
'                CurCharPos.PStartPos.Size.Z = 0
'              End If
'            End If
'            MapLoaded = False
'            Exit Sub
'          End If
'
'          'ExitGame
'          If WorldEvents(i).Events(k).ExitGame.On = True Then
'            WorldEvents(i).Events(k).ExitGame.On = False
'            NumEv = NumEv + 1
'            Call DX_Exit
'            Exit Sub
'          End If
'
'          For P = 1 To WorldEvents(i).NumEvents
'            If NumEv >= WorldEvents(i).NumEvents - NumXEvents And WorldEvents(i).Events(k).ExtraEvent.XEvent = True Then
'              WorldEvents(i).Events(P).ExtraEvent.XEvent = False
'              NumXEvents = NumXEvents - 1
'              NumEv = NumEv + 1
'              ExecuteEvent WorldEvents(i).Events(P).ExtraEvent.XName
'            End If
'          Next
'
'          If NumEv >= WorldEvents(i).NumEvents Then
'            IsRunning = False
'            DeleteEventFromList WorldEvents(i).EventName
'          End If
'
'        Next
'
'          GoTo ExitSub
'          '+++++++++++++++++++++++++++++++++++++++++++++
'        End If

        'AutoSave
        If WorldEvents(i).Events(j).AutoSave.On = True Then
          AutoSaveNow
          WorldEvents(i).Events(j).AutoSave.On = False
          NumEv = NumEv + 1
        End If
        
        'ExitGame
        If WorldEvents(i).Events(j).ExitGame.On = True Then
          WorldEvents(i).Events(j).ExitGame.On = False
          NumEv = NumEv + 1
          Call DX_Exit
          Exit Sub
        End If
        
        'ShowEnd
        If WorldEvents(i).Events(j).ShowEnd.On = True Then
          ShowScores
          WorldEvents(i).Events(j).ShowEnd.On = False
          NumEv = NumEv + 1
          BlankTheScreen = False
        End If
        
        'ShowSprite
        If WorldEvents(i).Events(j).ShowSprite.On = True Then
          TemporarySprite = WorldEvents(i).Events(j).ShowSprite
          SpriteEnabled = True
        End If
        
        'StopBG
        If WorldEvents(i).Events(j).StopBG.On = True Then
          StopAllBG
          WorldEvents(i).Events(j).StopBG.On = False
          NumEv = NumEv + 1
        End If
        
        'Fog
        If WorldEvents(i).Events(j).ShowFog.On = True Then
          F_Start = WorldEvents(i).Events(j).ShowFog.FogStart
          F_End = WorldEvents(i).Events(j).ShowFog.FogEnd
          F_FColor = WorldEvents(i).Events(j).ShowFog.FogFColor
          F_BColor = WorldEvents(i).Events(j).ShowFog.FogBColor
          WorldEvents(i).Events(j).ShowFog.On = False
          FogON F_Start, F_End, F_FColor, F_BColor
          NumEv = NumEv + 1
        End If
        
        'ShowTask
        If WorldEvents(i).Events(j).ShowTask.On = True Then
          CurTaskName = WorldEvents(i).Events(j).ShowTask.TName
          WorldEvents(i).Events(j).ShowTask.On = False
          NumEv = NumEv + 1
          BlankTheScreen = False
          NewTask = True
        End If
        
        'ShowIntro
        If WorldEvents(i).Events(j).ShowIntro.On = True Then
          ShowIntroScreen (WorldEvents(i).Events(j).ShowIntro.IName)
          WorldEvents(i).Events(j).ShowIntro.On = False
          NumEv = NumEv + 1
          BlankTheScreen = False
        End If
        
        'Message
        If WorldEvents(i).Events(j).Message.On = True Then
          MessageFromEvent = WorldEvents(i).Events(j).Message.Text
          MessageFromEventPrompt = WorldEvents(i).Events(j).Message.PromtKey
          BlankTheScreen = False
        End If
        
        'Item
        If WorldEvents(i).Events(j).GameItem.On = True Then
            LoadItemFromFile WorldEvents(i).Events(j).GameItem.ItemName, WorldEvents(i).Events(j).GameItem.ItemEnable
            WorldEvents(i).Events(j).GameItem.On = False
            NumEv = NumEv + 1
        End If
        
        'Reload
        If WorldEvents(i).Events(j).EventReload.On = True Then
            SaveGameToReload "TMP__RELOAD"
            LoadGameFromReload "TMP__RELOAD"
            Kill App.Path & "/Events/" & "TMP__RELOAD" & ".txt"
            WorldEvents(i).Events(j).EventReload.On = False
            NumEv = NumEv + 1
            'BlankTheScreen = False
        End If
        
        'ShowPrev
        If WorldEvents(i).Events(j).ShowPrev.On = True Then
          ShowPreview (WorldEvents(i).Events(j).ShowPrev.PrevName)
          WorldEvents(i).Events(j).ShowPrev.On = False
          NumEv = NumEv + 1
          BlankTheScreen = False
        End If
        
        'Switch
        If WorldEvents(i).Events(j).SwitchValue.On = True Then
          If GetSwitchIndex(WorldEvents(i).Events(j).SwitchValue.SwitchName) <= 0 Then
            LoadSwitch WorldEvents(i).Events(j).SwitchValue.SwitchName, GetState(WorldEvents(i).Events(j).SwitchValue.SwitchEnable)
          Else
            WorldSwitch(GetSwitchIndex(WorldEvents(i).Events(j).SwitchValue.SwitchName)).SwitchEnable = WorldEvents(i).Events(j).SwitchValue.SwitchEnable
          End If
          NumEv = NumEv + 1
          WorldEvents(i).Events(j).SwitchValue.On = False
        End If
        
        'SetCharPos
        If WorldEvents(i).Events(j).SetGameCharPos.On = True Then
          tmpDir = GetDirection(WorldEvents(i).Events(j).SetGameCharPos.CharDir)
          CharFrames(GetCharIndex(WorldEvents(i).Events(j).SetGameCharPos.CharName)).SetPosition Nothing, WorldEvents(i).Events(j).SetGameCharPos.CharPos.x, WorldEvents(i).Events(j).SetGameCharPos.CharPos.y, WorldEvents(i).Events(j).SetGameCharPos.CharPos.Z
          CharFrames(GetCharIndex(WorldEvents(i).Events(j).SetGameCharPos.CharName)).SetOrientation Nothing, tmpDir.dx, tmpDir.dy, tmpDir.dz, tmpDir.uX, tmpDir.uy, tmpDir.uz
          NumEv = NumEv + 1
          WorldEvents(i).Events(j).SetGameCharPos.On = False
          BlankTheScreen = False
        End If
        
        'Choice
        If WorldEvents(i).Events(j).GameChoice.On = True Then
          ChoiceMenu WorldEvents(i).Events(j).GameChoice.ChoiceName, WorldEvents(i).Events(j).GameChoice.ChoiceMsg
          D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
          D3D_Device.Update 'Update the Direct3D Device.
          D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
          Exit Sub
          NumEv = NumEv + 1
          WorldEvents(i).Events(j).GameChoice.On = False
        End If
        
        'Sound
        If WorldEvents(i).Events(j).PlaySound.On = True Then
          PlaySound WorldEvents(i).Events(j).PlaySound.SoundName
          WorldEvents(i).Events(j).PlaySound.On = False
          NumEv = NumEv + 1
        End If
        
        'BGMusic
        If WorldEvents(i).Events(j).PlayBGMusic.BGPlay = True Then
          PlayBGMusic WorldEvents(i).Events(j).PlayBGMusic.BGName
          WorldEvents(i).Events(j).PlayBGMusic.BGPlay = False
          NumEv = NumEv + 1
        End If
        
        'SetCamPos
        If WorldEvents(i).Events(j).SetCamPos.On = True Then
          FR_Cam.SetPosition Nothing, WorldEvents(i).Events(j).SetCamPos.CamPos.x, WorldEvents(i).Events(j).SetCamPos.CamPos.y, WorldEvents(i).Events(j).SetCamPos.CamPos.Z
          If WorldEvents(i).Events(j).SetCamPos.LookingAt = NONE Then
            CharPointer.SetPosition Nothing, WorldEvents(i).Events(j).SetCamPos.TargetPos.x, WorldEvents(i).Events(j).SetCamPos.TargetPos.y, WorldEvents(i).Events(j).SetCamPos.TargetPos.Z
            FR_Cam.LookAt CharPointer, Nothing, D3DRMCONSTRAIN_Z
          Else
            If Left(WorldEvents(i).Events(j).SetCamPos.LookingAt, 5) = Dummy_ Then
              tmpNum = GetDummyIndex(Right(WorldEvents(i).Events(j).SetCamPos.LookingAt, Len(WorldEvents(i).Events(j).SetCamPos.LookingAt) - 5))
              CharPointer.SetPosition WorldDummy(tmpNum).ObjFrame, 0, 10, 0
              FR_Cam.LookAt CharPointer, Nothing, D3DRMCONSTRAIN_Z
            Else
              CharPointer.SetPosition CharFrames(GetCharIndex(WorldEvents(i).Events(j).SetCamPos.LookingAt)), 0, 10, 0
              FR_Cam.LookAt CharPointer, Nothing, D3DRMCONSTRAIN_Z
            End If
          End If
          WorldEvents(i).Events(j).SetCamPos.On = False
          NumEv = NumEv + 1
          BlankTheScreen = False
        End If
        
        'FaceChar
        If WorldEvents(i).Events(j).FaceChar.On = True Then
          If WorldEvents(i).Events(j).FaceChar.FaceAway = True Then
            CharFrames(WorldEvents(i).Events(j).FaceChar.CharNum).LookAt CharFrames(WorldEvents(i).Events(j).FaceChar.FaceToNum), Nothing, D3DRMCONSTRAIN_Z
          Else
            CharLookAt WorldEvents(i).Events(j).FaceChar.CharName, WorldEvents(i).Events(j).FaceChar.FaceTo
          End If
            WorldEvents(i).Events(j).FaceChar.On = False
            MoveLights
            NumEv = NumEv + 1
        End If
        
        'LookAtFace
        If WorldEvents(i).Events(j).LookAtFace.On = True Then
        AlignPointer WorldEvents(i).Events(j).LookAtFace.LookingAtFace
          Select Case (WorldEvents(i).Events(j).LookAtFace.CamPos)
            Case UP
              tmpVector.x = 0: tmpVector.y = 15: tmpVector.Z = 0
            Case DOWN
              tmpVector.x = 0: tmpVector.y = -10: tmpVector.Z = 15
            Case LEFT_
              tmpVector.x = -15: tmpVector.y = 15: tmpVector.Z = 0
            Case RIGHT_
              tmpVector.x = 15: tmpVector.y = 15: tmpVector.Z = 0
            Case FRONT
              tmpVector.x = 0: tmpVector.y = 15: tmpVector.Z = 20
            Case BACK
              tmpVector.x = 0: tmpVector.y = 15: tmpVector.Z = -20
          End Select
          FR_Cam.SetPosition CharPointerHead, tmpVector.x, tmpVector.y, tmpVector.Z
          FR_Cam.LookAt CharPointerHead, Nothing, D3DRMCONSTRAIN_Z
          WorldEvents(i).Events(j).LookAtFace.On = False
          NumEv = NumEv + 1
        End If
        
        'CamLook
        If WorldEvents(i).Events(j).CamLook.On = True Then
          Select Case (WorldEvents(i).Events(j).CamLook.Direction)
            Case UP
              tmpVector.x = 0: tmpVector.y = 0.1 * WorldEvents(i).Events(j).CamLook.Speed * GSpeed: tmpVector.Z = 0
            Case DOWN
              tmpVector.x = 0: tmpVector.y = -0.1 * WorldEvents(i).Events(j).CamLook.Speed * GSpeed: tmpVector.Z = 0
            Case LEFT_
              tmpVector.x = -0.1 * WorldEvents(i).Events(j).CamLook.Speed * GSpeed: tmpVector.y = 0: tmpVector.Z = 0
            Case RIGHT_
              tmpVector.x = 0.1 * WorldEvents(i).Events(j).CamLook.Speed * GSpeed: tmpVector.y = 0: tmpVector.Z = 0
          End Select
          CharPointerHead.AddTranslation D3DRMCOMBINE_BEFORE, tmpVector.x, tmpVector.y, tmpVector.Z
          FR_Cam.LookAt CharPointerHead, Nothing, D3DRMCONSTRAIN_Z
          BlankTheScreen = False
        End If
        
        'Char Animate
        If WorldEvents(i).Events(j).CharAnimate.On = True Then
          If WorldEvents(i).Events(j).CharAnimate.HasINI = False Then
            tmpPointer = GetCharPointerPos(WorldEvents(i).Events(j).CharAnimate.CharName, WorldEvents(i).Events(j).CharAnimate.CharAni)
            WorldEvents(i).Events(j).CharAnimate.tmpINX = GetCharIndex(WorldEvents(i).Events(j).CharAnimate.CharName)
            WorldEvents(i).Events(j).CharAnimate.HasINI = True
            If WorldEvents(i).Events(j).CharAnimate.Reverse = True Then
              WorldEvents(i).Events(j).CharAnimate.PStart = tmpPointer.y
              WorldEvents(i).Events(j).CharAnimate.PEnd = tmpPointer.x
            ElseIf WorldEvents(i).Events(j).CharAnimate.Once = True Then
              WorldEvents(i).Events(j).CharAnimate.PStart = tmpPointer.x
              WorldEvents(i).Events(j).CharAnimate.PEnd = tmpPointer.y
            ElseIf WorldEvents(i).Events(j).CharAnimate.SeeSaw = True Then
              WorldEvents(i).Events(j).CharAnimate.PStart = tmpPointer.x
              WorldEvents(i).Events(j).CharAnimate.PEnd = tmpPointer.y
            ElseIf WorldEvents(i).Events(j).CharAnimate.Loop = True Then
              WorldEvents(i).Events(j).CharAnimate.PStart = tmpPointer.x
              WorldEvents(i).Events(j).CharAnimate.PEnd = tmpPointer.y
            End If
          End If
          If WorldEvents(i).Events(j).CharAnimate.PStart < WorldEvents(i).Events(j).CharAnimate.PEnd Then
              DoEvents
              If (GetTickCount() - LastTick) >= WorldEvents(i).Events(j).CharAnimate.Speed Then
                WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = ((WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey) + 1)
                WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey + WorldEvents(i).Events(j).CharAnimate.PStart
                If WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar > WorldEvents(i).Events(j).CharAnimate.PEnd Then
                  'SeeSaw
                  If WorldEvents(i).Events(j).CharAnimate.SeeSaw = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = WorldEvents(i).Events(j).CharAnimate.PStart
                    WorldEvents(i).Events(j).CharAnimate.PStart = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldEvents(i).Events(j).CharAnimate.PEnd = WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  'Loop
                  ElseIf WorldEvents(i).Events(j).CharAnimate.Loop = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PStart
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  'Once
                  ElseIf WorldEvents(i).Events(j).CharAnimate.Once = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldEvents(i).Events(j).CharAnimate.PStart = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  'Reverse
                  ElseIf WorldEvents(i).Events(j).CharAnimate.Reverse = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldEvents(i).Events(j).CharAnimate.PStart = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  End If
                End If
                CharFrames(WorldEvents(i).Events(j).CharAnimate.tmpINX).DeleteVisual WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).AniSet(WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).PrevChar)
                CharFrames(WorldEvents(i).Events(j).CharAnimate.tmpINX).AddVisual WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).AniSet(WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar)
                WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).PrevChar = WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar
                LastTick = GetTickCount
              End If
          Else
              DoEvents
              If (GetTickCount() - LastTick) >= WorldEvents(i).Events(j).CharAnimate.Speed Then
                WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = ((WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey) + 1)
                WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = (WorldEvents(i).Events(j).CharAnimate.PStart - WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey)
                If WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar < WorldEvents(i).Events(j).CharAnimate.PEnd Then
                  'SeeSaw
                  If WorldEvents(i).Events(j).CharAnimate.SeeSaw = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = WorldEvents(i).Events(j).CharAnimate.PStart
                    WorldEvents(i).Events(j).CharAnimate.PStart = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldEvents(i).Events(j).CharAnimate.PEnd = WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  'Loop
                  ElseIf WorldEvents(i).Events(j).CharAnimate.Loop = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PStart
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  'Once
                  ElseIf WorldEvents(i).Events(j).CharAnimate.Once = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldEvents(i).Events(j).CharAnimate.PStart = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  'Reverse
                  ElseIf WorldEvents(i).Events(j).CharAnimate.Reverse = True Then
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldEvents(i).Events(j).CharAnimate.PStart = WorldEvents(i).Events(j).CharAnimate.PEnd
                    WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).GlobalKey = 0
                  End If
                End If
                CharFrames(WorldEvents(i).Events(j).CharAnimate.tmpINX).DeleteVisual WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).AniSet(WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).PrevChar)
                CharFrames(WorldEvents(i).Events(j).CharAnimate.tmpINX).AddVisual WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).AniSet(WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar)
                WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).PrevChar = WorldAni(WorldEvents(i).Events(j).CharAnimate.tmpINX).NowChar
                LastTick = GetTickCount
              End If
          End If
        End If
        
        'RotateCam
        If WorldEvents(i).Events(j).RotateCam.On = True Then
        AlignPointer WorldEvents(i).Events(j).RotateCam.TargetChar
          Select Case (WorldEvents(i).Events(j).RotateCam.Direction)
            Case UP
              tmpVector.x = -Sin5 * WorldEvents(i).Events(j).RotateCam.Speed: tmpVector.y = 0: tmpVector.Z = Cos5
            Case DOWN
              tmpVector.x = -Sin5 * WorldEvents(i).Events(j).RotateCam.Speed: tmpVector.y = 0: tmpVector.Z = Cos5
            Case LEFT_
              tmpVector.x = -Sin5 * WorldEvents(i).Events(j).RotateCam.Speed: tmpVector.y = 0: tmpVector.Z = Cos5
            Case RIGHT_
              tmpVector.x = Sin5 * WorldEvents(i).Events(j).RotateCam.Speed: tmpVector.y = 0: tmpVector.Z = Cos5
          End Select
          CharPointer.SetOrientation CharPointer, tmpVector.x, tmpVector.y, tmpVector.Z, 0, 1, 0
          tmpPos = CamCollided
          FR_Cam.SetPosition CharPointer, tmpPos.x, tmpPos.y, tmpPos.Z
          If Left(WorldEvents(i).Events(j).RotateCam.TargetChar, 5) = "DUMMY" Then
            tmpNum = GetDummyIndex(Right(WorldEvents(i).Events(j).RotateCam.TargetChar, Len(WorldEvents(i).Events(j).RotateCam.TargetChar) - 5))
            TFrm.SetPosition WorldDummy(tmpNum).ObjFrame, 0, 5, -15
          Else
            TFrm.SetPosition CharPointer, 0, 5, -15
          End If
          FR_Cam.LookAt TFrm, Nothing, D3DRMCONSTRAIN_Z
          WorldEvents(i).Events(j).RotateCam.Speed = WorldEvents(i).Events(j).RotateCam.Speed + 0.0001 * GSpeed
          BlankTheScreen = False
        End If
        
        'MoveChar
        If WorldEvents(i).Events(j).MoveChar.On Then
          Select Case WorldEvents(i).Events(j).MoveChar.Direction
            Case North
              tmpVector.x = 0: tmpVector.y = 0: tmpVector.Z = -1 * WorldEvents(i).Events(j).MoveChar.Speed * GSpeed
            Case South
              tmpVector.x = 0: tmpVector.y = 0: tmpVector.Z = 1 * WorldEvents(i).Events(j).MoveChar.Speed * GSpeed
            Case East
              tmpVector.x = 1 * WorldEvents(i).Events(j).MoveChar.Speed * GSpeed: tmpVector.y = 0: tmpVector.Z = 0
            Case West
              tmpVector.x = -1 * WorldEvents(i).Events(j).MoveChar.Speed * GSpeed: tmpVector.y = 0: tmpVector.Z = 0
          End Select
          tmpINX = GetCharIndex(WorldEvents(i).Events(j).MoveChar.CharName)
          CharFrames(tmpINX).AddTranslation D3DRMCOMBINE_BEFORE, tmpVector.x, tmpVector.y, tmpVector.Z
        End If
        
        'Update Timer
        If MessageFromEventPrompt = True Then
            WorldEvents(i).Events(j).Message.On = False
            NumEv = NumEv + 1
            Message "                                                                                                                                                                                                                                            "
            ScreenText.SMessage = ""
        End If
        
        If WorldEvents(i).Events(j).ShowSprite.Duration <= ETime And WorldEvents(i).Events(j).ShowSprite.On = True Then
          WorldEvents(i).Events(j).ShowSprite.On = False
          SpriteEnabled = False
          TemporarySprite = BlankSprite
          NumEv = NumEv + 1
        End If
        
        If MessageFromEventPrompt = False And WorldEvents(i).Events(j).Message.Duration <= ETime And WorldEvents(i).Events(j).Message.On = True Then
          WorldEvents(i).Events(j).Message.On = False
          Message "                                                                                                                                                                                                                                            "
          ScreenText.SMessage = ""
          NumEv = NumEv + 1
        End If
        
        If WorldEvents(i).Events(j).CamLook.Duration <= ETime And WorldEvents(i).Events(j).CamLook.On = True Then
          WorldEvents(i).Events(j).CamLook.On = False
          NumEv = NumEv + 1
        End If
        
        If WorldEvents(i).Events(j).RotateCam.Duration <= ETime And WorldEvents(i).Events(j).RotateCam.On = True Then
          WorldEvents(i).Events(j).RotateCam.On = False
          NumEv = NumEv + 1
        End If
        
        If WorldEvents(i).Events(j).CharAnimate.Duration <= ETime And WorldEvents(i).Events(j).CharAnimate.On = True Then
          WorldEvents(i).Events(j).CharAnimate.On = False
          NumEv = NumEv + 1
        End If
        
        If WorldEvents(i).Events(j).MoveChar.Duration <= ETime And WorldEvents(i).Events(j).MoveChar.On = True Then
          WorldEvents(i).Events(j).MoveChar.On = False
          NumEv = NumEv + 1
        End If
        
      Next
      j = j - 1
      If WorldEvents(i).Events(j).MapLoad.LMap = True And NumEv = WorldEvents(i).NumEvents - 1 Then
        
      Else
        EventRender
      End If
      
      If GetTickCount - ETick >= 1000 Then
        ETime = ETime + 1
        ETick = GetTickCount
      End If
      
      GSpeed = GetGameSpeed
      
            
      'LoadMap
        If WorldEvents(i).Events(j).MapLoad.LMap = True And NumEv = WorldEvents(i).NumEvents - 1 Then
          strTmp = WorldEvents(i).Events(j).MapLoad.MapName
          ChangeMap = True
          ChangeMapName = strTmp
          NumEv = NumEv + 1
          On Local Error Resume Next
          If GetCharNumPos(i) >= 1 Then
            If CharacterPos(GetCharNumPos(i)).ContinueMap = True Then
              CurCharPos = CharacterPos(GetCharNumPos(i))
            Else
              CurCharPos.ContinueMap = False
              CurCharPos.EventNum = 0
              CurCharPos.PStartPos.Direction = ""
              CurCharPos.PStartPos.Size.x = 0
              CurCharPos.PStartPos.Size.y = -1000
              CurCharPos.PStartPos.Size.Z = 0
            End If
          End If
          MapLoaded = False
          Exit Sub
        End If
      
      For j = 1 To WorldEvents(i).NumEvents
      
        If NumEv >= WorldEvents(i).NumEvents - NumXEvents And WorldEvents(i).Events(j).ExtraEvent.XEvent = True Then
          WorldEvents(i).Events(j).ExtraEvent.XEvent = False
          NumXEvents = NumXEvents - 1
          NumEv = NumEv + 1
          ExecuteEvent WorldEvents(i).Events(j).ExtraEvent.XName
        End If
      Next
      
      If NumEv >= WorldEvents(i).NumEvents Then
        IsRunning = False
        DeleteEventFromList WorldEvents(i).EventName
      End If
      
      DX_Input
      If DI_KSTATE.Key(WorldControl.Cancel) <> 0 Then
          If GameForceExit = True Then
            IsRunning = False
            GameWillForceExit = True
          End If
      End If
      
    
    Loop
    
    If GameWillForceExit = True Then
      Exit Sub
    End If
    
End Sub

Public Function GetCommand(x As String) As String
Dim i%, L As String, tmp As String
For i = 1 To Len(x)
  L = Mid(x, i, 1)
  If L <> "," And L <> ":" Then
    tmp = tmp & L
  Else
    GetCommand = Trim(tmp)
    Exit Function
  End If
Next
GetCommand = Trim(tmp)
End Function

Public Function GetEName(x As Integer) As String
GetEName = WorldEvents(x).EventName
End Function

Public Function GetEIndex(x As String) As Integer
Dim i As Integer
For i = LBound(EventArray) To UBound(EventArray)
  If EventArray(i) = x Then
    GetEIndex = i
    Exit Function
  End If
Next
GetEIndex = LBound(EventArray)
End Function


Public Function GetEventValues(x As String) As XVal
Dim tmp As String, tmpVal As XVal
tmp = GetCommand(x)
Select Case (tmp)
  Case CASE_
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case SWITCH
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetEventValues = tmpVal
  Case Msg
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      GetEventValues = tmpVal
  Case SCAMPOS
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      tmpVal.val6 = GetParam(x, 6)
      tmpVal.val7 = GetParam(x, 7)
      GetEventValues = tmpVal
  Case CAML
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      GetEventValues = tmpVal
  Case LOOKFACE
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetEventValues = tmpVal
  Case CHARANIM
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      GetEventValues = tmpVal
  Case SPREV
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case SETCHARPOS
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      GetEventValues = tmpVal
  Case SSPRITE
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      tmpVal.val5 = GetParam(x, 5)
      tmpVal.val6 = GetParam(x, 6)
      GetEventValues = tmpVal
  Case RCAM
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetEventValues = tmpVal
  Case Fog_ON
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetEventValues = tmpVal
  Case MCHAR
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      tmpVal.val4 = GetParam(x, 4)
      GetEventValues = tmpVal
  Case PSOUND
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetEventValues = tmpVal
  Case CHARFACE
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      tmpVal.val3 = GetParam(x, 3)
      GetEventValues = tmpVal
  Case EEVENT
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case ShowIntro_
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case TASK
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case RELOAD
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case PLAYBG
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetEventValues = tmpVal
  Case LMap
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case Lang1
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case Lang2
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case Lang3
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case CHOICE_
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
  Case ITEM
      tmpVal.val1 = GetParam(x, 1)
      tmpVal.val2 = GetParam(x, 2)
      GetEventValues = tmpVal
  Case BLANKSCREEN
      tmpVal.val1 = GetParam(x, 1)
      GetEventValues = tmpVal
End Select
End Function

Public Function GetParam(x As String, Num As Integer) As String
Dim i%, L$, tmp$, numComma%, Phrase As Boolean
  For i = 1 To Len(x)
    L = Mid(x, i, 1)
    If L = "_" Then
      If Phrase = True Then
        Phrase = False
      Else
        Phrase = True
      End If
    End If
    If (L = "," Or L = ":") And Phrase = False Then
      If numComma < Num Then
        tmp = ""
        numComma = numComma + 1
      Else
        tmp = DeleteLetter("_", tmp)
        GetParam = Trim(tmp)
        Exit Function
      End If
    ElseIf L = ":" And Phrase = False Then
      tmp = ""
    Else
      tmp = tmp & L
    End If
  Next
tmp = DeleteLetter("_", tmp)
GetParam = Trim(tmp)
End Function

Private Sub EventRender()
Dim i%, j%
MoveLights
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
   DS_Back.SetForeColor RGB(0, 0, 0)
 'Lets put our main loop. Make it loop until esc = true (I'll explain later)
   On Local Error Resume Next 'Incase there is an error
   DoEvents 'Give the computer time to do what it needs to do.
    If BlankTheScreen = True Then
    ShowBlankScreen
   Else
    D3D_ViewPort.Clear D3DRMCLEAR_TARGET Or D3DRMCLEAR_ZBUFFER 'Clear your viewport.
    D3D_Device.Update 'Update the Direct3D Device.
    D3D_ViewPort.Render FR_Root 'Render the 3D Objects (lights, and your building!)
   End If
   
   If MessageFromEvent <> "" Then
    If MessageFromEventPrompt = False Then
      MessageBox MessageFromEvent, False
    Else
      MessageBox MessageFromEvent, True
    End If
    Message "                                                                                                                                                                                                                                            "
    ScreenText.SMessage = ""
    MessageFromEvent = ""
    MessageFromEventPrompt = False
   Else
      MessageFromEvent = ""
      MessageFromEventPrompt = False
      Message "                                                                                                                                                                                                                                            "
      ScreenText.SMessage = ""
   End If
   
   If SpriteEnabled = True Then
    i = GetSpriteIndex(TemporarySprite.Spic)
    DS_Back.BltFast TemporarySprite.SX, TemporarySprite.SY, WorldSprite(i).SSurf, WorldSprite(i).SRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
   End If
   DS_Front.Flip Nothing, DDFLIP_WAIT  'Flip the back buffer with the front buffer.
DS_Back.SetForeColor RGB(255, 255, 255)
CheckBGMusicLoop
FogON F_Start, F_End, F_FColor, F_BColor
End Sub

Public Sub DeleteEventFromList(ByVal EName As String)
Dim i%, tmp As EventList
For i = 1 To UBound(WorldEvents)
  If WorldEvents(i).EventName = EName Then
    WorldEvents(i) = tmp
  End If
Next
End Sub

Public Sub DeleteALLEventFromList(ByVal EName As String)
Dim i%, tmp As EventList
For i = 1 To UBound(WorldEvents)
  If Left(WorldEvents(i).EventName, Len(EName)) = EName Then
    WorldEvents(i) = tmp
  End If
Next
End Sub

Public Sub GetCase(FName As String)
Dim FileNum As Integer, Intext As String, tmpVal As XVal
Dim tmp As String, i As Integer, SCopy As Boolean, tmpEvent As String
FileNum = FreeFile
AddFile FName, FileNum
  Open App.Path & "\Events\" & FName & ".txt" For Input As FileNum
  Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
        Select Case Trim((tmp))
          Case CASE_
            If SCopy = True Then SCopy = False: GoTo EndReach
            If SwitchEnabled(tmpVal.val1) = True Then
            SCopy = True
            End If
          Case CASEELSE_
            If SCopy = False Then
              SCopy = True
            Else
              SCopy = False
              GoTo EndReach
            End If
          Case ENDSELECT_
            SCopy = False
            GoTo EndReach
          Case Else
            If SCopy = True Then
              tmpEvent = Chr(13) & Chr(10) & tmpEvent & Intext & Chr(13) + Chr(10)
            End If
        End Select
    End If
  Loop
EndReach:
  Close #FileNum
  
  Name App.Path & "\Events\" & FName & ".txt" As App.Path & "\Events\tmpEvent" & FName & ".txt"
  
  FileNum = FreeFile
  AddFile FName, FileNum
  Open App.Path & "\Events\" & FName & ".txt" For Output As FileNum
  tmpEvent = FTextWrite(tmpEvent)
  Write #FileNum, tmpEvent
  Close #FileNum
  
End Sub

Public Sub ReturnEName(FName As String)
CloseFile FName
On Error Resume Next
Kill App.Path & "\Events\" & FName & ".txt"
Name App.Path & "\Events\tmpEvent" & FName & ".txt" As App.Path & "\Events\" & FName & ".txt"
End Sub

Public Sub GetChoiceYes(FName As String)
Dim FileNum As Integer, Intext As String, tmpVal As XVal
Dim tmp As String, i As Integer, SCopy As Boolean, tmpEvent As String
FileNum = FreeFile
AddFile FName, FileNum
  Open App.Path & "\Events\" & FName & ".txt" For Input As FileNum
  Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
        Select Case Trim((tmp))
          Case YES_
            SCopy = True
          Case NO_
            If SCopy = True Then
              SCopy = False
              GoTo EndReach
            End If
          Case CHOICEEND
            SCopy = False
            GoTo EndReach
          Case Else
            If SCopy = True Then
              tmpEvent = Chr(13) & Chr(10) & tmpEvent & Intext & Chr(13) + Chr(10)
            End If
        End Select
    End If
  Loop
EndReach:
  Close #FileNum
  FileNum = FreeFile
  AddFile FName & "YES", FileNum
  Open App.Path & "\Events\" & FName & "YES" & ".txt" For Output As FileNum
  tmpEvent = FTextWrite(tmpEvent)
  Write #FileNum, tmpEvent
  Close #FileNum
  LoadEvents FName & "YES"
  CloseFile FName & "YES"
  Kill App.Path & "\Events\" & FName & "YES" & ".txt"
End Sub


Public Sub GetChoiceNo(FName As String)
Dim FileNum As Integer, Intext As String, tmpVal As XVal
Dim tmp As String, i As Integer, SCopy As Boolean, tmpEvent As String
FileNum = FreeFile
AddFile FName, FileNum
  Open App.Path & "\Events\" & FName & ".txt" For Input As FileNum
  Do Until EOF(FileNum)
    Line Input #FileNum, Intext
    If Intext <> "" Or Left(Intext, 2) <> "//" Then
    tmp = GetCommand(Intext)
    tmpVal = GetOBJValues(Intext)
        Select Case Trim((tmp))
          Case NO_
            SCopy = True
          Case YES_
            If SCopy = True Then
              SCopy = False
              GoTo EndReach
            End If
          Case CHOICEEND
            SCopy = False
            GoTo EndReach
          Case Else
            If SCopy = True Then
              tmpEvent = Chr(13) & Chr(10) & tmpEvent & Intext & Chr(13) + Chr(10)
            End If
        End Select
    End If
  Loop
EndReach:
  Close #FileNum
  FileNum = FreeFile
  AddFile FName & "NO", FileNum
  Open App.Path & "\Events\" & FName & "NO" & ".txt" For Output As FileNum
  tmpEvent = FTextWrite(tmpEvent)
  Write #FileNum, tmpEvent
  Close #FileNum
  LoadEvents FName & "NO"
  CloseFile FName & "NO"
  Kill App.Path & "\Events\" & FName & "NO" & ".txt"
End Sub

