unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,STRUtils;

type
  TForm1 = class(TForm)
    TimeInterval: TMaskEdit;
    ComboBox1: TComboBox;
    KeyText: TEdit;
    MouseBTN: TComboBox;
    Fechar: TImage;
    Footer: TImage;
    Header: TImage;
    Maximizar: TImage;
    Minimizar: TImage;
    Timer1: TTimer;
    Start: TButton;
    MilliInterval: TLabel;
    Stop: TButton;
    KeyBTN: TComboBox;
    PremadeKey: TComboBox;
    Version: TLabel;
    Lang: TComboBox;
    AlwaysTop: TCheckBox;
    AutoClick: TRadioButton;
    AlwaysClicked: TRadioButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure KeyBTNChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure KeyTextClick(Sender: TObject);
    procedure AlwaysTopClick(Sender: TObject);
    procedure AutoClickClick(Sender: TObject);
  private
    { Private declarations }
    Key : Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//== Função da Versão do Aplicativo ============================================
Function VersaoExe: String;
type
   PFFI = ^vs_FixedFileInfo;
var
   F       : PFFI;
   Handle  : Dword;
   Len     : Longint;
   Data    : Pchar;
   Buffer  : Pointer;
   Tamanho : Dword;
   Parquivo: Pchar;
   Arquivo : String;
begin
   Arquivo  := Application.ExeName;
   Parquivo := StrAlloc(Length(Arquivo) + 1);
   StrPcopy(Parquivo, Arquivo);
   Len := GetFileVersionInfoSize(Parquivo, Handle);
   Result := '';
   if Len > 0 then
   begin
      Data:=StrAlloc(Len+1);
      if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
      begin
         VerQueryValue(Data, '',Buffer,Tamanho);
         F := PFFI(Buffer);
         Result := Format('%d.%d.%d.%d',
                          [HiWord(F^.dwFileVersionMs),
                           LoWord(F^.dwFileVersionMs),
                           HiWord(F^.dwFileVersionLs),
                           Loword(F^.dwFileVersionLs)]
                         );
      end;
      StrDispose(Data);
   end;
   StrDispose(Parquivo);
