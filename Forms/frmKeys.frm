VERSION 5.00
Begin VB.Form frmKeys 
   BorderStyle     =   0  'None
   Caption         =   "Game Keys"
   ClientHeight    =   8250
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6015
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   8250
   ScaleWidth      =   6015
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   13
      ItemData        =   "frmKeys.frx":0000
      Left            =   2565
      List            =   "frmKeys.frx":000D
      Style           =   2  'Dropdown List
      TabIndex        =   35
      Top             =   2880
      Width           =   1905
   End
   Begin VB.CommandButton cmdDefault 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   270
      Picture         =   "frmKeys.frx":002C
      Style           =   1  'Graphical
      TabIndex        =   34
      TabStop         =   0   'False
      Top             =   5310
      Width           =   3045
   End
   Begin VB.CommandButton cmd3 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   3870
      Picture         =   "frmKeys.frx":7008
      Style           =   1  'Graphical
      TabIndex        =   33
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd3_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   3870
      Picture         =   "frmKeys.frx":DFE4
      Style           =   1  'Graphical
      TabIndex        =   32
      TabStop         =   0   'False
      Top             =   135
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmdOK 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   2565
      Picture         =   "frmKeys.frx":14F7C
      Style           =   1  'Graphical
      TabIndex        =   31
      TabStop         =   0   'False
      Top             =   7290
      Width           =   1425
   End
   Begin VB.CommandButton cmdCancel 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   4320
      Picture         =   "frmKeys.frx":1A226
      Style           =   1  'Graphical
      TabIndex        =   30
      TabStop         =   0   'False
      Top             =   7290
      Width           =   1425
   End
   Begin VB.CommandButton cmd1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5895
      Picture         =   "frmKeys.frx":1F537
      Style           =   1  'Graphical
      TabIndex        =   29
      TabStop         =   0   'False
      Top             =   8100
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd2 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   6435
      Picture         =   "frmKeys.frx":247E1
      Style           =   1  'Graphical
      TabIndex        =   28
      TabStop         =   0   'False
      Top             =   6570
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd1_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5760
      Picture         =   "frmKeys.frx":29AF2
      Style           =   1  'Graphical
      TabIndex        =   27
      TabStop         =   0   'False
      Top             =   8100
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd2_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   6435
      Picture         =   "frmKeys.frx":2ED72
      Style           =   1  'Graphical
      TabIndex        =   26
      TabStop         =   0   'False
      Top             =   6750
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   12
      ItemData        =   "frmKeys.frx":34077
      Left            =   3240
      List            =   "frmKeys.frx":34084
      Locked          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   24
      Top             =   4950
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   11
      ItemData        =   "frmKeys.frx":340A3
      Left            =   3240
      List            =   "frmKeys.frx":340B0
      Style           =   2  'Dropdown List
      TabIndex        =   23
      Top             =   4635
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   10
      ItemData        =   "frmKeys.frx":340CF
      Left            =   3240
      List            =   "frmKeys.frx":340DC
      Style           =   2  'Dropdown List
      TabIndex        =   22
      Top             =   4320
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   9
      ItemData        =   "frmKeys.frx":340FB
      Left            =   3240
      List            =   "frmKeys.frx":34108
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   4005
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   8
      ItemData        =   "frmKeys.frx":34127
      Left            =   3240
      List            =   "frmKeys.frx":34134
      Style           =   2  'Dropdown List
      TabIndex        =   20
      Top             =   3690
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   7
      ItemData        =   "frmKeys.frx":34153
      Left            =   3240
      List            =   "frmKeys.frx":34160
      Style           =   2  'Dropdown List
      TabIndex        =   19
      Top             =   3375
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   6
      ItemData        =   "frmKeys.frx":3417F
      Left            =   2565
      List            =   "frmKeys.frx":3418C
      Locked          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   18
      Top             =   2565
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   5
      ItemData        =   "frmKeys.frx":341AB
      Left            =   2565
      List            =   "frmKeys.frx":341B8
      Style           =   2  'Dropdown List
      TabIndex        =   17
      Top             =   2250
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   4
      ItemData        =   "frmKeys.frx":341D7
      Left            =   2565
      List            =   "frmKeys.frx":341E4
      Style           =   2  'Dropdown List
      TabIndex        =   16
      Top             =   1935
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   3
      ItemData        =   "frmKeys.frx":34203
      Left            =   2565
      List            =   "frmKeys.frx":34210
      Style           =   2  'Dropdown List
      TabIndex        =   15
      Top             =   1620
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   2
      ItemData        =   "frmKeys.frx":3422F
      Left            =   2565
      List            =   "frmKeys.frx":3423C
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   1305
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   1
      ItemData        =   "frmKeys.frx":3425B
      Left            =   2565
      List            =   "frmKeys.frx":34268
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   990
      Width           =   1905
   End
   Begin VB.ComboBox lstKeys 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   0
      ItemData        =   "frmKeys.frx":34287
      Left            =   2565
      List            =   "frmKeys.frx":34294
      Style           =   2  'Dropdown List
      TabIndex        =   12
      Top             =   675
      Width           =   1905
   End
   Begin VB.Label Label20 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Show Task:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   42
      Top             =   6660
      Width           =   1530
   End
   Begin VB.Label Label19 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tab"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   270
      Left            =   3240
      TabIndex        =   41
      Top             =   6660
      Width           =   510
   End
   Begin VB.Label Label18 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Shift+F1 To F12"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   270
      Left            =   3240
      TabIndex        =   40
      Top             =   6345
      Width           =   2085
   End
   Begin VB.Label Label17 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Save Game:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   39
      Top             =   6345
      Width           =   1575
   End
   Begin VB.Label Label16 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "F1 To F12"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   270
      Left            =   3240
      TabIndex        =   38
      Top             =   6030
      Width           =   1290
   End
   Begin VB.Label Label15 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Load Game:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   37
      Top             =   6030
      Width           =   1575
   End
   Begin VB.Label Label14 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Look:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   36
      Top             =   2925
      Width           =   720
   End
   Begin VB.Label Label13 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cancel/Exit:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   25
      Top             =   4995
      Width           =   1620
   End
   Begin VB.Label Label12 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lock/Unlock Camera:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   11
      Top             =   4680
      Width           =   2835
   End
   Begin VB.Label Label11 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Move Camera Down:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   10
      Top             =   4365
      Width           =   2745
   End
   Begin VB.Label Label10 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Move Camera Up:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   9
      Top             =   4050
      Width           =   2340
   End
   Begin VB.Label Label9 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rotate Camera Right:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   8
      Top             =   3735
      Width           =   2865
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rotate Camera Left:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   315
      TabIndex        =   7
      Top             =   3420
      Width           =   2700
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Interact:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   6
      Top             =   2610
      Width           =   1170
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Duck:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   5
      Top             =   2295
      Width           =   735
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Walk/Run:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   4
      Top             =   1980
      Width           =   1425
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rotate Right:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   3
      Top             =   1665
      Width           =   1755
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rotate Left:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   2
      Top             =   1350
      Width           =   1590
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Walk BackWard:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   1
      Top             =   1035
      Width           =   2160
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Walk Forward:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   270
      TabIndex        =   0
      Top             =   720
      Width           =   1935
   End
   Begin VB.Image img1 
      Height          =   8250
      Left            =   0
      Picture         =   "frmKeys.frx":342B3
      Top             =   0
      Width           =   6000
   End
