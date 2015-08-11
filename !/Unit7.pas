unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB, DBTables, Grids, DBGrids, ADODB, Mask,
  DBCtrls, DateUtils;

Type
 Object406P = Object {���������� ��� �����}
  TimeOutArh:Integer;
  Path : record
   OutCB:String;{�������� ������ � ��}
   InCB:String;{����� ������ �� ��}
   Arh:String;{������� ��� �������� ����� ������}
   Polzovatel:String;{������� ���� �������� ���������������� �����}
   InPodp:String;{���� ������ �� �������}
   InPodpOut:String;{���� ������ �� �������}
   InPodp3:String;{���� ������ �� �������}
   InPodpOut3:String;{���� ������ �� �������}
   UnCript:String;{���� ������ �� ������}
   UnCriptOut:String;{���� ������ �� ������}
   UnArh:String;{���� ��� �������}
   Temp:String;{���� ��� �������}
   UnCa3:String;{���� ��� ������ ��}
   TBSvkArh:String;{���� ��� �������� ������� � �����}
   TBSvkKvit:String;{���� ��� ��������� �� ������� �������� �����}
   TBSvkUnArh:String;{���� ��� ��������� ������� � �������� ����� ������� �����}
   TempArhReglament:String;{������� ��� �������� ������ ��������� ����� ����������}
  End;
  Procedure PathInit; {����������� ����� �� �������� � ���������}
  Procedure PriemCB; {������� ����� �� ��}
  Procedure OutCB; {������� ����� �� ��}
 End;


implementation

Uses
 Unit1,Unit2,Unit3, Math;

Procedure Object406P.PathInit; {����������� ����� �� �������� � ���������}
Begin
 Path.OutCB:='z:\!CBINFO\Out\';{�������� ������ � ��}
 Path.InCB:='z:\!CBINFO\In\';{����� ������ �� ��}
 Path.Arh:='d:\Archiv\406\';{������� ��� ������� �� ��}
 Path.Polzovatel:='z:\406\';{������� ��� ������ �������������}
 Path.InPodp:='z:\!InPodp\';{���� ������ �� �������}
 Path.InPodpOut:='z:\!InPodpOut\';{���� ������ �� �������}
 Path.InPodp3:='z:\!InPodp3\';{���� ������ �� �������}
 Path.InPodpOut3:='z:\!InPodp3Out\';{���� ������ �� �������}
 Path.UnCript:='z:\!UnCript2\';{���� ������ �� ������}
 Path.UnCriptOut:='z:\!UnCript2Out\';{���� ������ �� ������}
 Path.UnArh:='d:\Archiv\406\UnArh\';{���� ��� �������}
 Path.Temp:='d:\Archiv\406\Temp\';{���� ��� �������}
 Path.UnCa3:='z:\!UnCA3\';{���� ��� ������ ��}
 Path.TBSvkArh:='z:\RVK_10_0\RVK_10_0\iz_fts\406FZ\DT\';{���� ��� �������� ������� � �����}
 Path.TBSvkKvit:='z:\RVK_10_0\RVK_10_0\b_fts\406FZ\KVIT\';{���� ��� �������� ���������� � �����}
 Path.TBSvkUnArh:='z:\RVK_10_0\RVK_10_0\b_fts\406FZ\KESDT\'; {��� ������ ������ � ������� �������� ��������}
 Path.TempArhReglament:='d:\Archiv\406\TempUnarh\';{������� ��� �������� ������ ��������� ����� ����������}
End;

Procedure Object406P.PriemCB; {������� ����� �� ��}
Var
 ColFiles:Integer;
 SerchFile:TSearchRec;
 F:TStringList;
 Rez:Boolean;
 S:String;
 FindRes:Integer;
 I:Integer;
 myYear, myMonth, myDay : Word;
 myHour, myMin, mySec, myMilli : Word;