end;
//=== Selecionar Premade Key ===================================================
Procedure SelectPreKey;
begin
  if Form1.PremadeKey.ItemIndex=0 then Form1.Key := VK_LBUTTON;
  if Form1.PremadeKey.ItemIndex=1 then Form1.Key := VK_RBUTTON;
  if Form1.PremadeKey.ItemIndex=2 then Form1.Key := VK_CANCEL;
  if Form1.PremadeKey.ItemIndex=3 then Form1.Key := VK_MBUTTON;
  if Form1.PremadeKey.ItemIndex=4 then Form1.Key := VK_BACK;
  if Form1.PremadeKey.ItemIndex=5 then Form1.Key := VK_TAB;
  if Form1.PremadeKey.ItemIndex=6 then Form1.Key := VK_CLEAR;
  if Form1.PremadeKey.ItemIndex=7 then Form1.Key := VK_RETURN;
  if Form1.PremadeKey.ItemIndex=8 then Form1.Key := VK_SHIFT;
  if Form1.PremadeKey.ItemIndex=9 then Form1.Key := VK_CONTROL;
  if Form1.PremadeKey.ItemIndex=10 then Form1.Key := VK_MENU;
  if Form1.PremadeKey.ItemIndex=11 then Form1.Key := VK_PAUSE;
  if Form1.PremadeKey.ItemIndex=12 then Form1.Key := VK_CAPITAL;
  if Form1.PremadeKey.ItemIndex=13 then Form1.Key := VK_KANA;
  if Form1.PremadeKey.ItemIndex=14 then Form1.Key := VK_HANGUL;
  if Form1.PremadeKey.ItemIndex=15 then Form1.Key := VK_JUNJA;
  if Form1.PremadeKey.ItemIndex=16 then Form1.Key := VK_FINAL;
  if Form1.PremadeKey.ItemIndex=17 then Form1.Key := VK_HANJA;
  if Form1.PremadeKey.ItemIndex=18 then Form1.Key := VK_KANJI;
  if Form1.PremadeKey.ItemIndex=19 then Form1.Key := VK_CONVERT;
  if Form1.PremadeKey.ItemIndex=20 then Form1.Key := VK_NONCONVERT;
  if Form1.PremadeKey.ItemIndex=21 then Form1.Key := VK_ACCEPT;
  if Form1.PremadeKey.ItemIndex=22 then Form1.Key := VK_MODECHANGE;
  if Form1.PremadeKey.ItemIndex=23 then Form1.Key := VK_ESCAPE;
  if Form1.PremadeKey.ItemIndex=24 then Form1.Key := VK_SPACE;
  if Form1.PremadeKey.ItemIndex=25 then Form1.Key := VK_PRIOR;
  if Form1.PremadeKey.ItemIndex=26 then Form1.Key := VK_NEXT;
  if Form1.PremadeKey.ItemIndex=27 then Form1.Key := VK_END;
  if Form1.PremadeKey.ItemIndex=28 then Form1.Key := VK_HOME;
  if Form1.PremadeKey.ItemIndex=29 then Form1.Key := VK_LEFT;
  if Form1.PremadeKey.ItemIndex=30 then Form1.Key := VK_UP;
  if Form1.PremadeKey.ItemIndex=31 then Form1.Key := VK_RIGHT;
  if Form1.PremadeKey.ItemIndex=32 then Form1.Key := VK_DOWN;
  if Form1.PremadeKey.ItemIndex=33 then Form1.Key := VK_SELECT;
  if Form1.PremadeKey.ItemIndex=34 then Form1.Key := VK_PRINT;
  if Form1.PremadeKey.ItemIndex=35 then Form1.Key := VK_EXECUTE;
  if Form1.PremadeKey.ItemIndex=36 then Form1.Key := VK_SNAPSHOT;
  if Form1.PremadeKey.ItemIndex=37 then Form1.Key := VK_INSERT;
  if Form1.PremadeKey.ItemIndex=38 then Form1.Key := VK_DELETE;
  if Form1.PremadeKey.ItemIndex=39 then Form1.Key := VK_HELP;
  if Form1.PremadeKey.ItemIndex=40 then Form1.Key := VK_LWIN;
  if Form1.PremadeKey.ItemIndex=41 then Form1.Key := VK_RWIN;
  if Form1.PremadeKey.ItemIndex=42 then Form1.Key := VK_APPS;
  if Form1.PremadeKey.ItemIndex=43 then Form1.Key := VK_NUMPAD0;
  if Form1.PremadeKey.ItemIndex=44 then Form1.Key := VK_NUMPAD1;
  if Form1.PremadeKey.ItemIndex=45 then Form1.Key := VK_NUMPAD2;
  if Form1.PremadeKey.ItemIndex=46 then Form1.Key := VK_NUMPAD3;
  if Form1.PremadeKey.ItemIndex=47 then Form1.Key := VK_NUMPAD4;
  if Form1.PremadeKey.ItemIndex=48 then Form1.Key := VK_NUMPAD5;
  if Form1.PremadeKey.ItemIndex=49 then Form1.Key := VK_NUMPAD6;
  if Form1.PremadeKey.ItemIndex=50 then Form1.Key := VK_NUMPAD7;
  if Form1.PremadeKey.ItemIndex=51 then Form1.Key := VK_NUMPAD8;
  if Form1.PremadeKey.ItemIndex=52 then Form1.Key := VK_NUMPAD9;
  if Form1.PremadeKey.ItemIndex=53 then Form1.Key := VK_MULTIPLY;
  if Form1.PremadeKey.ItemIndex=54 then Form1.Key := VK_ADD;
  if Form1.PremadeKey.ItemIndex=55 then Form1.Key := VK_SEPARATOR;
  if Form1.PremadeKey.ItemIndex=56 then Form1.Key := VK_SUBTRACT;
  if Form1.PremadeKey.ItemIndex=57 then Form1.Key := VK_DECIMAL;
  if Form1.PremadeKey.ItemIndex=58 then Form1.Key := VK_DIVIDE;
  if Form1.PremadeKey.ItemIndex=59 then Form1.Key := VK_F1;
  if Form1.PremadeKey.ItemIndex=60 then Form1.Key := VK_F2;
  if Form1.PremadeKey.ItemIndex=61 then Form1.Key := VK_F3;
  if Form1.PremadeKey.ItemIndex=62 then Form1.Key := VK_F4;
  if Form1.PremadeKey.ItemIndex=63 then Form1.Key := VK_F5;
  if Form1.PremadeKey.ItemIndex=64 then Form1.Key := VK_F6;
  if Form1.PremadeKey.ItemIndex=65 then Form1.Key := VK_F7;
  if Form1.PremadeKey.ItemIndex=66 then Form1.Key := VK_F8;
  if Form1.PremadeKey.ItemIndex=67 then Form1.Key := VK_F9;
  if Form1.PremadeKey.ItemIndex=68 then Form1.Key := VK_F10;
  if Form1.PremadeKey.ItemIndex=69 then Form1.Key := VK_F11;
  if Form1.PremadeKey.ItemIndex=70 then Form1.Key := VK_F12;
  if Form1.PremadeKey.ItemIndex=71 then Form1.Key := VK_F13;
  if Form1.PremadeKey.ItemIndex=72 then Form1.Key := VK_F14;
  if Form1.PremadeKey.ItemIndex=73 then Form1.Key := VK_F15;
  if Form1.PremadeKey.ItemIndex=74 then Form1.Key := VK_F16;
  if Form1.PremadeKey.ItemIndex=75 then Form1.Key := VK_F17;
  if Form1.PremadeKey.ItemIndex=76 then Form1.Key := VK_F18;
  if Form1.PremadeKey.ItemIndex=77 then Form1.Key := VK_F19;
  if Form1.PremadeKey.ItemIndex=78 then Form1.Key := VK_F20;
  if Form1.PremadeKey.ItemIndex=79 then Form1.Key := VK_F21;
  if Form1.PremadeKey.ItemIndex=80 then Form1.Key := VK_F22;
  if Form1.PremadeKey.ItemIndex=81 then Form1.Key := VK_F23;
  if Form1.PremadeKey.ItemIndex=82 then Form1.Key := VK_F24;
  if Form1.PremadeKey.ItemIndex=83 then Form1.Key := VK_NUMLOCK;
  if Form1.PremadeKey.ItemIndex=84 then Form1.Key := VK_SCROLL;
  if Form1.PremadeKey.ItemIndex=85 then Form1.Key := VK_LSHIFT;
  if Form1.PremadeKey.ItemIndex=86 then Form1.Key := VK_RSHIFT;
  if Form1.PremadeKey.ItemIndex=87 then Form1.Key := VK_LCONTROL;
  if Form1.PremadeKey.ItemIndex=88 then Form1.Key := VK_RCONTROL;
  if Form1.PremadeKey.ItemIndex=89 then Form1.Key := VK_LMENU;
  if Form1.PremadeKey.ItemIndex=90 then Form1.Key := VK_RMENU;
  if Form1.PremadeKey.ItemIndex=91 then Form1.Key := VK_PROCESSKEY;
  if Form1.PremadeKey.ItemIndex=92 then Form1.Key := VK_ATTN;
  if Form1.PremadeKey.ItemIndex=93 then Form1.Key := VK_CRSEL;
  if Form1.PremadeKey.ItemIndex=94 then Form1.Key := VK_EXSEL;
  if Form1.PremadeKey.ItemIndex=95 then Form1.Key := VK_EREOF;
  if Form1.PremadeKey.ItemIndex=96 then Form1.Key := VK_PLAY;
  if Form1.PremadeKey.ItemIndex=97 then Form1.Key := VK_ZOOM;
  if Form1.PremadeKey.ItemIndex=98 then Form1.Key := VK_NONAME;
  if Form1.PremadeKey.ItemIndex=99 then Form1.Key := VK_PA1;
  if Form1.PremadeKey.ItemIndex=100 then Form1.Key := VK_OEM_CLEAR;
