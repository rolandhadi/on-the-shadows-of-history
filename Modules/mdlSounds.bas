Attribute VB_Name = "mdlSounds"
Option Explicit
Option Base 1
Option Compare Text

Public DS_Primary3DSoundBuffer As DirectSoundBuffer
Public DS_Sound3dListener As DirectSound3DListener

Public Const MAXVOL = 10000
Public Const MINVOL = -10000

Public CurSEVol As Long
Public CurBGVol As Long
Public CurLang As Integer, CurLangLetter As String

Public Type DX_Sound
  SBuffer As DirectSoundBuffer
  Sname As String
  SVolume As Long
  SMute As Boolean
  Looping As Boolean
End Type: Public WorldSound() As DX_Sound

Public Type DX_3DSound
  SBuffer3D As DirectSound3DBuffer
  Sname As String
  SVolume As Long
  SMute As Boolean
  Looping As Boolean
End Type: Public WorldSound3D() As DX_3DSound

Public Type DX_BGMusic
  BGName As String
  BGFileName As String
  BGLoop As Boolean
  BGTTime As Long
  BGPlaying As Boolean
  v_dmp As DirectMusicPerformance
  v_dml As DirectMusicLoader
  v_dms As DirectMusicSegment
  v_dmss As DirectMusicSegmentState
  vl_second As Long
End Type: Public WorldBG() As DX_BGMusic

Public NumBG As Integer
Public NumSounds As Integer, Num3DSounds As Integer


Public Sub LoadBGMusic(MName As String, FRM As Form, BGLoop As String)
If GetBGINX(MName) >= 1 Then Exit Sub
ReDim Preserve WorldBG(NumBG)
Set WorldBG(NumBG).v_dml = DX_Main.DirectMusicLoaderCreate
Set WorldBG(NumBG).v_dmp = DX_Main.DirectMusicPerformanceCreate
WorldBG(NumBG).BGFileName = App.Path & "\BGMusics/" & MName & ".mid"
Call WorldBG(NumBG).v_dmp.Init(Nothing, FRM.hWnd)
Call WorldBG(NumBG).v_dmp.SetPort(-1, 1)
WorldBG(NumBG).BGName = MName
If BGLoop = WLOOP Then WorldBG(NumBG).BGLoop = True
NumBG = NumBG + 1
End Sub

Public Sub PlayBGMusic(BGName As String)
Dim BGinx As Integer, i As Integer
'On Local Error Resume Next
BGinx = GetBGINX(BGName)

      Call WorldBG(BGinx).v_dmp.Stop(WorldBG(BGinx).v_dms, WorldBG(BGinx).v_dmss, 0, 0)
      'Call v_dms.Unload(v_dmp)
      WorldBG(BGinx).vl_second = 0

    Set WorldBG(BGinx).v_dms = WorldBG(BGinx).v_dml.LoadSegment(WorldBG(BGinx).BGFileName)

        WorldBG(BGinx).v_dms.SetStandardMidiFile

    Call WorldBG(BGinx).v_dmp.SetMasterAutoDownload(True)
    Call WorldBG(BGinx).v_dms.Download(WorldBG(BGinx).v_dmp)

    Set WorldBG(BGinx).v_dmss = WorldBG(BGinx).v_dmp.PlaySegment(WorldBG(BGinx).v_dms, 0, 0)
    WorldBG(BGinx).BGTTime = WorldBG(BGinx).v_dms.GetLength
    WorldBG(BGinx).vl_second = 0
    Call WorldBG(BGinx).v_dmp.SetMasterVolume(CurBGVol)
    If WorldBG(BGinx).BGLoop = True Then WorldBG(BGinx).BGPlaying = True
    Exit Sub
End Sub

Public Function GetBGINX(BGName As String) As Integer
  Dim i As Integer
  For i = 1 To UBound(WorldBG)
    If WorldBG(i).BGName = BGName Then
      GetBGINX = i
      Exit Function
    End If
  Next
   GetBGINX = -1
