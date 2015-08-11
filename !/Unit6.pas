unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB, DBTables, Grids, DBGrids, ADODB, Mask,
  DBCtrls, DateUtils;

Type
 Object364402P = Object
  Path : record
   OutCB:String;{�������� ������ � ��}
   InCB:String;{����� ������ �� ��}
   Arh:String;{������� ��� �������� ����� ������}
   Polzovatel:String;{������� ���� �������� ���������������� �����}
   InArh:String; {������� ��� ������ ������� ����� ��������������}
   InPodp:String;{���� ������ �� �������}
   InPodpOut:String;{���� ������ �� �������}
   InPodp3:String;{���� ������ �� �������}
   InPodpOut3:String;{���� ������ �� �������}
   InCript:String;{���� ������ �� ������}
   InCriptOut:String;{���� ������ �� ������}
   In364:String;{���� ������ �� �������}
   In402:String;{���� ������ �� ���������}
   UnArh:String;{���� ��� �������}
   Temp:String;{���� ��� �������}
   TempArhReglament:String;{������� ��� ������� ��� ����������}
  End;
  Procedure PathInit; {����������� ����� �� �������� � ���������}
  Procedure PriemCB; {������� ����� �� ��}
  Procedure OutCB; {������� ����� �� ��}
 End;

implementation

Uses
 Unit1,Unit2,Unit3, Math;

Procedure Object364402P.PathInit; {����������� ����� �� �������� � ���������}
Begin
 Path.OutCB:='z:\!CBINFO\Out\';{�������� ������ � ��}
 Path.InCB:='z:\!CBINFO\In\';{����� ������ �� ��}
 Path.Arh:='d:\Archiv\364-402\';{������� ��� ������� �� ��}
 Path.Polzovatel:='z:\364-402\';{������� ��� ������ �������������}
 Path.InArh:='d:\Archiv\365\InArh\';{������� ��� ������ �� ���������}
 Path.InPodp:='z:\!InPodp\';{���� ������ �� �������}
 Path.InPodpOut:='z:\!InPodpOut\';{���� ������ �� �������}
 Path.InPodp3:='z:\!InPodp3\';{���� ������ �� �������}
 Path.InPodpOut3:='z:\!InPodp3Out\';{���� ������ �� �������}
 Path.InCript:='z:\!InCript\';{���� ������ �� ������}
 Path.InCriptOut:='z:\!InCriptOut\';{���� ������ �� ������}
 Path.In364:='z:\364-402\����� 364\';{���� ������ �� �������}
 Path.In402:='z:\364-402\����� 402\';{���� ������ �� ���������}
 Path.UnArh:='d:\Archiv\364-402\UnArh\';{���� ��� �������}
 Path.Temp:='d:\Archiv\364-402\Temp\';{���� ��� �������}
 Path.TempArhReglament:='d:\Archiv\364-402\CvitCB\';{������� ��� ������� ��� ����������}
End;

Procedure Object364402P.OutCB; {������� ����� �� ��}
Var
 ColFiles:Integer;
 SerchFile:TSearchRec;
 S:String;
 myYear, myMonth, myDay : Word;
 myHour, myMin, mySec, myMilli : Word;
 FindRes:Integer;
