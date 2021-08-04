VERSION 5.00
Begin VB.Form frmLoad 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Load Game"
   ClientHeight    =   6330
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9015
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   6330
   ScaleWidth      =   9015
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdScene 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   5805
      Picture         =   "frmLoad.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   5265
      Width           =   3045
   End
   Begin VB.ListBox lstScene 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2160
      Left            =   270
      TabIndex        =   9
      Top             =   3690
      Width           =   4785
   End
   Begin VB.CommandButton cmdCancel 
      BackColor       =   &H00404040&
      Height          =   555
      Left            =   7380
      Picture         =   "frmLoad.frx":7157
      Style           =   1  'Graphical
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   2295
      Width           =   1425
   End
   Begin VB.CommandButton cmd3 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   4815
      Picture         =   "frmLoad.frx":C468
      Style           =   1  'Graphical
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   -90
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd3_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5355
      Picture         =   "frmLoad.frx":11779
      Style           =   1  'Graphical
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   -45
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmdLoad 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   4275
      Picture         =   "frmLoad.frx":16A7E
      Style           =   1  'Graphical
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   2295
      Width           =   3045
   End
   Begin VB.CommandButton cmd2 
      BackColor       =   &H00404040&
      Height          =   735
      Left            =   1980
      Picture         =   "frmLoad.frx":1DBD5
      Style           =   1  'Graphical
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   -225
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.CommandButton cmd2_1 
      BackColor       =   &H00404040&
      Height          =   560
      Left            =   225
      Picture         =   "frmLoad.frx":24D2C
      Style           =   1  'Graphical
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   -90
      Visible         =   0   'False
      Width           =   3045
   End
   Begin VB.ListBox lstLoad 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1560
      Left            =   225
      TabIndex        =   1
      Top             =   630
      Width           =   8565
   End
   Begin VB.FileListBox lstFile 
      Height          =   1065
      Hidden          =   -1  'True
      Left            =   5130
      Pattern         =   "*.txt"
      System          =   -1  'True
      TabIndex        =   0
      Top             =   -585
      Visible         =   0   'False
      Width           =   2715
   End
   Begin VB.Image picView 
      Height          =   1985
      Left            =   6525
      Stretch         =   -1  'True
      Top             =   3105
      Width           =   2040
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Press X To Delete Saved Game"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   225
      TabIndex        =   8
      Top             =   2205
      Width           =   3075
   End
   Begin VB.Image img1 
      Height          =   6300
      Left            =   0
      Picture         =   "frmLoad.frx":2BE19
      Top             =   0
      Width           =   9000
   End
End
Attribute VB_Name = "frmLoad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OnButton As Boolean, Scenes() As String, SIndex() As Integer

Private Sub cmdCancel_Click()
  PlaySound "cancel"
  Unload Me
End Sub

Private Sub cmdCancel_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdCancel.Picture = cmd3_1.Picture
End Sub

Private Sub cmdLoad_Click()
Dim tmpLoad As String
If lstLoad.ListIndex >= 0 Then
  PlayBGMusic "Op"
  Call WorldBG(1).v_dmp.Stop(WorldBG(1).v_dms, WorldBG(1).v_dmss, 0, 0)
  Call WorldBG(1).v_dms.Unload(WorldBG(1).v_dmp)
  Wait 3000
  Call WorldBG(2).v_dmp.Stop(WorldBG(1).v_dms, WorldBG(1).v_dmss, 0, 0)
  Call WorldBG(2).v_dms.Unload(WorldBG(1).v_dmp)
  tmpLoad = FTextSave(lstLoad.List(lstLoad.ListIndex))
  LoadThisMap = tmpLoad
  LoadingGame = True
  CurName = GetUserName(tmpLoad)
  Unload Me
  frmMain.Show 1
End If
End Sub

Private Sub cmdLoad_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdLoad.Picture = cmd2_1.Picture
End Sub

Private Sub cmdScene_Click()
Dim tmpLoad As String
If lstScene.ListIndex >= 0 Then
  PlayBGMusic "Op"
  Call WorldBG(1).v_dmp.Stop(WorldBG(1).v_dms, WorldBG(1).v_dmss, 0, 0)
  Call WorldBG(1).v_dms.Unload(WorldBG(1).v_dmp)
  Wait 3000
  Call WorldBG(2).v_dmp.Stop(WorldBG(1).v_dms, WorldBG(1).v_dmss, 0, 0)
  Call WorldBG(2).v_dms.Unload(WorldBG(1).v_dmp)
  tmpLoad = GetSceneName(lstScene.ListIndex)
  LoadThisMap = Left(tmpLoad, Len(tmpLoad) - 4)
  LoadingGame = True
  CurName = GetUserName(tmpLoad)
  Unload Me
  frmMain.Show 1
End If
End Sub

Private Sub cmdScene_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdScene.Picture = cmd2_1.Picture
End Sub

Private Sub Form_Load()
lstFile.Path = App.Path & "\Saves\"
Populate
End Sub

Private Sub Populate()
  Dim i As Integer, j As Integer
  lstLoad.Clear
  For i = 0 To lstFile.ListCount - 1
    If Left(lstFile.List(i), 1) = "(" Then
      lstLoad.AddItem Left(FTextLoad(lstFile.List(i)), Len(FTextLoad(lstFile.List(i))) - 4)
    End If
  Next
  
  lstScene.Clear
  For i = 0 To lstFile.ListCount - 1
    If Left(lstFile.List(i), 1) = "[" Then
      ReDim Preserve Scenes(j)
      ReDim Preserve SIndex(j)
      Scenes(j) = lstFile.List(i)
      SIndex(j) = i
      j = j + 1
      lstScene.AddItem GetInside(lstFile.List(i), "[", "]")
    End If
  Next
End Sub

Private Sub img1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
OnButton = False
cmdLoad.Picture = cmd2.Picture
cmdScene.Picture = cmd2.Picture
cmdCancel.Picture = cmd3.Picture
End Sub

Private Sub lstLoad_Click()
If lstLoad.ListIndex >= 0 Then
  lstScene.ListIndex = -1
  picView.Picture = LoadPicture
End If
End Sub

Private Sub lstLoad_KeyPress(KeyAscii As Integer)
If KeyAscii = 120 Then
  If lstLoad.ListIndex >= 0 Then
    If MsgBox("Are You Sure You Want To Delete This Saved Game?", vbYesNo, "Delete Saved Game") = vbYes Then
      Kill App.Path & "/Saves/" & FTextSave(lstLoad.List(lstLoad.ListIndex)) & ".txt"
      lstFile.Refresh
      lstLoad.Refresh
      Populate
    End If
  End If
End If
End Sub

Public Function GetInside(x As String, OpenDel As String, CloseDel As String)
Dim i As Integer, tmp As String, L As String, StartCopy As Boolean
For i = 1 To Len(x)
  L = Mid(x, i, 1)
  If L = OpenDel Then StartCopy = True
  If L <> CloseDel And L <> OpenDel And StartCopy = True Then
    tmp = tmp & L
  ElseIf L = CloseDel Then
    GetInside = Trim(tmp)
    Exit Function
  End If
Next
GetInside = Trim(tmp)
Exit Function
End Function

Public Function GetSceneName(SNum As Integer) As String
GetSceneName = Scenes(SNum)
End Function

Private Sub lstScene_Click()
If lstScene.ListIndex > -1 Then
  lstLoad.ListIndex = -1
  picView.Picture = LoadPicture(App.Path & "\" & lstScene.List(lstScene.ListIndex) & ".jpg")
End If
End Sub