End
Attribute VB_Name = "frmKeys"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Option Compare Text

Dim OnButton As Boolean

Private Sub PopulateList()
Dim i As Integer, j As Integer, k As Integer
k = 1
For i = lstKeys.LBound To lstKeys.UBound
  lstKeys(i).Clear
  For j = 1 To 37
    lstKeys(i).AddItem WorldKey(j).Key
  Next
          Select Case k
            Case 1
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.WalkForward))
            Case 2
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.WalkBackward))
            Case 3
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.RotateLeft))
            Case 4
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.RotateRight))
            Case 5
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.Walk_Run))
            Case 6
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.Dock))
            Case 7
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.Interact))
            Case 8
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.RotateCamLeft))
            Case 9
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.RotateCamRight))
            Case 10
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.MoveCamUp))
            Case 11
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.MoveCamDown))
            Case 12
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.LockCam))
            Case 13
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.Cancel))
            Case 14
              lstKeys(i).ListIndex = GetKeyINX(KeyName(WorldControl.Look))
          End Select
          k = k + 1
  Next
End Sub
Private Sub DefaultKeys()
Dim i As Integer, numList As Integer
Dim j As Integer
For i = 0 To lstKeys.UBound
  Select Case i
    Case 0
      lstKeys(i).ListIndex = GetKeyINX("W")
      WorldControl.WalkForward = GetKeyCode("W")
    Case 1
      lstKeys(i).ListIndex = GetKeyINX("S")
      WorldControl.WalkBackward = GetKeyCode("S")
    Case 2
      lstKeys(i).ListIndex = GetKeyINX("A")
      WorldControl.RotateLeft = GetKeyCode("A")
    Case 3
      lstKeys(i).ListIndex = GetKeyINX("D")
      WorldControl.RotateRight = GetKeyCode("D")
    Case 4
      lstKeys(i).ListIndex = GetKeyINX("C")
      WorldControl.Walk_Run = GetKeyCode("C")
    Case 5
      lstKeys(i).ListIndex = GetKeyINX("SPACE")
      WorldControl.Dock = GetKeyCode("SPACE")
    Case 6
      lstKeys(i).ListIndex = GetKeyINX("ENTER")
      WorldControl.Interact = GetKeyCode("ENTER")
    Case 7
      lstKeys(i).ListIndex = GetKeyINX("LEFT ARROW")
      WorldControl.RotateCamLeft = GetKeyCode("LEFT ARROW")
    Case 8
      lstKeys(i).ListIndex = GetKeyINX("RIGHT ARROW")
      WorldControl.RotateCamRight = GetKeyCode("RIGHT ARROW")
    Case 9
      lstKeys(i).ListIndex = GetKeyINX("UP ARROW")
      WorldControl.MoveCamUp = GetKeyCode("UP ARROW")
    Case 10
      lstKeys(i).ListIndex = GetKeyINX("DOWN ARROW")
      WorldControl.MoveCamDown = GetKeyCode("DOWN ARROW")
    Case 11
      lstKeys(i).ListIndex = GetKeyINX("Q")
      WorldControl.LockCam = GetKeyCode("Q")
    Case 12
      lstKeys(i).ListIndex = GetKeyINX("ESCAPE")
      WorldControl.Cancel = GetKeyCode("ESCAPE")
    Case 13
      lstKeys(i).ListIndex = GetKeyINX("E")
      WorldControl.Look = GetKeyCode("E")
  End Select
