unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, DockTabSet, StdCtrls, CheckLst, ExtCtrls, ComCtrls, Buttons,
  WideStrings, FMTBcd, DB, SqlExpr, uRep311, Data, Grids, DBGrids, Arhivator, CriptoMudule, Verba, krutilka;

type
  TUser = Object
   Login:String;
   ID:Integer;
   Dostup : record
    PO:Boolean;
    P311:Boolean;
    VerbaKa:Boolean;
    VerbaSign:Boolean;
    VerbaMail:Boolean;
    Arhiv:Boolean;
    Krutilka:Boolean;
    Hranilishe:Boolean;
   end;
   Procedure LoadLogin; {}
  End;
  TfmMain = class(TForm)
    PageControlMain: TPageControl;
    TabSheetVerba: TTabSheet;
    TabSheetKKrutilka: TTabSheet;
    TabSheet311P: TTabSheet;
    PageControl311P: TPageControl;
    TabSheetSform: TTabSheet;
    Panel1: TPanel;
    CheckListBox311Sform: TCheckListBox;
    Button311SformProverka: TButton;
    Button311Refresh: TButton;
    Memo311SformEdit: TMemo;
    CheckBox311SformirovAllCheck: TCheckBox;
    TabSheetInCa: TTabSheet;
    Panel2: TPanel;
    Button311InKaOut: TButton;
    CheckBox311InKACheckAll: TCheckBox;
    Button311InPodbRefresh: TButton;
    TabSheetInSign: TTabSheet;
    Panel3: TPanel;
    CheckListBox311InSign: TCheckListBox;
    Button311InCriptSend: TButton;
    CheckBox311InSignCheckAll: TCheckBox;
    Button311InSignRefresh: TButton;
    TabSheet311Arh: TTabSheet;
    Panel4: TPanel;
    CheckListBox311InArh: TCheckListBox;
    Button311InArhOut: TButton;
    CheckBox311InArhCheckAll: TCheckBox;
    Button311InArhRefresh: TButton;
    TabSheetArhiv: TTabSheet;
    TabSheetArhivator: TPageControl;
    TabSheetArhiv311PA: TTabSheet;
    Panel5: TPanel;
    CheckListBoxArhiv311: TCheckListBox;
    ButtonArh311ABild: TButton;
    ButtonArhiv311Refresh: TButton;
    CheckBoxArhiv311CheckAll: TCheckBox;
    Memo1: TMemo;
    TabSheetArhiv311PB: TTabSheet;
    Panel6: TPanel;
    CheckListBoxArhiv311B: TCheckListBox;
    ButtonArh311BBild: TButton;
    CheckBoxArhiv311CheckAllB: TCheckBox;
    ButtonArhiv311RefreshB: TButton;
    TabSheetArhMail: TTabSheet;
    Panel7: TPanel;
    CheckListBoxArhivMail: TCheckListBox;
    ButtonArhMailBild: TButton;
    CheckBoxArhMailCheckAll: TCheckBox;
    ButtonArhMailRefresh: TButton;
    TabSheet4: TTabSheet;
    Panel8: TPanel;
    CheckListBox4: TCheckListBox;
    Button10: TButton;
    CheckBox4: TCheckBox;
    Button11: TButton;
    ListBoxActivLog: TListBox;
    PageControlVerba: TPageControl;
    TabSheetVerba311: TTabSheet;
    Panel9: TPanel;
    CheckListBoxVerba311Sign: TCheckListBox;
    ButtonVerba311Sign: TButton;
    ButtonVerba311SignRefr: TButton;
    CheckBoxVerba311SignChAll: TCheckBox;
    Memo2: TMemo;
    TabSheet2: TTabSheet;
    Panel10: TPanel;
    CheckListBoxVerba311Cript: TCheckListBox;
    ButtonVerba311Cript: TButton;
    CheckBoxVerba311CriptChAll: TCheckBox;
    ButtonVerba311CrptRefr: TButton;
    TabSheetVerbaSignArh: TTabSheet;
    Panel11: TPanel;
    CheckListBoxVerbaMailSign: TCheckListBox;
    ButtonVerbaMailSign: TButton;
    CheckBoxVerbaMailSignChAll: TCheckBox;
    ButtonVerba311SignRefresh: TButton;
    TabSheet6: TTabSheet;
    Panel12: TPanel;
    CheckListBox6: TCheckListBox;
    Button14: TButton;
    CheckBox6: TCheckBox;
    Button15: TButton;
    PageControlKrutilka: TPageControl;
    TabSheetKrutil311: TTabSheet;
    TabSheetkruthron: TTabSheet;
    TabSheetKrutVerba: TTabSheet;
    TabSheet9: TTabSheet;
    ProgressBarKrut311: TProgressBar;
    CheckListBoxKrut311Action: TCheckListBox;
    ButtonKrut311Pusk: TButton;
    CheckListBox311InKa: TCheckListBox;
    ButtonkrutHronPusk: TButton;
    CheckListBoxKrutHron: TCheckListBox;
    ProgressBarKrutHron: TProgressBar;
    ButtonKrutVerbaStart: TButton;
    CheckListBoxKrutVerba: TCheckListBox;
    ProgressBarKrutVerba: TProgressBar;
    ButtonKrutArhivStart: TButton;
    CheckListBoxKrutArhiv: TCheckListBox;
    ProgressBarKrutArhiv: TProgressBar;
    TrayIcon1: TTrayIcon;
    Timer1: TTimer;
    CheckBox311SformAuto: TCheckBox;
    CheckBox311InPodpAuto: TCheckBox;
    CheckBox311InKriptAuto: TCheckBox;
    CheckBox311ArhAuto: TCheckBox;
    CheckBoxKrut311Auto: TCheckBox;
    CheckBoxKrutXronauto: TCheckBox;
    CheckBoxKrutVerbaAuto: TCheckBox;
    CheckBoxKrutArhAuto: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button311RefreshClick(Sender: TObject);
    procedure CheckListBox311SformClick(Sender: TObject);
    procedure Button311SformProverkaClick(Sender: TObject);
    procedure CheckBox311SformirovAllCheckClick(Sender: TObject);
    procedure Button311InPodbRefreshClick(Sender: TObject);
    procedure CheckBox311InKACheckAllClick(Sender: TObject);
    procedure CheckBox311InSignCheckAllClick(Sender: TObject);
    procedure Button311InSignRefreshClick(Sender: TObject);
    procedure Button311InKaOutClick(Sender: TObject);
    procedure Button311InArhRefreshClick(Sender: TObject);
    procedure Button311InCriptSendClick(Sender: TObject);
    procedure ButtonArhiv311RefreshClick(Sender: TObject);
    procedure CheckBoxArhiv311CheckAllClick(Sender: TObject);
    procedure ButtonArh311ABildClick(Sender: TObject);
    procedure CheckBoxArhiv311CheckAllBClick(Sender: TObject);
    procedure ButtonArhiv311RefreshBClick(Sender: TObject);
    procedure ButtonArh311BBildClick(Sender: TObject);
    procedure ButtonVerba311SignRefrClick(Sender: TObject);
    procedure ButtonVerba311SignClick(Sender: TObject);
    procedure ButtonKrut311PuskClick(Sender: TObject);
    procedure ButtonkrutHronPuskClick(Sender: TObject);
    procedure ButtonKrutVerbaStartClick(Sender: TObject);
    procedure CheckBoxVerba311CriptChAllClick(Sender: TObject);
    procedure ButtonVerba311CrptRefrClick(Sender: TObject);
    procedure ButtonVerba311CriptClick(Sender: TObject);
    procedure CheckBox311InArhCheckAllClick(Sender: TObject);
    procedure Button311InArhOutClick(Sender: TObject);
    procedure ButtonKrutArhivStartClick(Sender: TObject);
    procedure ButtonVerba311SignRefreshClick(Sender: TObject);
    procedure CheckBoxVerbaMailSignChAllClick(Sender: TObject);
    procedure ButtonVerbaMailSignClick(Sender: TObject);
    procedure ButtonArhMailRefreshClick(Sender: TObject);
    procedure CheckBoxArhMailCheckAllClick(Sender: TObject);
    procedure ButtonArhMailBildClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    User :Tuser;
  end;

