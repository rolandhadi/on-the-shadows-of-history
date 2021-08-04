VERSION 5.00
Begin VB.Form frmHelp 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   3840
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7215
   LinkTopic       =   "Form1"
   Picture         =   "frmHelp.frx":0000
   ScaleHeight     =   3840
   ScaleWidth      =   7215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdOK 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   5490
      Picture         =   "frmHelp.frx":21536
      Style           =   1  'Graphical
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   3060
      Width           =   1425
   End
   Begin VB.CommandButton cmd1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   1080
      Picture         =   "frmHelp.frx":267E0
      Style           =   1  'Graphical
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   0
      Visible         =   0   'False
      Width           =   1425
   End
   Begin VB.CommandButton cmd1_1 
      BackColor       =   &H00404040&
      Height          =   600
      Left            =   1080
      Picture         =   "frmHelp.frx":2BA8A
      Style           =   1  'Graphical
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   180
      Visible         =   0   'False
      Width           =   1425
   End
End
Attribute VB_Name = "frmHelp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OnButton As Boolean

Private Sub cmdOK_Click()
PlaySound "OK"
Unload Me
End Sub

Private Sub cmdOK_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
If OnButton = False Then PlaySound "Select-1": OnButton = True: cmdOK.Picture = cmd1_1.Picture
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
OnButton = False
cmdOK.Picture = cmd1.Picture
End Sub
