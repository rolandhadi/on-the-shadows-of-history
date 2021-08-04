VERSION 5.00
Begin VB.Form frmName 
   BorderStyle     =   0  'None
   Caption         =   "New Game"
   ClientHeight    =   2265
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4515
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   2265
   ScaleWidth      =   4515
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd2_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   3780
      Picture         =   "frmName.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   765
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd1_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   2205
      Picture         =   "frmName.frx":5305
      Style           =   1  'Graphical
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   765
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd2 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   3780
      Picture         =   "frmName.frx":A585
      Style           =   1  'Graphical
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   585
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   2205
      Picture         =   "frmName.frx":F896
      Style           =   1  'Graphical
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   585
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.TextBox txtName 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   225
      MaxLength       =   10
      TabIndex        =   2
      Text            =   "Rozs"
      Top             =   720
      Width           =   4020
   End
   Begin VB.CommandButton cmdCancel 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   2880
      Picture         =   "frmName.frx":14B40
      Style           =   1  'Graphical
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   1440
      Width           =   1425
   End
   Begin VB.CommandButton cmdOK 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   1125
      Picture         =   "frmName.frx":19E51
      Style           =   1  'Graphical
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   1440
      Width           =   1425
   End
   Begin VB.Image img1 
      Height          =   2250
      Left            =   0
      Picture         =   "frmName.frx":1F0FB
      Top             =   0
      Width           =   4500
   End
End
Attribute VB_Name = "frmName"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OnButton As Boolean

Private Sub Command1_Click()

End Sub

Private Sub cmdCancel_Click()
PlaySound "Cancel"
Unload Me
End Sub

Private Sub cmdCancel_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdCancel.Picture = cmd2_1.Picture
End Sub

Private Sub cmdOK_Click()
PlayBGMusic "Op"
Call WorldBG(1).v_dmp.Stop(WorldBG(1).v_dms, WorldBG(1).v_dmss, 0, 0)
Call WorldBG(1).v_dms.Unload(WorldBG(1).v_dmp)
Wait 3000
  Call WorldBG(2).v_dmp.Stop(WorldBG(1).v_dms, WorldBG(1).v_dmss, 0, 0)
  Call WorldBG(2).v_dms.Unload(WorldBG(1).v_dmp)
If txtName.Text = "" Then CurName = "Rozs" Else CurName = txtName.Text
LoadThisMap = "IntroLuneta"
Unload frmKeys
Unload frmLoad
Unload frmName
Unload frmOpt
Unload frmStart
'GameTime = 60 * 60
'GameTime = GameTime * 24
GameTime = 0
Unload Me
frmMain.Show 1
End Sub

Private Sub cmdOK_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdOK.Picture = cmd1_1.Picture
End Sub

Private Sub Form_Load()
txtName.SelStart = 0
txtName.SelLength = Len(txtName.Text)
End Sub

Private Sub img1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
OnButton = False
cmdOK.Picture = cmd1.Picture
cmdCancel.Picture = cmd2.Picture
End Sub