Next
End Sub

Private Sub SaveKeys()
Dim i As Integer, numList As Integer
Dim j As Integer
For i = 0 To lstKeys.UBound
  Select Case i
    Case 0
      WorldControl.WalkForward = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 1
      WorldControl.WalkBackward = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 2
      WorldControl.RotateLeft = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 3
      WorldControl.RotateRight = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 4
      WorldControl.Walk_Run = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 5
      WorldControl.Dock = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 6
      WorldControl.Interact = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 7
      WorldControl.RotateCamLeft = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 8
      WorldControl.RotateCamRight = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 9
      WorldControl.MoveCamUp = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 10
      WorldControl.MoveCamDown = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 11
      WorldControl.LockCam = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 12
      WorldControl.Cancel = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
    Case 13
      WorldControl.Look = GetKeyCode(lstKeys(i).List(lstKeys(i).ListIndex))
  End Select
Next

End Sub


Private Function GetKeyINX(Key As String) As Integer
Dim i As Integer
For i = 1 To 37
  If WorldKey(i).Key = Key Then
    GetKeyINX = i - 1
    Exit Function
  End If
Next
End Function

Private Sub cmdCancel_Click()
  PlaySound "Cancel"
  Unload Me
End Sub

Private Sub cmdCancel_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdCancel.Picture = cmd2_1.Picture
End Sub

Private Sub cmdDefault_Click()
PlaySound "OK"
DefaultKeys
End Sub

Private Sub cmdOK_Click()
  PlaySound "OK"
  SaveKeys
  SaveKeyToFile
  Unload Me
End Sub

Private Sub cmdOK_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdOK.Picture = cmd1_1.Picture
End Sub

Private Sub cmdDefault_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdDefault.Picture = cmd3_1.Picture
End Sub

Private Sub Form_Load()
PopulateList
End Sub


Private Sub img1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
OnButton = False
cmdOK.Picture = cmd1.Picture
cmdCancel.Picture = cmd2.Picture
cmdDefault.Picture = cmd3.Picture
End Sub