Begin
 {����������� ������� sz � ����������� ����}
 FindRes:=Findfirst(Block406P.Path.InCB+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If Pos('sz',SerchFile.Name)>0 then
   Begin
    Form1.ListBox6.Items.Add('������ ����� '+SerchFile.Name);
    Form1.ListBox3.Items.Add('������ ����� '+SerchFile.Name);
    LoadLog('Adm','������ ����� '+SerchFile.Name);
    ARJ.Comand:='expand -r '+Block406P.Path.InCB+SerchFile.Name+' '+Block406P.Path.UnArh;
    ARJ.RunArj;
    DeleteFile(Block406P.Path.InCB+SerchFile.Name);
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 {����������� ������ � ���������� �������� �� ���������}
 FindRes:=Findfirst(Block406P.Path.UnArh+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If (Pos('UVKESDT',SerchFile.Name)>0) then
   Begin
    {UVKESDT_2490_0003_20150312_001.txt}
    f:=TStringList.Create();
    f.LoadFromFile(Block406P.Path.UnArh+SerchFile.Name);
    Rez:=False;
    For I:=0 To f.Count-1 do
    Begin
     S:=f[I];
     {������}
     If Pos('������',S)>0 then Rez:=True;
    End;
    f.Free;
    If Rez then
    Begin
     Form1.ListBox6.Items.Add('������� ��������� �� ����������');
     Form1.ListBox3.Items.Add('������� ��������� �� ����������');
     LoadLog('Adm','������� ��������� �� ����������');
     LoadLog('406','������� ��������� �� ����������');
    End;
    If Rez=False then
    Begin
     Form1.ListBox6.Items.Add('�� ������� ��������� �� ����������');
     Form1.ListBox3.Items.Add('�� ������� ��������� �� ����������');
     LoadLog('Adm','�� ������� ��������� �� ����������');
     LoadLog('406','�� ������� ��������� �� ����������');
    End;
    if DirectoryExists(Block406P.Path.Arh+DateToStr(Date))=false then CreateDir(Block406P.Path.Arh+DateToStr(Date));
    if DirectoryExists(Block406P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block406P.Path.Polzovatel+DateToStr(Date));
    CopyFile(PChar(Block406P.Path.UnArh+SerchFile.Name),PChar(Block406P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
    MoveFile(PChar(Block406P.Path.UnArh+SerchFile.Name),PChar(Block406P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name));
   End;
   If (Pos('arj',SerchFile.Name)>0)or(Pos('ARJ',SerchFile.Name)>0) then
   Begin
    ARJ.Comand:='ARJ32.EXE x '+Block406P.Path.UnArh+SerchFile.Name+' '+Block406P.Path.Temp;
    ARJ.RunArj;
    CopyFile(PChar(Block406P.Path.UnArh+SerchFile.Name),PChar(Block406P.Path.UnCa3+SerchFile.Name),False);
    DeleteFile(Block406P.Path.UnArh+SerchFile.Name);
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 {��������� ����� ���������� � ������ �������� ��������}
 ColFiles:=0;
 FindRes:=Findfirst(Block406P.Path.Temp+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   {RESDT_2490_0003_20150313_001.txt}
   {DT10309200_100315_0001924_1_2490_0003_150000000037.xml}
   If ((Pos('DT',SerchFile.Name)>0) and (Pos('.xml',SerchFile.Name)>0)) or ((Pos('DT',SerchFile.Name)>0) and (Pos('.XML',SerchFile.Name)>0)) then
   Begin
    ColFiles:=ColFiles+1;
    MoveFile(PChar(Block406P.Path.Temp+SerchFile.Name),PChar(Block406P.Path.UnCript+SerchFile.Name));
   End;
   If ((Pos('RESDT',SerchFile.Name)>0) and (Pos('.txt',SerchFile.Name)>0)) or ((Pos('RESDT',SerchFile.Name)>0) and (Pos('.TXT',SerchFile.Name)>0)) then
   Begin
    DeleteFile(Block406P.Path.Temp+SerchFile.Name);
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 If ColFiles>0 then
 Begin
  Form1.ListBox6.Items.Add('��������� ���������� - '+IntToStr(ColFiles));
  Form1.ListBox3.Items.Add('��������� ���������� - '+IntToStr(ColFiles));
  LoadLog('Adm','��������� ���������� - '+IntToStr(ColFiles));
  LoadLog('406','��������� ���������� - '+IntToStr(ColFiles));
  {������������� ����������� ����������}
  Verba.Folder:=Block406P.Path.UnCript;
  Verba.FolderOut:=Block406P.Path.UnCriptOut;
  Verba.UncriptFolder(2);
  {���������� ���������� �� ������ ��}
  FindRes:=Findfirst(Block406P.Path.UnCriptOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block406P.Path.UnCriptOut+SerchFile.Name),PChar(Block406P.Path.UnCa3+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  {����� ��}
  Verba.Folder:=Block406P.Path.UnCa3;
  Verba.FolderOut:=Block406P.Path.UnCa3;
  Verba.UnCaFolder(3);
  {���������� ���������� �� ������}
  DecodeDateTime(Now,myYear,myMonth,myDay,myHour,myMin,mySec,myMilli);
  S:=IntToStr(myYear);
  if DirectoryExists(Block406P.Path.TBSvkArh+S)=false then CreateDir(Block406P.Path.TBSvkArh+S);
  S:=S+'\';
  If myMonth<10 then S:=S+'0';
  S:=S+IntToStr(myMonth);
  if DirectoryExists(Block406P.Path.TBSvkArh+S)=false then CreateDir(Block406P.Path.TBSvkArh+S);
  S:=S+'\';
  If myDay<10 then S:=S+'0';
  S:=S+IntToStr(myDay);
  if DirectoryExists(Block406P.Path.TBSvkArh+S)=false then CreateDir(Block406P.Path.TBSvkArh+S);
  FindRes:=Findfirst(Block406P.Path.UnCa3+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    if DirectoryExists(Block406P.Path.Arh+DateToStr(Date))=false then CreateDir(Block406P.Path.Arh+DateToStr(Date));
    if DirectoryExists(Block406P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block406P.Path.Polzovatel+DateToStr(Date));
    CopyFile(PChar(Block406P.Path.UnCa3+SerchFile.Name),PChar(Block406P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
    CopyFile(PChar(Block406P.Path.UnCa3+SerchFile.Name),PChar(Block406P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name),False);
    MoveFile(PChar(Block406P.Path.UnCa3+SerchFile.Name),PChar(Block406P.Path.TBSvkArh+S+'\'+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
 End;
End;

Procedure Object406P.OutCB; {������� ����� �� ��}
Var
 ColFiles:Integer;
 SerchFile:TSearchRec;
 F:TStringList;
 Rez:Boolean;
 S:String;
 FindRes:Integer;
 I:Integer;
 myYear, myMonth, myDay : Word;
 myHour, myMin, mySec, myMilli : Word;
Begin
 {����������� ������� �� ���� ��������}
 ColFiles:=0;
 DecodeDateTime(Now,myYear,myMonth,myDay,myHour,myMin,mySec,myMilli);
 S:=IntToStr(myYear);
 if DirectoryExists(Block406P.Path.TBSvkUnArh+S)=false then CreateDir(Block406P.Path.TBSvkUnArh+S);
 S:=S+'\';
 If myMonth<10 then S:=S+'0';
 S:=S+IntToStr(myMonth);
 if DirectoryExists(Block406P.Path.TBSvkUnArh+S)=false then CreateDir(Block406P.Path.TBSvkUnArh+S);
 S:=S+'\';
 If myDay<10 then S:=S+'0';
 S:=S+IntToStr(myDay);
 if DirectoryExists(Block406P.Path.TBSvkUnArh+S)=false then CreateDir(Block406P.Path.TBSvkUnArh+S);
 FindRes:=Findfirst(Block406P.Path.TBSvkKvit+S+'\'+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') and (SerchFile.Name<>'E') then
  Begin
   ColFiles:=ColFiles+1;
   if DirectoryExists(Block406P.Path.Arh+DateToStr(Date))=false then CreateDir(Block406P.Path.Arh+DateToStr(Date));
   if DirectoryExists(Block406P.Path.Polzovatel+DateToStr(Date))=false then CreateDir(Block406P.Path.Polzovatel+DateToStr(Date));
   CopyFile(PChar(Block406P.Path.TBSvkKvit+S+'\'+SerchFile.Name),PChar(Block406P.Path.Arh+DateToStr(Date)+'\'+SerchFile.Name),False);
   CopyFile(PChar(Block406P.Path.TBSvkKvit+S+'\'+SerchFile.Name),PChar(Block406P.Path.InPodp+SerchFile.Name),False);
   MoveFile(PChar(Block406P.Path.TBSvkKvit+S+'\'+SerchFile.Name),PChar(Block406P.Path.Polzovatel+DateToStr(Date)+'\'+SerchFile.Name));
  End;
  FindRes:=FindNext(SerchFile);  
 End;
 FindClose(SerchFile);
 If ColFiles>0 then
 Begin
  Verba.Folder:=Block406P.Path.InPodp;
  Verba.FolderOut:=Block406P.Path.InPodpOut;
  Verba.SignFolder(1);
  FindRes:=Findfirst(Block406P.Path.InPodpOut+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block406P.Path.InPodpOut+SerchFile.Name),PChar(Block406P.Path.TBSvkUnArh+S+'\'+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
  Form1.ListBox6.Items.Add('������� �������� �� ���������� - '+IntToStr(ColFiles));
  Form1.ListBox3.Items.Add('������� �������� �� ���������� - '+IntToStr(ColFiles));
  LoadLog('Adm','������� �������� �� ���������� - '+IntToStr(ColFiles));
  LoadLog('406','������� �������� �� ���������� - '+IntToStr(ColFiles));
 End;
 ColFiles:=0;
 FindRes:=Findfirst(Block406P.Path.TBSvkUnArh+S+'\'+'*.*',faAnyFile,SerchFile);
 While FindRes=0 do
 Begin
  If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
  Begin
   If (Pos('.arj',SerchFile.Name)>0) or (Pos('.ARJ',SerchFile.Name)>0) then
   Begin
    Block406P.TimeOutArh:=Block406P.TimeOutArh+1;
    If Block406P.TimeOutArh=6 then
    Begin
     Block406P.TimeOutArh:=0;
     MoveFile(PChar(Block406P.Path.TBSvkUnArh+S+'\'+SerchFile.Name),PChar(Block406P.Path.InPodp3+SerchFile.Name));
     Form1.ListBox6.Items.Add('������ ����� - '+SerchFile.Name);
     Form1.ListBox3.Items.Add('������ ����� - '+SerchFile.Name);
     LoadLog('Adm','������ ����� - '+SerchFile.Name);
     LoadLog('406','������ ����� - '+SerchFile.Name);
     ColFiles:=ColFiles+1
    End;
   End;
  End;
  FindRes:=FindNext(SerchFile);
 End;
 FindClose(SerchFile);
 If ColFiles>0 then
 Begin
  Verba.Folder:=Block406P.Path.InPodp3;
  Verba.FolderOut:=Block406P.Path.InPodpOut3;
  Verba.SignFolder(3);
  FindRes:=Findfirst(Block406P.Path.InPodpOut3+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    MoveFile(PChar(Block406P.Path.InPodpOut3+SerchFile.Name),PChar(Block406P.Path.TempArhReglament+SerchFile.Name));
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
 End;
 If Reglament then 
 Begin
  FindRes:=Findfirst(Block406P.Path.TempArhReglament+'*.*',faAnyFile,SerchFile);
  While FindRes=0 do
  Begin
   If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
   Begin
    ARJ.Comand:='makecab '+Block406P.Path.TempArhReglament+SerchFile.Name+' '+Path.OutCB+'sz'+DayOfSymvol+LoadPost('sz')+'110.010';
    ARJ.RunArj;
    Form1.ListBox6.Items.Add('������ ����� '+'sz'+DayOfSymvol+LoadPost('sz')+'110.010');
    Form1.ListBox3.Items.Add('������ ����� '+'sz'+DayOfSymvol+LoadPost('sz')+'110.010');
    LoadLog('Adm','������ ����� '+'sz'+DayOfSymvol+LoadPost('sz')+'110.010');
    UpdatePost('sz',StrToInt(LoadPost('sz')));
    DeleteFile(Block406P.Path.TempArhReglament+SerchFile.Name);
   End;
   FindRes:=FindNext(SerchFile);
  End;
  FindClose(SerchFile);
 End;
End;

end.
