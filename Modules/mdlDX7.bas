Attribute VB_Name = "mdlDX7"
Option Explicit
Option Base 1
Option Compare Text
Public esc As Boolean, LoadedAll As Boolean
'General Declarations
'These three components are the big daddy of what your 3D Program.
Public DX_Main As New DirectX7 ' The DirectX core file (The heart of it all)
Public DD_Main As DirectDraw4 ' The DirectDraw Object
Public D3D_Main As Direct3DRM3 ' The direct3D Object
'DirectInput Components
Public DI_Main As DirectInput ' The DirectInput core
Public DI_KBOARD As DirectInputDevice ' The DirectInput device
Public DI_MOUSE As DirectInputDevice
Public DI_KSTATE As DIKEYBOARDSTATE 'Array Holding the state of the keys
Public DI_MSTATE As DIMOUSESTATE
'DirectDraw Surfaces- Where the screen is drawn.
Public DS_Front As DirectDrawSurface4 ' The frontbuffer (What you see on the screen)
Public DS_Back As DirectDrawSurface4 ' The backbuffer, (Where everything is drawn before it's put on the screen.)
Public SD_Front As DDSURFACEDESC2 ' The SurfaceDescription
Public DD_Back As DDSCAPS2 ' General Surface Info
'ViewPort and Direct3D Device
Public FR_Root As Direct3DRMFrame3, FR_Cam As Direct3DRMFrame3
Public D3D_Device As Direct3DRMDevice3 'The Main Direct3D Retained Mode Device
Public D3D_ViewPort As Direct3DRMViewport2 'The Direct3D Retained Mode Viewport (Kinda the camera)
Public BackGround As Direct3DRMTexture3 'This will be the texture that holds our background.
'DirectSound
Public DS_Main As DirectSound
Public SWidth As Integer, SHeight As Integer, SDepth As Integer

Public cKey As DDCOLORKEY

'Note: Texture files must have side lengths that are devisible by 2!
'======================================================================================

Public Const Sin5 = 8.715574E-02!     ' Sin(5°)
Public Const Cos5 = 0.9961947!        ' Cos(5°)
Public Const WSpeed = 0.5
Public Const RSpeed = 1
Public Const BSpeed = 0.3
Public GSpeed As Double

