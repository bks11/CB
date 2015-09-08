unit Verba;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, DockTabSet, StdCtrls, CheckLst, ExtCtrls, ComCtrls, Buttons,
  WideStrings, FMTBcd, DB, SqlExpr, Data;

Type

 ObjectVerba = Object
  Path311 : record
   In311Sign:String;
   Out311Sign:String;
   In311Cript:String;
   Out311Cript:String;
   InMailSign:String;
   OutMailSign:String;
   Sertifikat311Sign:String;
   Sertifikat311Cript:String;
   Sertifikat311SignArh:String;
  End;
  Procedure LoadPath; {��������� ���� � ������}
  {311Sign}
  Procedure RefreshCheckList311S; {�������� ���� �� �������}
  Procedure CheckAll311Sign; {������� ��� ����� �� �������}
  Procedure Sign311; {������������}
  {311Cript}
  Procedure RefreshCheckList311C; {�������� ���� �� �������}
  Procedure CheckAll311Cript; {������� ��� ����� �� �������}
  Procedure Cript311; {������������}
  {MailSign}
  Procedure RefreshCheckListMailSign; {�������� ���� �� �������}
  Procedure CheckAllMailSign; {������� ��� ����� �� �������}
  Procedure MailSign; {������������}
 End;

implementation

Uses
 uMain;     {}

Procedure ObjectVerba.MailSign;
Begin
 Cripto.Folder:=Path311.InMailSign+'\';
 Cripto.FolderOut:=Path311.OutMailSign+'\';
 Cripto.SignFolder(3);
 RefreshCheckListMailSign;
End;

Procedure ObjectVerba.CheckAllMailSign;
Var
 I:Integer;
Begin
 if fmMain.CheckListBoxVerbaMailSign.Items.Count>0 then
 Begin
  fmMain.CheckListBoxVerbaMailSign.ItemIndex:=0;
  for I := 0 to fmMain.CheckListBoxVerbaMailSign.Items.Count - 1 do
  Begin
   fmMain.CheckListBoxVerbaMailSign.Checked[fmMain.CheckListBoxVerbaMailSign.ItemIndex]:=fmMain.CheckBoxVerbaMailSignChAll.Checked;
   fmMain.CheckListBoxVerbaMailSign.ItemIndex:=fmMain.CheckListBoxVerbaMailSign.ItemIndex+1;
  End;
 End;
 fmMain.CheckListBoxVerba311Sign.ItemIndex:=0;
End;

Procedure ObjectVerba.RefreshCheckListMailSign;
Var
 SerchFile:TSearchRec;
 FindRes:Integer;
