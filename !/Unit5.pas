unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB, DBTables, Grids, DBGrids, ADODB, Mask,
  DBCtrls, DateUtils;

Type
 Object365P = Object
  Path : record
   OutCB:String;{�������� ������ � ��}
   InCB:String;{����� ������ �� ��}
   TempPaket:String;{����� ��� ���������� �����}
   TempFile:String;{����� ��� �������� ������}
   Arh:String;{������� ��� �������� ����� ������}
   Polzovatel:String;{������� ���� �������� ���������������� �����}
   InArh:String; {������� ��� ������ ������� ����� ��������������}
   InPodp:String;{���� ������ �� �������}
   InPodpOut:String;{���� ������ �� �������}
   InCript:String;{���� ������ �� ������}
   InCriptOut:String;{���� ������ �� ������}
   UnCript:String;{���� ������ �� ������}
   UnCriptOut:String;{���� ������ �� ������}
   InDiasoft:String;{���� � ��������� �������� ��������}
   OutDiasoft:String;{���� � ��������� �������� ��������}
  End;
  Procedure PathInit; {����������� ����� �� �������� � ���������}
  Procedure PriemCB; {������� ����� �� ��}
  Procedure OutCB; {������� ����� �� ��}
 End;

implementation

Uses
 Unit1,Unit2,Unit3;

Procedure Object365P.PathInit;
Begin
 Path.OutCB:='z:\!CBINFO\Out\';{�������� ������ � ��}
 Path.InCB:='z:\!CBINFO\In\';{����� ������ �� ��}
 Path.TempPaket:='d:\Archiv\365\UnArh\';{������� ��� ������� �� ��}
 Path.TempFile:='d:\Archiv\365\Temp\';{������� ��� ������� �� ��}
 Path.Arh:='d:\Archiv\365\';{������� ��� ������� �� ��}
 Path.Polzovatel:='z:\365\';{������� ��� ������ �������������}
 Path.InArh:='d:\Archiv\365\InArh\';{������� ��� ������ �� ���������}
 Path.InPodp:='z:\!InPodp\';{���� ������ �� �������}
 Path.InPodpOut:='z:\!InPodpOut\';{���� ������ �� �������}
 Path.InCript:='z:\!InCript\';{���� ������ �� ������}
 Path.InCriptOut:='z:\!InCriptOut\';{���� ������ �� ������}
 Path.UnCript:='z:\!UnCript2\';{���� ������ �� ������}
 Path.UnCriptOut:='z:\!UnCript2Out\';{���� ������ �� ������}
 Path.InDiasoft:='n:\exchange\365p\simf\receive\';{���� � ��������� �������� ��������}
 Path.OutDiasoft:='n:\exchange\365p\simf\send\';{���� � ��������� �������� ��������}
End;

Procedure Object365P.PriemCB;
Var
 Error:Boolean;
 SerchFile:TSearchRec;
 FindRes:Integer;
 F:TStringList;
 S:String;
 PathPolz:String;
 I:Integer;
 ColCvit:Integer;
 ColPodp:Integer;
 myYear, myMonth, myDay : Word;
 myHour, myMin, mySec, myMilli : Word;