var
  Arhivator:ObjectArhivator;
  P311:Object311P;
  fmMain: TfmMain;
  UsersLogin:TUser;
  Cripto:TVerba;
  Verba:ObjectVerba;
  Krutilka:ObjectKrutilka;

implementation

{$R *.dfm}

function GetUserFromWindows: string;
Var
  UserName : string;
  UserNameLen : Dword;
Begin
  UserNameLen := 255;
  SetLength(userName, UserNameLen);
  If GetUserName(PChar(UserName), UserNameLen) Then
    Result := Copy(UserName,1,UserNameLen - 1)
  Else
    Result := 'Unknown';
End;

Procedure TUser.LoadLogin;
var
   b:  boolean;
Begin
 UsersLogin.Login:=GetUserFromWindows;

 dmData.qrLoadDostup.Active:=False;
 dmData.qrLoadDostup.ParamByName('USER_LOGIN').Value := UsersLogin.Login;
 dmData.qrLoadDostup.Active:=True;
 dmData.qrLoadDostup.First;
 while NOT dmData.qrLoadDostup.Eof do
 begin
  UsersLogin.ID:=dmData.qrLoadDostup.FieldByName('ID_USER').AsInteger;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=1 then UsersLogin.Dostup.PO:=True;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=2 then UsersLogin.Dostup.P311:=True;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=3 then UsersLogin.Dostup.VerbaKa:=True;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=4 then UsersLogin.Dostup.VerbaSign:=True;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=5 then UsersLogin.Dostup.VerbaMail:=True;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=6 then UsersLogin.Dostup.Arhiv:=True;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=7 then UsersLogin.Dostup.Krutilka:=True;
  If dmData.qrLoadDostup.FieldByName('ID_REPORT').AsInteger=8 then UsersLogin.Dostup.Hranilishe:=True;
  dmData.qrLoadDostup.Next;
 end;
 {��� �������� �������� ������ ���� ����������� ���� � �� ����}
 if UsersLogin.Dostup.P311<>True then
 Begin
  fmMain.PageControlMain.Pages[2].TabVisible:=False;
 End else
 Begin
  b:= P311.LoadPath;
 End;
 if UsersLogin.Dostup.Arhiv<>True then
 Begin
  fmMain.PageControlMain.Pages[3].TabVisible:=False;
 End else
 Begin
  Arhivator.LoadPath;
 End;
 if UsersLogin.Dostup.VerbaKa<>True then
 Begin
  fmMain.PageControlMain.Pages[0].TabVisible:=False;
 End else
 Begin
  Verba.LoadPath;
  Cripto.VInitAsrKey;
  Cripto.VerbaInit;
 End;
 if UsersLogin.Dostup.Krutilka<>True then
 Begin
  fmMain.PageControlMain.Pages[1].TabVisible:=False;
 End else
 Begin
  krutilka.LoadPath;
 End;
