VERSION 5.00
Begin VB.Form frmOpt 
   BorderStyle     =   0  'None
   Caption         =   "Game Options"
   ClientHeight    =   3750
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6015
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   3750
   ScaleWidth      =   6015
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdKeys 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   270
      Picture         =   "frmOpt.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   2295
      Width           =   3045
   End
   Begin VB.CommandButton cmd3 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   5895
      Picture         =   "frmOpt.frx":7160
      Style           =   1  'Graphical
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd3_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   6030
      Picture         =   "frmOpt.frx":E2C0
      Style           =   1  'Graphical
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmdOK 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   2610
      Picture         =   "frmOpt.frx":153E8
      Style           =   1  'Graphical
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   2925
      Width           =   1425
   End
   Begin VB.CommandButton cmdCancel 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   4365
      Picture         =   "frmOpt.frx":1A692
      Style           =   1  'Graphical
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   2925
      Width           =   1425
   End
   Begin VB.CommandButton cmd1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5940
      Picture         =   "frmOpt.frx":1F9A3
      Style           =   1  'Graphical
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd2 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5895
      Picture         =   "frmOpt.frx":24C4D
      Style           =   1  'Graphical
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd1_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5805
      Picture         =   "frmOpt.frx":29F5E
      Style           =   1  'Graphical
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   90
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd2_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5850
      Picture         =   "frmOpt.frx":2F1DE
      Style           =   1  'Graphical
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   90
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.HScrollBar scrSE 
      Height          =   285
      LargeChange     =   500
      Left            =   270
      Max             =   0
      Min             =   -5000
      SmallChange     =   100
      TabIndex        =   5
      Top             =   1935
      Width           =   5550
   End
   Begin VB.HScrollBar scrBG 
      Height          =   285
      LargeChange     =   500
      Left            =   270
      Max             =   8000
      Min             =   -5000
      SmallChange     =   100
      TabIndex        =   3
      Top             =   1305
      Value           =   1200
      Width           =   5550
   End
   Begin VB.ComboBox lstLang 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      ItemData        =   "frmOpt.frx":344E3
      Left            =   3285
      List            =   "frmOpt.frx":344ED
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   585
      Width           =   2445
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "SE/Voice Over Volume"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   270
      TabIndex        =   4
      Top             =   1620
      Width           =   2910
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "BG Music Volume"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   270
      TabIndex        =   2
      Top             =   990
      Width           =   2250
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Sub-Title Language:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   270
      TabIndex        =   0
      Top             =   585
      Width           =   2640
   End
   Begin VB.Image img1 
      Height          =   3750
      Left            =   0
      Picture         =   "frmOpt.frx":34503
      Top             =   0
      Width           =   6000
   End
End
Attribute VB_Name = "frmOpt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OnButton As Boolean

Private Sub cmdCancel_Click()
Dim i As Integer
PlaySound "Cancel"
GetConfig
For i = LBound(WorldBG) To UBound(WorldBG)
  Call WorldBG(i).v_dmp.SetMasterVolume(CurBGVol)
Next
Unload Me
End Sub

Private Sub cmdCancel_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdCancel.Picture = cmd2_1.Picture
End Sub

Private Sub cmdKeys_Click()
PlaySound "Door-1"
frmKeys.Show 1
End Sub

Private Sub cmdOK_Click()
PlaySound "OK"
SaveConfig
Unload Me
End Sub

Private Sub cmdOK_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdOK.Picture = cmd1_1.Picture
End Sub

Private Sub cmdKeys_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdKeys.Picture = cmd3_1.Picture
End Sub

Private Sub Form_Load()
scrBG.Value = CurBGVol
scrSE.Value = CurSEVol
lstLang.ListIndex = CurLang
End Sub

Private Sub img1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
OnButton = False
cmdOK.Picture = cmd1.Picture
cmdCancel.Picture = cmd2.Picture
cmdKeys.Picture = cmd3.Picture
End Sub

Private Sub scrBG_Change()
Dim i As Integer
CurBGVol = scrBG.Value
For i = LBound(WorldBG) To UBound(WorldBG)
  Call WorldBG(i).v_dmp.SetMasterVolume(CurBGVol)
Next
End Sub

Private Sub scrSE_Change()
CurSEVol = scrSE.Value
End Sub