End Function


Public Sub DX_SoundINI()
Dim PrimarySoundBufferDesc As DSBUFFERDESC, PrimaryWaveFormat As WAVEFORMATEX
Set DS_Main = DX_Main.DirectSoundCreate("")
DS_Main.SetCooperativeLevel frmMain.hWnd, DSSCL_PRIORITY
PrimarySoundBufferDesc.lFlags = DSBCAPS_CTRL3D Or DSBCAPS_PRIMARYBUFFER
Set DS_Primary3DSoundBuffer = DS_Main.CreateSoundBuffer(PrimarySoundBufferDesc, PrimaryWaveFormat)
Set DS_Sound3dListener = DS_Primary3DSoundBuffer.GetDirectSound3DListener()
End Sub

Public Sub DX_SoundINI2()
Dim PrimarySoundBufferDesc As DSBUFFERDESC, PrimaryWaveFormat As WAVEFORMATEX
Set DS_Main = DX_Main.DirectSoundCreate("")
DS_Main.SetCooperativeLevel frmStart.hWnd, DSSCL_PRIORITY
PrimarySoundBufferDesc.lFlags = DSBCAPS_CTRL3D Or DSBCAPS_PRIMARYBUFFER
Set DS_Primary3DSoundBuffer = DS_Main.CreateSoundBuffer(PrimarySoundBufferDesc, PrimaryWaveFormat)
Set DS_Sound3dListener = DS_Primary3DSoundBuffer.GetDirectSound3DListener()
End Sub