End;

procedure TfmMain.Button311InPodbRefreshClick(Sender: TObject);
begin
 P311.RefreshCheckListInKa;
end;

procedure TfmMain.Button311InCriptSendClick(Sender: TObject);
begin
 P311.OtpravkaSign;
end;

procedure TfmMain.Button311InArhOutClick(Sender: TObject);
begin
 P311.OtpravkaArh;
end;

procedure TfmMain.Button311InArhRefreshClick(Sender: TObject);
begin
 P311.RefreshCheckListInArh;
end;

procedure TfmMain.Button311InKaOutClick(Sender: TObject);
begin
 P311.OtpravkaKa;
end;

procedure TfmMain.Button311InSignRefreshClick(Sender: TObject);
begin
 P311.RefreshCheckListInSign;
end;

procedure TfmMain.Button311RefreshClick(Sender: TObject);
begin
 P311.RefreshCheckListSform;
end;

procedure TfmMain.Button311SformProverkaClick(Sender: TObject);
begin
 P311.Proverka;
end;

procedure TfmMain.ButtonArh311ABildClick(Sender: TObject);
begin
 Arhivator.BildArhiv311;
end;

procedure TfmMain.ButtonArh311BBildClick(Sender: TObject);
begin
 Arhivator.BildArhiv311B;
end;

procedure TfmMain.ButtonArhiv311RefreshBClick(Sender: TObject);
begin
 Arhivator.RefreshCheckList311B;
end;

procedure TfmMain.ButtonArhiv311RefreshClick(Sender: TObject);
begin
 Arhivator.RefreshCheckList311;
end;

procedure TfmMain.ButtonArhMailBildClick(Sender: TObject);
begin
 Arhivator.BildCab;
end;

procedure TfmMain.ButtonArhMailRefreshClick(Sender: TObject);
begin
 Arhivator.RefreshCheckListMail;
end;

procedure TfmMain.ButtonKrut311PuskClick(Sender: TObject);
begin
 Krutilka.Pusk311;
end;