Begin
 {����������� ������� mz � ����������� ����}
 FindRes:=Findfirst(Block365P.Path.InCB+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If Pos('mz',SerchFile.Name)>0 then
   Begin
    Form1.ListBox4.Items.Add('������ ����� '+SerchFile.Name);
    Form1.ListBox3.Items.Add('������ ����� '+SerchFile.Name);
    LoadLog('Adm','������ ����� '+SerchFile.Name);
    ARJ.Comand:='expand -r '+Block365P.Path.InCB+SerchFile.Name+' '+Block365P.Path.TempPaket;
    ARJ.RunArj;
    DeleteFile(Block365P.Path.InCB+SerchFile.Name);
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 {���� ���� ������ ����������� �� � ���� �������� ���������� �� � ����}
 FindRes:=Findfirst(Block365P.Path.TempPaket+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If Pos('IZVTUB',SerchFile.Name)>0 then
   Begin
    MoveFile(PChar(Block365P.Path.TempPaket+SerchFile.Name),PChar(Block365P.Path.TempFile+SerchFile.Name));
   End;
   If (Pos('.ARJ',SerchFile.Name)>0)or(Pos('.arj',SerchFile.Name)>0) then
   Begin
    ARJ.Comand:='ARJ32.EXE x '+Block365P.Path.TempPaket+SerchFile.Name+' '+Block365P.Path.TempFile;
    ARJ.RunArj;
    DeleteFile(Block365P.Path.TempPaket+SerchFile.Name);
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 {��������� �������� �����}
 ColCvit:=0;
 FindRes:=Findfirst(Block365P.Path.TempFile+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If ((Pos('ROO',SerchFile.Name)>0)or(Pos('ZNO',SerchFile.Name)>0)or(Pos('RNO',SerchFile.Name)>0)or(Pos('PNO',SerchFile.Name)>0)or(Pos('RPO',SerchFile.Name)>0))and(Pos('KWTFCB',SerchFile.Name)=0) then
   Begin
    DecodeDateTime(Now,myYear,myMonth,myDay,myHour,myMin,mySec,myMilli);
    f:=TStringList.Create();
    S:=SerchFile.Name;
    If Pos('.VRB',S)>0 then Delete(S,Pos('.VRB',S),4);
    If Pos('.vrb',S)>0 then Delete(S,Pos('.vrb',S),4);
    {ROO13510110_910220150303_000561###}
    {10@@@}
    {2015-03-04@@@}
    {12:55:09@@@}
    {===}
    f.Add(S+'###');
    f.Add('10@@@');
    S:=IntToStr(myYear)+'-';
    If myMonth<10 then S:=S+'0';
    S:=S+IntToStr(myMonth)+'-';
    If myDay<10 then S:=S+'0';
    S:=S+IntToStr(myDay)+'@@@';
    f.Add(S);
    If myHour<10 then S:=S+'0';
    S:=IntToStr(myHour)+':';
    If myMin<10 then S:=S+'0';
    S:=S+IntToStr(myMin)+':';
    If mySec<10 then S:=S+'0';
    S:=S+IntToStr(mySec)+'@@@';
    f.Add(S);
    f.Add('===');
    S:='PB1_'+SerchFile.Name;
    If Pos('.VRB',S)>0 then Delete(S,Pos('.VRB',S),4);
    If Pos('.vrb',S)>0 then Delete(S,Pos('.vrb',S),4);
    S:=S+'.txt';
    f.SaveToFile(Block365P.Path.InPodp+S);
    if DirectoryExists(Block365P.Path.Arh+DateToStr(Date))=false then CreateDir(Block365P.Path.Arh+DateToStr(Date));
    f.SaveToFile(Block365P.Path.Arh+DateToStr(Date)+'\'+S);
    ColPodp:=ColPodp+1;
    f.Free;
    CopyFile(PChar(Block365P.Path.TempFile+SerchFile.Name),PChar(Block365P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
    MoveFile(PChar(Block365P.Path.TempFile+SerchFile.Name),PChar(Block365P.Path.UnCript+SerchFile.Name));
   End;
   If Pos('KWTFCB_',SerchFile.Name)>0 then
   Begin
    Error:=True;
    f:=TStringList.Create();
    f.LoadFromFile(Block365P.Path.TempFile+SerchFile.Name);
    For I:=0 To f.Count-1 do
    Begin
     S:=f[I];
     {20@@@}
     If Pos('20@@@',S)>0 then Error:=False;
    End;
    f.Free;
    If Error=True then
    Begin
     {����� ����� ����� ���������� �� ������}
     PathPolz:=Block365P.Path.Arh;
     {PathPolz:=PathPolz+DateToStr(Date);}
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'��������� �� ������';
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+SerchFile.Name;
     MoveFile(PChar(Block365P.Path.TempFile+SerchFile.Name),PChar(PathPolz));
     Form1.ListBox4.Items.Add('�� ������� �������� �� ���� ��');
     Form1.ListBox3.Items.Add('�� ������� �������� �� ���� ��');
     LoadLog('Adm','�� ������� �������� �� ���� ��');
    End;
    If Error=False then
    Begin
     PathPolz:=Block365P.Path.Arh;
     PathPolz:=PathPolz+DateToStr(Date);
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+'��������� ��';
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+SerchFile.Name;
     CopyFile(PChar(Block365P.Path.TempFile+SerchFile.Name),PChar(PathPolz),False);
     PathPolz:=Block365P.Path.Polzovatel;
     PathPolz:=PathPolz+DateToStr(Date);
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+'��������� ��';
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+SerchFile.Name;
     MoveFile(PChar(Block365P.Path.TempFile+SerchFile.Name),PChar(PathPolz+'.txt'));
     ColCvit:=ColCvit+1;
    End;
   End;
   If Pos('IZVTUB',SerchFile.Name)>0 then
   Begin
    Error:=True;
    f:=TStringList.Create();
    f.LoadFromFile(Block365P.Path.TempFile+SerchFile.Name);
    For I:=0 To f.Count-1 do
    Begin
     S:=f[I];
     {01@@@}
     If Pos('01@@@',S)>0 then Error:=False;
    End;
    f.Free;
    If Error=True then
    Begin
     {����� ����� ����� ���������� �� ������}
     PathPolz:=Block365P.Path.Arh;
     PathPolz:=PathPolz+DateToStr(Date);
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+'��������� �� ������';
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+SerchFile.Name;
     MoveFile(PChar(Block365P.Path.TempFile+SerchFile.Name),PChar(PathPolz));
     Form1.ListBox4.Items.Add('�� ������� ��������� �� ����� ��');
     Form1.ListBox3.Items.Add('�� ������� ��������� �� ����� ��');
     LoadLog('Adm','�� ������� ��������� �� ����� ��');
    End;
    If Error=False then
    Begin
     PathPolz:=Block365P.Path.Arh;
     PathPolz:=PathPolz+DateToStr(Date);
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+'��������� ��';
     if DirectoryExists(PathPolz)=false then CreateDir(PathPolz);
     PathPolz:=PathPolz+'\'+SerchFile.Name;
     MoveFile(PChar(Block365P.Path.TempFile+SerchFile.Name),PChar(PathPolz));
     Form1.ListBox4.Items.Add('������� ��������� �� ����� ��');
     Form1.ListBox3.Items.Add('������� ��������� �� ����� ��');
     LoadLog('Adm','������� ��������� �� ����� ��');
    End;
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 If ColCvit>0 then
 Begin
  Form1.ListBox4.Items.Add('������� �������� �� ����� - '+IntToStr(ColCvit));
  Form1.ListBox3.Items.Add('������� �������� �� ����� - '+IntToStr(ColCvit));
  LoadLog('Adm','������� �������� �� ����� - '+IntToStr(ColCvit));
  LoadLog('365','������� �������� �� ����� - '+IntToStr(ColCvit));
 End;
 If ColPodp>0 then
 Begin
  Form1.ListBox4.Items.Add('������� �������� ��������� - '+IntToStr(ColPodp));
  Form1.ListBox3.Items.Add('������� �������� ��������� - '+IntToStr(ColPodp));
  LoadLog('Adm','������� �������� ��������� - '+IntToStr(ColPodp));
  LoadLog('365','������� �������� ��������� - '+IntToStr(ColPodp));
  Verba.Folder:=Block365P.Path.InPodp;
  Verba.FolderOut:=Block365P.Path.InPodpOut;
  Verba.SignFolder(1);
  Verba.Folder:=Block365P.Path.UnCript;
  Verba.FolderOut:=Block365P.Path.UnCriptOut;
  Verba.UncriptFolder(2);
  {���������� ����������� �������� �� ���������}
  FindRes:=Findfirst(Block365P.Path.InPodpOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block365P.Path.InPodpOut+SerchFile.Name),PChar(Block365P.Path.InArh+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  {���������� � ������� �������}
  FindRes:=Findfirst(Block365P.Path.UnCriptOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    if DirectoryExists(Block365P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block365P.Path.Polzovatel+DateToStr(Date));
    CopyFile(PChar(Block365P.Path.UnCriptOut+SerchFile.Name),PChar(Block365P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name+'.txt'),False);
    MoveFile(PChar(Block365P.Path.UnCriptOut+SerchFile.Name),PChar(Block365P.Path.InDiasoft+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
 End;
 ColCvit:=0;
 FindRes:=Findfirst(Block365P.Path.InArh+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   ColCvit:=ColCvit+1;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 {������� ������}
 If Reglament then
 Begin
  If ColCvit>0 then
  Begin
   DecodeDateTime(Now,myYear,myMonth,myDay,myHour,myMin,mySec,myMilli);
   S:=IntToStr(myYear);
   If myMonth<10 then S:=S+'0';
   S:=S+IntToStr(myMonth);
   If myDay<10 then S:=S+'0';
   S:=S+IntToStr(myDay)+'_0';
   S:=S+LoadPost('mz');
   ARJ.Comand:='ARJ32.EXE m -e '+Block365P.Path.InArh+'AFN_3510110_MIFNS00_'+S+'.ARJ '+Block365P.Path.InArh+'*.*';
   ARJ.RunArj;
   {����������� ����� 3 ��������}
   MoveFile(PChar(Block365P.Path.InArh+'AFN_3510110_MIFNS00_'+S+'.ARJ'),PChar(Block365P.Path.InPodp+'AFN_3510110_MIFNS00_'+S+'.ARJ'));
   Verba.Folder:=Block365P.Path.InPodp;
   Verba.FolderOut:=Block365P.Path.InPodpOut;
   Verba.SignFolder(1);
   Form1.ListBox4.Items.Add('������ ����� '+'AFN_3510110_MIFNS00_'+S+'.ARJ');
   Form1.ListBox3.Items.Add('������ ����� '+'AFN_3510110_MIFNS00_'+S+'.ARJ');
   LoadLog('Adm','������ ����� '+'AFN_3510110_MIFNS00_'+S+'.ARJ');
   ARJ.Comand:='makecab '+Block365P.Path.InPodpOut+'AFN_3510110_MIFNS00_'+S+'.ARJ '+Path.OutCB+'mz'+DayOfSymvol+LoadPost('mz')+'110.010';
   ARJ.RunArj;
   Form1.ListBox4.Items.Add('������ ����� '+'mz'+DayOfSymvol+LoadPost('mz')+'110.010');
   Form1.ListBox3.Items.Add('������ ����� '+'mz'+DayOfSymvol+LoadPost('mz')+'110.010');
   LoadLog('Adm','������ ����� '+'mz'+DayOfSymvol+LoadPost('mz')+'110.010');
   UpdatePost('mz',StrToInt(LoadPost('mz')));
   DeleteFile(Block365P.Path.InPodpOut+'AFN_3510110_MIFNS00_'+S+'.ARJ');
  End;
 End;
End;

Procedure Object365P.OutCB;
Var
 Error:Boolean;
 SerchFile:TSearchRec;
 FindRes:Integer;
 F:TStringList;
 S:String;
 PathPolz:String;
 I:Integer;
 ColCvit:Integer;
 ColPodp:Integer;
 myYear, myMonth, myDay : Word;
 myHour, myMin, mySec, myMilli : Word;
Begin
 {���������� �� �������� �������}
 ColCvit:=0;
 FindRes:=Findfirst(Block365P.Path.OutDiasoft+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   S:=SerchFile.Name;
   If Pos('PB2',S)=0 then
   Begin
    If Pos('.TXT',S)>0 then Delete(S,Pos('.TXT',S),4);
    If Pos('.txt',S)>0 then Delete(S,Pos('.txt',S),4);
    S:=S+'.VRB';
   End;
   if DirectoryExists(Block365P.Path.Arh+DateToStr(Date))=false then CreateDir(Block365P.Path.Arh+DateToStr(Date));
   CopyFile(PChar(Block365P.Path.OutDiasoft+SerchFile.Name),PChar(Block365P.Path.Arh+DateToStr(Date)+'\'+S),False);
   MoveFile(PChar(Block365P.Path.OutDiasoft+SerchFile.Name),PChar(Block365P.Path.InPodp+S));
   ColCvit:=ColCvit+1;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 if ColCvit>0 then
 Begin
  Form1.ListBox4.Items.Add('������� ������� � ��������� - '+IntToStr(ColCvit));
  Form1.ListBox3.Items.Add('������� ������� � ��������� - '+IntToStr(ColCvit));
  LoadLog('Adm','������� ������� � ��������� - '+IntToStr(ColCvit));
  LoadLog('365','������� ������� � ��������� - '+IntToStr(ColCvit));
  Verba.Folder:=Block365P.Path.InPodp;
  Verba.FolderOut:=Block365P.Path.InPodpOut;
  Verba.SignFolder(1);
  ColPodp:=0;
  FindRes:=Findfirst(Block365P.Path.InPodpOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    If Pos('PB2_',SerchFile.Name)>0 then
    Begin
     MoveFile(PChar(Block365P.Path.InPodpOut+SerchFile.Name),PChar(Block365P.Path.InArh+SerchFile.Name));
    End
    Else
    Begin
     MoveFile(PChar(Block365P.Path.InPodpOut+SerchFile.Name),PChar(Block365P.Path.InCript+SerchFile.Name));
     ColPodp:=ColPodp+1;
    End;
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  If ColPodp>0 then
  Begin
   Verba.Folder:=Block365P.Path.InCript;
   Verba.FolderOut:=Block365P.Path.InCriptOut;
   Verba.CriptFolder(2);
   FindRes:=Findfirst(Block365P.Path.InCriptOut+'*.*',faAnyFile,SerchFile);
   While FindRes=0 do
   Begin
    If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
    Begin
     MoveFile(PChar(Block365P.Path.InCriptOut+SerchFile.Name),PChar(Block365P.Path.InArh+SerchFile.Name));
    End;
    FindRes:=FindNext(SerchFile);
   End;
   FindClose(SerchFile);
  End;
 End;
End;

end.