Public Sub LoadSound(Sname As String, Looping As String)
Dim SoundBufferDesc As DSBUFFERDESC, WaveFormat As WAVEFORMATEX
    If GetSoundIndex(Sname) = -1 Then
      ReDim Preserve WorldSound(NumSounds)
      SoundBufferDesc.lFlags = DSBCAPS_STICKYFOCUS Or DSBCAPS_CTRLVOLUME Or DSBCAPS_CTRLPAN Or DSBCAPS_CTRLFREQUENCY Or DSBCAPS_STATIC
      Set WorldSound(NumSounds).SBuffer = DS_Main.CreateSoundBufferFromFile(App.Path & "\Sounds\" & Sname & ".wav", SoundBufferDesc, WaveFormat)
      WorldSound(NumSounds).Sname = Sname
      WorldSound(NumSounds).SVolume = CurSEVol
      WorldSound(NumSounds).SMute = False
      If Looping = WLOOP Then
        WorldSound(NumSounds).Looping = True
      Else
        WorldSound(NumSounds).Looping = False
      End If
      NumSounds = NumSounds + 1
    End If
End Sub

Public Sub LoadSound3D(Sname As String, Looping As String)
Dim SoundBufferDesc As DSBUFFERDESC, WaveFormat As WAVEFORMATEX
      ReDim Preserve WorldSound3D(Num3DSounds)
      SoundBufferDesc.lFlags = DSBCAPS_STICKYFOCUS Or DSBCAPS_CTRLVOLUME Or DSBCAPS_CTRLPAN Or DSBCAPS_CTRLFREQUENCY Or DSBCAPS_STATIC
      Set WorldSound3D(Num3DSounds).SBuffer3D = DS_Main.CreateSoundBufferFromFile(App.Path & "\Sounds\" & Sname & ".wav", SoundBufferDesc, WaveFormat)
      Set WorldSound3D(Num3DSounds).SBuffer3D = WorldSound(Num3DSounds).SBuffer.GetDirectSound3DBuffer
      WorldSound3D(Num3DSounds).Sname = Sname
      WorldSound3D(Num3DSounds).SVolume = CurSEVol
      WorldSound3D(Num3DSounds).SMute = False
      If Looping = WLOOP Then
        WorldSound3D(Num3DSounds).Looping = True
      Else
        WorldSound3D(Num3DSounds).Looping = False
      End If
End Sub

Public Sub PlaySound(Sname As String)
Dim i As Integer
i = GetSoundIndex(Sname)
If i = -1 Then LoadSound Sname, NONE
i = GetSoundIndex(Sname)
If WorldSound(i).Looping = True Then
   WorldSound(i).SBuffer.SetVolume CurSEVol
   WorldSound(i).SBuffer.Play DSBPLAY_LOOPING
Else
  WorldSound(i).SBuffer.SetVolume CurSEVol
  WorldSound(i).SBuffer.Play DSBPLAY_DEFAULT
End If
End Sub

Public Function GetSoundIndex(Sname As String) As Integer
Dim i As Integer
For i = LBound(WorldSound) To UBound(WorldSound)
  If WorldSound(i).Sname = Sname Then
    GetSoundIndex = i
    Exit Function
  End If
Next
GetSoundIndex = -1
End Function

Public Function GetSound3DIndex(Sname As String) As Integer
Dim i As Integer
For i = LBound(WorldSound3D) To UBound(WorldSound3D)
  If WorldSound3D(i).Sname = Sname Then
    GetSound3DIndex = i
    Exit Function
  End If
Next
End Function

Public Sub Change_3DListenerPosition(Sname As String, ByVal xPos As Single, ByVal yPos As Single, ByVal zPos As Single, _
        Optional ByVal xVelocity As Single = 0, Optional ByVal yVelocity As Single = 0, Optional ByVal zVelocity As Single = 0, _
        Optional ByVal xFront As Single = 0, Optional ByVal yFront As Single = 0, Optional ByVal zFront As Single = 0, _
        Optional ByVal xTop As Single = 0, Optional ByVal yTop As Single = 0, Optional ByVal zTop As Single = 0)
        
  'On Error Resume Next
  
  With DS_Sound3dListener
    .SetPosition xPos, yPos, zPos, DS3D_DEFERRED
    .SetVelocity xVelocity, yVelocity, zVelocity, DS3D_DEFERRED
    .SetOrientation xFront, yFront, zFront, xTop, yTop, zTop, DS3D_DEFERRED
  End With
End Sub

Public Sub CheckBGMusicLoop()
Dim i As Integer, tmpTimer As Long
On Local Error Resume Next
For i = LBound(WorldBG) To UBound(WorldBG)
  If WorldBG(i).BGLoop = True And WorldBG(i).BGPlaying = True Then
    CurBGMusic = WorldBG(i).BGName
    tmpTimer = WorldBG(i).v_dmss.GetSeek
    If tmpTimer >= WorldBG(i).BGTTime Then
      PlayBGMusic WorldBG(i).BGName
      CurBGMusic = WorldBG(i).BGName
    End If
  Else
    tmpTimer = WorldBG(i).v_dmss.GetSeek
    If tmpTimer >= WorldBG(i).BGTTime Then
      Call WorldBG(i).v_dmp.Stop(WorldBG(i).v_dms, WorldBG(i).v_dmss, 0, 0)
      Call WorldBG(i).v_dms.Unload(WorldBG(i).v_dmp)
    End If
  End If
Next
End Sub

Public Sub StopAllBG()
Dim i As Integer
On Local Error Resume Next
For i = LBound(WorldBG) To UBound(WorldBG)
  Call WorldBG(i).v_dmp.Stop(WorldBG(i).v_dms, WorldBG(i).v_dmss, 0, 0)
  Call WorldBG(i).v_dms.Unload(WorldBG(i).v_dmp)
  WorldBG(i).BGPlaying = False
Next

For i = LBound(WorldBG) To UBound(WorldBG)
  Call WorldBG(i).v_dmp.Stop(WorldBG(i).v_dms, WorldBG(i).v_dmss, 0, 0)
  Call WorldBG(i).v_dms.Unload(WorldBG(i).v_dmp)
  WorldBG(i).BGPlaying = False
Next
End Sub