end;
//==============================================================================

//=== Converter o "Time" em Mileseconds ========================================
Function GetTimeInMilliSeconds(theTime : TTime): Int64;
var Hour, Min, Sec, MSec: Word;
begin
DecodeTime(theTime,Hour, Min, Sec, MSec);
Result := (Hour * 3600000) + (Min * 60000) + (Sec * 1000) + MSec;
end;
//==============================================================================

//=== Botão Start ==============================================================
procedure TForm1.StartClick(Sender: TObject);
var Time1:TTime;
    Time2:String;
begin
//Inicio do Timer e Visuais
Start.Enabled:=False;
Stop.Enabled:=True;
ComboBox1.Enabled:=False;
KeyBTN.Enabled:=False;
KeyText.Enabled:=False;
MouseBTN.Enabled:=False;
PremadeKey.Enabled:=False;
TimeInterval.Enabled:=False;
SelectPreKey;

  if AutoClick.Checked then begin
    Time1:=StrToTime(copy(TimeInterval.Text,0,8));
    Time2:=copy(TimeInterval.Text,10,12);
    Timer1.Interval:= GetTimeInMilliSeconds(Time1)+StrToInt(Time2);
    MilliInterval.Caption := IntToStr(Timer1.Interval)+' Milliseconds';
    Timer1.Enabled:=True;
  end else begin
    Keybd_event(Key,0,0,0);
  end;

