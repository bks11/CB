unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, DockTabSet, StdCtrls, CheckLst, ExtCtrls, ComCtrls, Buttons,
  WideStrings, FMTBcd, DB, SqlExpr, Unit2;

type
  TUser = Object
   Login:String;
   Prava:record
    Verba:Boolean;
    Krutilka:Boolean;
    P311:Boolean;
   End;
   Procedure LoadLogin; {��������� ���� � ������}
  End;
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    CheckListBox1: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ComboBox1: TComboBox;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P311:Object311P;
  Form1: TForm1;

implementation

{$R *.dfm}

Procedure TUser.LoadLogin;
Begin

End;

procedure TForm1.FormCreate(Sender: TObject);
begin
 P311.LoadPath;
end;

end.