Public Sub DX_Init()
SWidth = 640
SHeight = 480
SDepth = 32
 'This sub will initialize all your components and set them up.
 Set DD_Main = DX_Main.DirectDraw4Create("") 'Create the DirectDraw Object
 DD_Main.SetCooperativeLevel frmMain.hWnd, DDSCL_FULLSCREEN Or DDSCL_EXCLUSIVE 'Set Screen Mode (Full 'Screen)
 DD_Main.SetDisplayMode CLng(SWidth), CLng(SHeight), CLng(SDepth), 0, DDSDM_DEFAULT 'Set Resolution and BitDepth (Lets use 32-bit color)
 
 SD_Front.lFlags = DDSD_CAPS Or DDSD_BACKBUFFERCOUNT
 SD_Front.ddsCaps.lCaps = DDSCAPS_PRIMARYSURFACE Or DDSCAPS_3DDEVICE Or DDSCAPS_COMPLEX Or _
 DDSCAPS_FLIP 'I used the line-continuation ( _ ) because the whole thing wouldn't fit on one line...
 SD_Front.lBackBufferCount = 1 'Make one backbuffer
 Set DS_Front = DD_Main.CreateSurface(SD_Front) 'Initialize the front buffer (the screen)
 'The Previous block of code just created the screen and the backbuffer.
 
 DD_Back.lCaps = DDSCAPS_BACKBUFFER
 
 Set DS_Back = DS_Front.GetAttachedSurface(DD_Back)
 DS_Back.SetForeColor RGB(255, 255, 255)
 'The backbuffer was initialized and the DirectDraw text color was set to white.

 Set D3D_Main = DX_Main.Direct3DRMCreate() 'Creates the Direct3D Retained Mode Object!!!!!

 Set D3D_Device = D3D_Main.CreateDeviceFromSurface("IID_IDirect3DHALDevice", DD_Main, DS_Back, _
 D3DRMDEVICE_DEFAULT) 'Tell the Direct3D Device that we are using hardware rendering (HALDevice) instead
                                   'of software enumeration (RGBDevice).
 D3D_Device.SetBufferCount 2 'Set the number of buffers
 D3D_Device.SetQuality D3DRMRENDER_GOURAUD 'Set Rendering Quality. Can use Flat, or WireFrame, but
                                                                  'GOURAUD has the best rendering quality.
 D3D_Device.SetTextureQuality D3DRMTEXTURE_LINEAR 'Set the texture quality
 D3D_Device.SetRenderMode D3DRMRENDERMODE_BLENDEDTRANSPARENCY 'Set the render mode.

 Set DI_Main = DX_Main.DirectInputCreate() 'Create the DirectInput Device
 Set DI_KBOARD = DI_Main.CreateDevice("GUID_SysKeyboard") 'Set it to use the keyboard.
 Set DI_MOUSE = DI_Main.CreateDevice("GUID_SysMouse")
 DI_KBOARD.SetCommonDataFormat DIFORMAT_KEYBOARD 'Set the data format to the keyboard format.
 DI_KBOARD.SetCooperativeLevel frmMain.hWnd, DISCL_BACKGROUND Or DISCL_NONEXCLUSIVE 'Set Coperative Level.
 DI_KBOARD.Acquire
 DI_MOUSE.SetCommonDataFormat DIFORMAT_MOUSE  'Set the data format to the keyboard format.
 DI_MOUSE.SetCooperativeLevel frmMain.hWnd, DISCL_BACKGROUND Or DISCL_NONEXCLUSIVE 'Set Coperative Level.
 DI_MOUSE.Acquire
 'The above block of code configures the DirectInput Device and starts it.
 DX_SoundINI
 GetTick
 LastFrameCount = 30
 GSpeed = GetGameSpeed
End Sub

Public Sub DX_Exit()
Dim i As Integer

Wait 200
      DX_Input
Wait 200

Call DD_Main.RestoreDisplayMode
Call DD_Main.SetCooperativeLevel(frmMain.hWnd, DDSCL_NORMAL)

Call DI_KBOARD.Unacquire
Call DI_MOUSE.Unacquire

On Local Error Resume Next
For i = LBound(WorldBG) To UBound(WorldBG)
  Call WorldBG(i).v_dmp.Stop(WorldBG(i).v_dms, WorldBG(i).v_dmss, 0, 0)
  Call WorldBG(i).v_dms.Unload(WorldBG(i).v_dmp)
Next

Set DX_Main = Nothing
Set DD_Main = Nothing
Set DS_Main = Nothing
Set DI_Main = Nothing

Set DX_Main = Nothing
Set DD_Main = Nothing
Set DS_Main = Nothing
Set DI_Main = Nothing

Unload frmKeys
Unload frmLoad
Unload frmName
Unload frmOpt
Unload frmStart
On Error Resume Next

    Erase WorldAni: Erase SrfFrames
    Erase WorldObjMatrix
    Erase WorldLight
    Erase LightFrames
    Erase WorldAni: Erase WorldDummy
    Erase WorldSound
    Erase WorldSound3D
    Erase WorldObj: Erase WorldLObj
    Erase WorldTask
    Erase MapEvents
    Erase IndexArray
    Erase WorldConditions
    Erase WorldEvents
    Erase WorldAI
    Erase CharacterPos
    Erase EventArray

Close
Kill App.Path & "\Events\*.txt"
frmStart.Show 1

End Sub

