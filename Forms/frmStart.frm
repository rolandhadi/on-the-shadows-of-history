VERSION 5.00
Begin VB.Form frmStart 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "On The Shadows Of History"
   ClientHeight    =   7545
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7830
   Icon            =   "frmStart.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   Picture         =   "frmStart.frx":0CCA
   ScaleHeight     =   7545
   ScaleMode       =   0  'User
   ScaleWidth      =   8985.916
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdHelp 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   990
      Picture         =   "frmStart.frx":45EA5
      Style           =   1  'Graphical
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   5265
      Width           =   3045
   End
   Begin VB.CommandButton cmd5 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   135
      Picture         =   "frmStart.frx":4CCCF
      Style           =   1  'Graphical
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   2970
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd5_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   3330
      Picture         =   "frmStart.frx":53AF9
      Style           =   1  'Graphical
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   2970
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd1_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   3330
      Picture         =   "frmStart.frx":5A8F9
      Style           =   1  'Graphical
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd2_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   3330
      Picture         =   "frmStart.frx":619DB
      Style           =   1  'Graphical
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   855
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd3_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   3330
      Picture         =   "frmStart.frx":68AC8
      Style           =   1  'Graphical
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   1575
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd4_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   3330
      Picture         =   "frmStart.frx":6FA9E
      Style           =   1  'Graphical
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   2295
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   135
      Picture         =   "frmStart.frx":7686C
      Style           =   1  'Graphical
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd2 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   135
      Picture         =   "frmStart.frx":7D9C0
      Style           =   1  'Graphical
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   855
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd3 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   135
      Picture         =   "frmStart.frx":84B17
      Style           =   1  'Graphical
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   1575
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd4 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   135
      Picture         =   "frmStart.frx":8BB18
      Style           =   1  'Graphical
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   2295
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmdExit 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   990
      Picture         =   "frmStart.frx":928EB
      Style           =   1  'Graphical
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   6615
      Width           =   3045
   End
   Begin VB.CommandButton cmdOpt 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   990
      Picture         =   "frmStart.frx":996BE
      Style           =   1  'Graphical
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   5940
      Width           =   3045
   End
   Begin VB.CommandButton cmdLoad 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   990
      Picture         =   "frmStart.frx":A06BF
      Style           =   1  'Graphical
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   4590
      Width           =   3045
   End
   Begin VB.CommandButton cmdNew 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   990
      Picture         =   "frmStart.frx":A7816
      Style           =   1  'Graphical
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   3915
      Width           =   3045
   End
   Begin VB.Image img1 
      Height          =   9000
      Left            =   0
      Picture         =   "frmStart.frx":AE96A
      Top             =   0
      Width           =   12000
   End
End
Attribute VB_Name = "frmStart"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Option Base 1
Option Compare Text

Dim OnButton As Boolean

Private Sub cmdExit_Click()
PlaySound "Cancel"
Wait 800
End
End Sub

Private Sub cmdExit_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdExit.Picture = cmd4_1.Picture
End Sub

Private Sub cmdHelp_Click()
PlaySound "Door-1"
frmHelp.Show 1
End Sub

Private Sub cmdHelp_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdHelp.Picture = cmd5_1.Picture
End Sub

Private Sub cmdLoad_Click()
  PlaySound "Door-1"
  Wait 400
  frmLoad.Show 1
End Sub

Private Sub cmdLoad_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdLoad.Picture = cmd2_1.Picture
End Sub

Private Sub cmdNew_Click()
PlaySound "Door-1"
Wait 400
frmName.Show 1
End Sub

Private Sub cmdNew_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdNew.Picture = cmd1_1.Picture
End Sub

Private Sub cmdOpt_Click()
  PlaySound "Door-1"
  GetConfig
  Wait 400
  frmOpt.Show 1
End Sub

Private Sub cmdOpt_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdOpt.Picture = cmd3_1.Picture
End Sub

Private Sub Form_Load()
If App.PrevInstance = True Then End
Unload frmMain
CopyAllEvents
IniWorldKey
LoadKeyFromFile
GetConfig
DX_SoundINI2
ReDim WorldSound(1)
NumSounds = 1
ReDim WorldBG(1)
NumBG = 1
ReDim WorldSwitch(1)
NumSwitch = 1
ReDim WorldItems(1)
NumItems = 1
LoadSound "Select-1", NONE
LoadSound "Door-1", NONE
LoadSound "OK", NONE
LoadSound "Cancel", NONE
LoadSound "Menu", NONE
LoadSound "Select-Item", NONE
LoadBGMusic "Title", Me, "LOOP"
LoadBGMusic "Op", Me, NONE
PlayBGMusic "Title"
Me.Width = 12000
Me.Height = 9000
LoadedAll = False
ReDim WorldTask(1)
NumTask = 1
LoadTask
End Sub

Private Sub img1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
OnButton = False
cmdNew.Picture = cmd1.Picture
cmdLoad.Picture = cmd2.Picture
cmdOpt.Picture = cmd3.Picture
cmdExit.Picture = cmd4.Picture
cmdHelp.Picture = cmd5.Picture
End Sub