Begin
 dmData.qrVerbaMailSignUpd.ParamByName('ARC_RS').Value:=UsersLogin.ID;
 dmData.qrVerbaMailSignUpd.ExecSQL;
 fmMain.CheckListBoxVerbaMailSign.Items.Clear;
 FindRes:=Findfirst(Path311.InMailSign+'\*.ARJ',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   fmMain.CheckListBoxVerbaMailSign.Items.Add(SerchFile.Name);
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
End;

Procedure ObjectVerba.Cript311;
Begin
 Cripto.Folder:=Path311.In311Cript+'\';
 Cripto.FolderOut:=Path311.Out311Cript+'\';
 Cripto.CriptFolder(2);
 RefreshCheckList311C;
End;

Procedure ObjectVerba.CheckAll311Cript;
Var
 I:Integer;
Begin
 if fmMain.CheckListBoxVerba311Cript.Items.Count>0 then
 Begin
  fmMain.CheckListBoxVerba311Cript.ItemIndex:=0;
  for I := 0 to fmMain.CheckListBoxVerba311Cript.Items.Count - 1 do
  Begin
   fmMain.CheckListBoxVerba311Cript.Checked[fmMain.CheckListBoxVerba311Cript.ItemIndex]:=fmMain.CheckBoxVerba311CriptChAll.Checked;
   fmMain.CheckListBoxVerba311Cript.ItemIndex:=fmMain.CheckListBoxVerba311Cript.ItemIndex+1;
  End;
 End;
 fmMain.CheckListBoxVerba311Sign.ItemIndex:=0;
End;

Procedure ObjectVerba.RefreshCheckList311C;
Var
 SerchFile:TSearchRec;
 FindRes:Integer;
Begin
 fmMain.CheckListBoxVerba311Cript.Items.Clear;
 FindRes:=Findfirst(Path311.In311Cript+'\SBC*.xml',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   fmMain.CheckListBoxVerba311Cript.Items.Add(SerchFile.Name);
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
End;

Procedure ObjectVerba.Sign311;
Begin
 Cripto.Folder:=Path311.In311Sign+'\';
 Cripto.FolderOut:=Path311.Out311Sign+'\';
 Cripto.SignFolder(1);
 RefreshCheckList311S;
End;

Procedure ObjectVerba.CheckAll311Sign;
Var
 I:Integer;
Begin
 if fmMain.CheckListBoxVerba311Sign.Items.Count>0 then
 Begin
  fmMain.CheckListBoxVerba311Sign.ItemIndex:=0;
  for I := 0 to fmMain.CheckListBoxVerba311Sign.Items.Count - 1 do
  Begin
   fmMain.CheckListBoxVerba311Sign.Checked[fmMain.CheckListBoxVerba311Sign.ItemIndex]:=fmMain.CheckBoxVerba311SignChAll.Checked;
   fmMain.CheckListBoxVerba311Sign.ItemIndex:=fmMain.CheckListBoxVerba311Sign.ItemIndex+1;
  End;
 End;
 fmMain.CheckListBoxVerba311Sign.ItemIndex:=0;
End;

Procedure ObjectVerba.RefreshCheckList311S;
Var
 SerchFile:TSearchRec;
 FindRes:Integer;
Begin
 fmMain.CheckListBoxVerba311Sign.Items.Clear;
 FindRes:=Findfirst(Path311.In311Sign+'\SBC*.xml',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   fmMain.CheckListBoxVerba311Sign.Items.Add(SerchFile.Name);
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
End;

Procedure ObjectVerba.LoadPath;
Begin
 if UsersLogin.Dostup.VerbaKa=True then
 Begin
  dmData.qr311PLoadPath.Active:=False;
  dmData.qr311PLoadPath.ParamByName('ID_REPORT').Value :=3;
  dmData.qr311PLoadPath.Active:=True;
  dmData.qr311PLoadPath.First;
  while NOT dmData.qr311PLoadPath.Eof do
  begin
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='�� �������' then Path311.In311Sign:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='� �������' then Path311.Out311Sign:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='����������' then Path311.Sertifikat311Sign:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   dmData.qr311PLoadPath.Next;
  end;
 End;
 if UsersLogin.Dostup.VerbaSign=True then
 Begin
  dmData.qr311PLoadPath.Active:=False;
  dmData.qr311PLoadPath.ParamByName('ID_REPORT').Value :=4;
  dmData.qr311PLoadPath.Active:=True;
  dmData.qr311PLoadPath.First;
  while NOT dmData.qr311PLoadPath.Eof do
  begin
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='�� ������' then Path311.In311Cript:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='� ������' then Path311.Out311Cript:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='����������' then Path311.Sertifikat311Cript:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   dmData.qr311PLoadPath.Next;
  end;
 End;
 if UsersLogin.Dostup.VerbaMail=True then
 Begin
  dmData.qr311PLoadPath.Active:=False;
  dmData.qr311PLoadPath.ParamByName('ID_REPORT').Value :=5;
  dmData.qr311PLoadPath.Active:=True;
  dmData.qr311PLoadPath.First;
  while NOT dmData.qr311PLoadPath.Eof do
  begin
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='����� ������� ��������' then Path311.InMailSign:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='����� ������� ���������' then Path311.OutMailSign:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   If dmData.qr311PLoadPath.FieldByName('NOTE').AsString='����������' then Path311.Sertifikat311SignArh:=dmData.qr311PLoadPath.FieldByName('REPORT_PATH').AsString;
   dmData.qr311PLoadPath.Next;
  end;
 End;
 dmData.qr311PLoadPath.Active:=False;
 RefreshCheckList311C;
End;

end.