end;
//=== Botão Stop ===============================================================
procedure TForm1.StopClick(Sender: TObject);
begin
//Final do Timer e Visuais
Timer1.Enabled:=False;
Start.Enabled:=True;
Stop.Enabled:=False;
KeyText.Enabled:=True;
MouseBTN.Enabled:=True;
PremadeKey.Enabled:=True;

  if AutoClick.Checked then begin
    ComboBox1.Enabled := True;
    KeyBTN.Enabled := True;
    TimeInterval.Enabled := True;
  end else begin
    keybd_event(Key,0,KEYEVENTF_KEYUP,0);
  end;
end;
//=== Sempre no topo ===========================================================
procedure TForm1.AlwaysTopClick(Sender: TObject);
begin
  if AlwaysTop.Checked then begin
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NoMove or SWP_NoSize);
  end else begin
    SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NoMove or SWP_NoSize);
  end;
end;
//=== Mudança de modo ==========================================================
procedure TForm1.AutoClickClick(Sender: TObject);
begin
  if AutoClick.Checked then begin
    ComboBox1.Enabled := True;
    KeyBTN.Enabled := True;
    TimeInterval.Enabled := True;
    MilliInterval.Enabled := True;
  end else begin
    ComboBox1.ItemIndex := 1;
    ComboBox1.OnChange(Self);
    ComboBox1.Enabled := False;
    KeyBTN.ItemIndex    := 1;
    KeyBTN.OnChange(Self);
    KeyBTN.Enabled := False;
    TimeInterval.Enabled := False;
    MilliInterval.Enabled := False;
  end;
end;
//=== Troca entre Teclado e Mouse ==============================================
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
if Combobox1.ItemIndex=1 then
  begin
    KeyText.Visible:=True;
    KeyBTN.Visible:=True;
    KeyBTN.ItemIndex := 0;
    MouseBTN.Visible:=False;
    PremadeKey.Visible:=False;
  end;
if Combobox1.ItemIndex=0 then
  begin
    KeyText.Visible:=False;
    KeyBTN.Visible:=False;
    MouseBTN.Visible:=True;
    PremadeKey.Visible:=False;
  end;
end;
//=== Criação do Form ==========================================================
procedure TForm1.FormCreate(Sender: TObject);
begin
//Sempre no topo
AlwaysTop.OnClick(Self);
//modos
AlwaysClicked.OnClick := AutoClick.OnClick;
//Versão do Aplicativo
Version.Caption:='[ '+VersaoExe+' ]';;
end;
//=== Trocar entre custom e premade ============================================
procedure TForm1.KeyBTNChange(Sender: TObject);
begin
//KeyText On
if KeyBTN.ItemIndex = 0 then
  begin
    PremadeKey.Visible:=False;
    KeyText.Visible:=True;
  end;
//PremadeKey On
if KeyBTN.ItemIndex = 1 then
  begin
    PremadeKey.Visible:=True;
    KeyText.Visible:=False;
  end;
end;
procedure TForm1.KeyTextClick(Sender: TObject);
begin
KeyText.SelectAll;
end;

//=== Timer funcionando ========================================================
procedure TForm1.Timer1Timer(Sender: TObject);
var iPos: Integer;
begin
//Mouse
if Combobox1.ItemIndex=0 then
  begin
    //Botão Esquerdo (Left) do Mouse
    if MouseBTN.ItemIndex=0 then
      begin
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      end;
    //Botão Direito (Right) do Mouse
    if MouseBTN.ItemIndex=1 then
      begin
        mouse_event(MOUSEEVENTF_RIGHTDOWN,0,0,0,0);
        mouse_event(MOUSEEVENTF_RIGHTUP,0,0,0,0);
      end;
  end;
//Teclado (Keyboard)
if Combobox1.ItemIndex=1 then
  begin
    //Custom Key
    if KeyBTN.ItemIndex=0 then
      begin
        keybd_event(Ord(KeyText.Text[1]),0,0,0);
        keybd_event(Ord(KeyText.Text[1]),0,KEYEVENTF_KEYUP,0);
      end;
    //Premade Key
    if KeyBTN.ItemIndex=1 then
      begin
        keybd_event(Key,0,0,0);
        keybd_event(Key,0,KEYEVENTF_KEYUP,0);
      end;
  end;
end;
//==============================================================================
end.