Public Sub FogON(FStart As Double, FEnd As Double, FFColor As Integer, FBColor As Integer)
    FR_Root.SetSceneFogEnable 1 'true
    FR_Root.SetSceneFogMode D3DRMFOG_LINEAR 'EXPONENTIAL
    FR_Root.SetSceneFogColor FFColor * 65536 + FFColor * 256 + FFColor
    FR_Root.SetSceneBackground FBColor * 65536 + FBColor * 256 + FBColor
    FR_Root.SetSceneFogMethod D3DRMFOGMETHOD_TABLE
    FR_Root.SetSceneFogParams FStart + 50, FEnd, 1
    FR_Root.SetZbufferMode D3DRMZBUFFER_ENABLE
End Sub

Public Sub INIVar()
Dim i As Integer, j As Integer
    ReDim WorldAni(1): ReDim SrfFrames(1)
    ReDim WorldObjMatrix(1)
    ReDim WorldLight(1)
    ReDim LightFrames(1)
    NumOpFiles = 1
    ReDim WorldAni(1): ReDim WorldDummy(1)
    ReDim WorldAni(1).AniSet(1)
    ReDim WorldSound(1)
    ReDim WorldSound3D(1)
    ReDim WorldObj(1): ReDim WorldLObj(1)
    NumLObjects = 1
    NumSounds = 1: Num3DSounds = 1
    NumObjects = 1: NumSrfFrames = 1
    NumEvents = 1: NumLights = 1
    NumChar = 1: NumFrames = 1
    NumMatrix = 1: NumSounds = 1
    Num3DSounds = 1: NumDummy = 1
'    NumTask = 1
'    ReDim WorldTask(1)
    NumMapEvents = 1: ReDim MapEvents(1)
    ReDim IndexArray(1)
    Set SrfFrames(1) = Nothing
    Set LightFrames(1) = Nothing
    Set WorldAni(1).AniSet(1) = Nothing
    ReDim WorldConditions(1)
    NumConditions = 1
    ReDim WorldEvents(1)
    ReDim WorldAI(1)
    NumAI = 1
    ReDim CharacterPos(1)
    NumCharPos = 1
    ReDim EventArray(1)
    CanSave = False

    cKey.low = RGB(255, 0, 255)  'its Magenta
    cKey.high = cKey.low
    
    GFont.Name = "Book Antiqua"
    GFont.Size = 11
    GFont.Bold = True
    GFont.Weight = 1000
    DS_Back.SetFont GFont
    SFont.Name = "Book Antiqua"
    SFont.Size = 40
    SFont.Bold = True
    SFont.Weight = 1000
    If LoadedAll = False Then LoadImagesAndSounds
    MessageFromEventPrompt = False
    SpriteEnabled = False
    CurEvent = ""
End Sub

Public Sub LoadImagesAndSounds()
NumSprites = 1
ReDim WorldSprite(1)
LoadSprite "Form-Save", 150, 300
LoadSprite "Form-Menu", 150, 300
LoadSprite "Footer", 100, 640
LoadSprite "GMenu", 40, 640
LoadSprite "Compass", 80, 80
LoadSprite "Chicken", 192, 128
LoadSprite "Bunny", 192, 128
LoadSprite "Form-Load", 150, 300
LoadSprite "Form-Items", 256, 480
LoadSprite "Form-Help", 256, 480
LoadSprite "NewTask", 60, 60
LoadSprite "Form-YesOrNo", 150, 300
LoadSprite "Cursor", 26, 26
IniItems
LoadPanel
    ReDim WorldSound(1)
    NumSounds = 1
    ReDim WorldBG(1)
    NumBG = 1
LoadedAll = True
End Sub

Public Sub LoadImages()
NumSprites = 1
ReDim WorldSprite(1)
LoadSprite "Form-Save", 150, 300
LoadSprite "Form-Menu", 150, 300
LoadSprite "Footer", 100, 640
LoadSprite "GMenu", 40, 640
LoadSprite "Compass", 80, 80
LoadSprite "Chicken", 192, 128
LoadSprite "Bunny", 192, 128
LoadSprite "Form-Load", 150, 300
LoadSprite "Form-Items", 256, 480
LoadSprite "Form-Help", 256, 480
LoadSprite "Form-YesOrNo", 150, 300
LoadSprite "Cursor", 26, 26
IniItems
LoadPanel
End Sub