procedure TfmMain.ButtonKrutArhivStartClick(Sender: TObject);
begin
 krutilka.PuskArhiv;
end;

procedure TfmMain.ButtonkrutHronPuskClick(Sender: TObject);
begin
 krutilka.PuskHron;
end;

procedure TfmMain.ButtonKrutVerbaStartClick(Sender: TObject);
begin
 krutilka.PuskVerba;
end;

procedure TfmMain.ButtonVerba311CriptClick(Sender: TObject);
begin
 Verba.Cript311;
end;

procedure TfmMain.ButtonVerba311CrptRefrClick(Sender: TObject);
begin
 Verba.RefreshCheckList311C;
end;

procedure TfmMain.ButtonVerba311SignClick(Sender: TObject);
begin
 Verba.Sign311;
end;

procedure TfmMain.ButtonVerba311SignRefrClick(Sender: TObject);
begin
 Verba.RefreshCheckList311S;
end;

procedure TfmMain.ButtonVerba311SignRefreshClick(Sender: TObject);
begin
 Verba.RefreshCheckListMailSign;
end;

procedure TfmMain.ButtonVerbaMailSignClick(Sender: TObject);
begin
 Verba.MailSign;
end;

procedure TfmMain.CheckBox311InArhCheckAllClick(Sender: TObject);
begin
 P311.CheckAllInArh;
end;

procedure TfmMain.CheckBox311InKACheckAllClick(Sender: TObject);
begin
 P311.CheckAllInKa;
end;

procedure TfmMain.CheckBox311InSignCheckAllClick(Sender: TObject);
begin
 P311.CheckAllInSign;
end;

procedure TfmMain.CheckBox311SformirovAllCheckClick(Sender: TObject);
begin
 P311.CheckAll;
end;

procedure TfmMain.CheckBoxArhiv311CheckAllBClick(Sender: TObject);
begin
 Arhivator.CheckAll311B;
end;

procedure TfmMain.CheckBoxArhiv311CheckAllClick(Sender: TObject);
begin
 Arhivator.CheckAll311;
end;

procedure TfmMain.CheckBoxArhMailCheckAllClick(Sender: TObject);
begin
 Arhivator.CheckAllMail;
end;

procedure TfmMain.CheckBoxVerba311CriptChAllClick(Sender: TObject);
begin
 Verba.CheckAll311Cript;
end;

procedure TfmMain.CheckBoxVerbaMailSignChAllClick(Sender: TObject);
begin
 Verba.CheckAllMailSign;
end;

procedure TfmMain.CheckListBox311SformClick(Sender: TObject);
begin
 P311.LoadSozdanFile;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
 UsersLogin.LoadLogin;
 {Verba.VInitAsrKey;}

end;

procedure TfmMain.Timer1Timer(Sender: TObject);
begin
 Timer1.Enabled:=False;
 if UsersLogin.Dostup.P311 then
 Begin
  if CheckBox311SformAuto.Checked then
  Begin
   CheckBox311SformirovAllCheck.Checked:=True;
   P311.RefreshCheckListSform;
   P311.CheckAll;
   P311.Proverka;
  End;
  if CheckBox311InPodpAuto.Checked then
  Begin
   CheckBox311InKACheckAll.Checked:=True;
   P311.RefreshCheckListInKa;
   P311.CheckAllInKa;
   P311.OtpravkaKa;
  End;
  if CheckBox311InKriptAuto.Checked then
  Begin
   CheckBox311InSignCheckAll.Checked:=True;
   P311.RefreshCheckListInSign;
   P311.CheckAllInSign;
   P311.OtpravkaSign;
  End;
  if CheckBox311ArhAuto.Checked then
  Begin
   CheckBox311InArhCheckAll.Checked:=True;
   P311.RefreshCheckListInArh;
   P311.CheckAllInArh;
   P311.OtpravkaArh;
  End;

 End;
 if UsersLogin.Dostup.Krutilka then
 Begin
  if CheckBoxKrut311Auto.Checked then
  Begin
   Krutilka.Pusk311;
  End;
  if CheckBoxKrutXronauto.Checked then
  Begin
   Krutilka.PuskHron;
  End;
  if CheckBoxKrutVerbaAuto.Checked then
  Begin
   Krutilka.PuskVerba;
  End;
  if CheckBoxKrutArhAuto.Checked then
  Begin
   Krutilka.PuskArhiv;
  End;

 End;
 Timer1.Enabled:=True;
end;

end.