Begin
 ColFiles:=0;
 FindRes:=Findfirst(Block364402P.Path.In364+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   if DirectoryExists(Block364402P.Path.Arh+DateToStr(Date))=false then CreateDir(Block364402P.Path.Arh+DateToStr(Date));
   if DirectoryExists(Block364402P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block364402P.Path.Polzovatel+DateToStr(Date));
   CopyFile(PChar(Block364402P.Path.In364+SerchFile.Name),PChar(Block364402P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
   CopyFile(PChar(Block364402P.Path.In364+SerchFile.Name),PChar(Block364402P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name),False);
   MoveFile(PChar(Block364402P.Path.In364+SerchFile.Name),PChar(Block364402P.Path.InPodp+SerchFile.Name));
   ColFiles:=ColFiles+1;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 If ColFiles>0 then
 Begin
  Form1.ListBox5.Items.Add('��������� ��������� � ������� - '+IntToStr(ColFiles));
  Form1.ListBox3.Items.Add('��������� ��������� � ������� - '+IntToStr(ColFiles));
  LoadLog('Adm','��������� ��������� � ������� - '+IntToStr(ColFiles));
  LoadLog('364','��������� ��������� � ������� - '+IntToStr(ColFiles));
  Verba.Folder:=Block364402P.Path.InPodp;
  Verba.FolderOut:=Block364402P.Path.InPodpOut;
  Verba.SignFolder(1);
  {���������� �� ������}
  FindRes:=Findfirst(Block364402P.Path.InPodpOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block364402P.Path.InPodpOut+SerchFile.Name),PChar(Block364402P.Path.InCript+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  Verba.Folder:=Block364402P.Path.InCript;
  Verba.FolderOut:=Block364402P.Path.InCriptOut;
  Verba.CriptFolder(2);
  {���������� � ������ �� ���������}
  FindRes:=Findfirst(Block364402P.Path.InCriptOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block364402P.Path.InCriptOut+SerchFile.Name),PChar(Block364402P.Path.InArh+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  {������� ������}
  DecodeDateTime(Now,myYear,myMonth,myDay,myHour,myMin,mySec,myMilli);
  S:=IntToStr(myYear);
  If myMonth<10 then S:=S+'0';
  S:=S+IntToStr(myMonth);
  If myDay<10 then S:=S+'0';
  S:=S+IntToStr(myDay)+'_';
  S:=S+'0'+LoadPost('tz');
  ARJ.Comand:='ARJ32.EXE m -e '+Block364402P.Path.InArh+'PSEI_2490_0003_'+S+'.ARJ '+Block364402P.Path.InArh+'*.*';
  ARJ.RunArj;
  MoveFile(PChar(Block364402P.Path.InArh+'PSEI_2490_0003_'+S+'.ARJ'),PChar(Block364402P.Path.InPodp3+'PSEI_2490_0003_'+S+'.ARJ'));
  Verba.Folder:=Block364402P.Path.InPodp3;
  Verba.FolderOut:=Block364402P.Path.InPodpOut3;
  Verba.SignFolder(3);
  Form1.ListBox5.Items.Add('������ ����� '+'PSEI_2490_0003_'+S+'.ARJ');
  Form1.ListBox3.Items.Add('������ ����� '+'PSEI_2490_0003_'+S+'.ARJ');
  LoadLog('Adm','������ ����� '+'PSEI_2490_0003_'+S+'.ARJ');
  MoveFile(PChar(Block364402P.Path.InPodpOut3+'PSEI_2490_0003_'+S+'.ARJ'),PChar(Block364402P.Path.TempArhReglament+'PSEI_2490_0003_'+S+'.ARJ'));
 End;
 {���������� �������� � ���������}
 ColFiles:=0;
 FindRes:=Findfirst(Block364402P.Path.In402+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   if DirectoryExists(Block364402P.Path.Arh+DateToStr(Date))=false then CreateDir(Block364402P.Path.Arh+DateToStr(Date));
   if DirectoryExists(Block364402P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block364402P.Path.Polzovatel+DateToStr(Date));
   CopyFile(PChar(Block364402P.Path.In402+SerchFile.Name),PChar(Block364402P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
   CopyFile(PChar(Block364402P.Path.In402+SerchFile.Name),PChar(Block364402P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name),False);
   MoveFile(PChar(Block364402P.Path.In402+SerchFile.Name),PChar(Block364402P.Path.InPodp+SerchFile.Name));
   ColFiles:=ColFiles+1;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 If ColFiles>0 then
 Begin
  Form1.ListBox5.Items.Add('��������� ��������� � ��������� - '+IntToStr(ColFiles));
  Form1.ListBox3.Items.Add('��������� ��������� � ��������� - '+IntToStr(ColFiles));
  LoadLog('Adm','��������� ��������� � ��������� - '+IntToStr(ColFiles));
  LoadLog('364','��������� ��������� � ��������� - '+IntToStr(ColFiles));
  Verba.Folder:=Block364402P.Path.InPodp;
  Verba.FolderOut:=Block364402P.Path.InPodpOut;
  Verba.SignFolder(1);
  {���������� �� ������}
  FindRes:=Findfirst(Block364402P.Path.InPodpOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block364402P.Path.InPodpOut+SerchFile.Name),PChar(Block364402P.Path.InCript+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  Verba.Folder:=Block364402P.Path.InCript;
  Verba.FolderOut:=Block364402P.Path.InCriptOut;
  Verba.CriptFolder(2);
  {���������� � ������ �� ���������}
  FindRes:=Findfirst(Block364402P.Path.InCriptOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block364402P.Path.InCriptOut+SerchFile.Name),PChar(Block364402P.Path.InArh+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  {������� ������}
  DecodeDateTime(Now,myYear,myMonth,myDay,myHour,myMin,mySec,myMilli);
  S:=IntToStr(myYear);
  If myMonth<10 then S:=S+'0';
  S:=S+IntToStr(myMonth);
  If myDay<10 then S:=S+'0';
  S:=S+IntToStr(myDay)+'_';
  S:=S+'0'+LoadPost('tz');
  ARJ.Comand:='ARJ32.EXE m -e '+Block364402P.Path.InArh+'PSKR_2490_0003_'+S+'.ARJ '+Block364402P.Path.InArh+'*.*';
  ARJ.RunArj;
  MoveFile(PChar(Block364402P.Path.InArh+'PSKR_2490_0003_'+S+'.ARJ'),PChar(Block364402P.Path.InPodp3+'PSKR_2490_0003_'+S+'.ARJ'));
  Verba.Folder:=Block364402P.Path.InPodp3;
  Verba.FolderOut:=Block364402P.Path.InPodpOut3;
  Verba.SignFolder(3);
  Form1.ListBox5.Items.Add('������ ����� '+'PSKR_2490_0003_'+S+'.ARJ');
  Form1.ListBox3.Items.Add('������ ����� '+'PSKR_2490_0003_'+S+'.ARJ');
  LoadLog('Adm','������ ����� '+'PSKR_2490_0003_'+S+'.ARJ');
  MoveFile(PChar(Block364402P.Path.InPodpOut3+'PSKR_2490_0003_'+S+'.ARJ'),PChar(Block364402P.Path.TempArhReglament+'PSKR_2490_0003_'+S+'.ARJ'));
 End;
 If Reglament then
 Begin
  FindRes:=Findfirst(Block364402P.Path.TempArhReglament+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    ARJ.Comand:='makecab '+Block364402P.Path.TempArhReglament+SerchFile.Name+' '+Path.OutCB+'tz'+DayOfSymvol+LoadPost('tz')+'110.010';
    ARJ.RunArj;
    Form1.ListBox5.Items.Add('������ ����� '+'tz'+DayOfSymvol+LoadPost('tz')+'110.010');
    Form1.ListBox3.Items.Add('������ ����� '+'tz'+DayOfSymvol+LoadPost('tz')+'110.010');
    LoadLog('Adm','������ ����� '+'tz'+DayOfSymvol+LoadPost('tz')+'110.010');
    UpdatePost('tz',StrToInt(LoadPost('tz')));
    DeleteFile(Block364402P.Path.TempArhReglament+SerchFile.Name);
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
 End;
End;

Procedure Object364402P.PriemCB; {������� ����� �� ��}
Var
 ColFiles:Integer;
 SerchFile:TSearchRec;
 F:TStringList;
 Rez:Boolean;
 S:String;
 FindRes:Integer;
 I:Integer;
Begin
 {����������� ������� mz � ����������� ����}
 FindRes:=Findfirst(Block364402P.Path.InCB+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If Pos('tz',SerchFile.Name)>0 then
   Begin
    Form1.ListBox5.Items.Add('������ ����� '+SerchFile.Name);
    Form1.ListBox3.Items.Add('������ ����� '+SerchFile.Name);
    LoadLog('Adm','������ ����� '+SerchFile.Name);
    f:=TStringList.Create();
    f.LoadFromFile(Block364402P.Path.InCB+SerchFile.Name);
    S:=f[0];
    f.Free;
    {MSCF}
    If Pos('MSCF',S)>0 then
    Begin
     ARJ.Comand:='expand -r '+Block364402P.Path.InCB+SerchFile.Name+' '+Block364402P.Path.UnArh;
     ARJ.RunArj;
     DeleteFile(Block364402P.Path.InCB+SerchFile.Name);
    End
    Else
    Begin
     f:=TStringList.Create();
     f.LoadFromFile(Block364402P.Path.InCB+SerchFile.Name);
     Rez:=False;
     For I:=0 To f.Count-1 do
     Begin
      S:=f[I];
      {������}
      If Pos('������',S)>0 then Rez:=True;
     End;
     f.Free;
     Form1.ListBox5.Items.Add('������� ��������� '+SerchFile.Name);
     Form1.ListBox3.Items.Add('������� ��������� '+SerchFile.Name);
     LoadLog('Adm','������� ��������� '+SerchFile.Name);
     LoadLog('364','������� ��������� '+SerchFile.Name);
     if DirectoryExists(Block364402P.Path.Arh+DateToStr(Date))=false then CreateDir(Block364402P.Path.Arh+DateToStr(Date));
     if DirectoryExists(Block364402P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block364402P.Path.Polzovatel+DateToStr(Date));
     CopyFile(PChar(Block364402P.Path.InCB+SerchFile.Name),PChar(Block364402P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
     MoveFile(PChar(Block364402P.Path.InCB+SerchFile.Name),PChar(Block364402P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name));
    End;
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 FindRes:=Findfirst(Block364402P.Path.UnArh+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If (Pos('.arj',SerchFile.Name)>0)or(Pos('.ARJ',SerchFile.Name)>0) then
   Begin
    ARJ.Comand:='ARJ32.EXE x '+Block364402P.Path.UnArh+SerchFile.Name+' '+Block364402P.Path.Temp;
    ARJ.RunArj;
    DeleteFile(Block364402P.Path.UnArh+SerchFile.Name);
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 ColFiles:=0;
 FindClose(SerchFile);
 FindRes:=Findfirst(Block364402P.Path.Temp+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   if DirectoryExists(Block364402P.Path.Arh+DateToStr(Date))=false then CreateDir(Block364402P.Path.Arh+DateToStr(Date));
   if DirectoryExists(Block364402P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block364402P.Path.Polzovatel+DateToStr(Date));
   CopyFile(PChar(Block364402P.Path.Temp+SerchFile.Name),PChar(Block364402P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
   MoveFile(PChar(Block364402P.Path.Temp+SerchFile.Name),PChar(Block364402P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name));
   ColFiles:=ColFiles+1;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 if ColFiles>0 then
 Begin
  Form1.ListBox5.Items.Add('������� ��������� - '+IntToStr(ColFiles));
  Form1.ListBox3.Items.Add('������� ��������� - '+IntToStr(ColFiles));
  LoadLog('Adm','������� ��������� - '+IntToStr(ColFiles));
  LoadLog('364','������� ��������� - '+IntToStr(ColFiles));
 End;
End;

end.
