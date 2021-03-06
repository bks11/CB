unit Cripto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ShellApi;

Const
 NAME_LEN=12;
 ALIAS_LEN=120;
type

  Check_Status = Record
   Name : Array [0..NAME_LEN] Of Char;
   Alias : Array [0..ALIAS_LEN] Of Char;
   Position : Byte;
   Status : Byte;
   Date : DWORD;
  End;
  pCheck_Status=^ACheck_Status;
  ACheck_Status = Array [0..0] Of Check_Status;
  TVerba = Object
   PathFileIn:String;
   PathFileOut:String;
   Key:Array [1..8] Of String;
   OpenKey:Array [1..4] Of String;
   PathKey:Array [1..4] Of String;
   PathOpenKey:Array [1..4] Of String;
   Folder:String;
   FolderOut:String;
   public
    { Private declarations }
   Procedure VerbaInit;{������������� 2 ������}
   Procedure RepathFile;{���������� // � ���� � �����}
   Function Uncript(KeyId:Integer):Word;{�������������}
   Function UncriptFolder(KeyId:Integer):Word;{�������������}
   Function Cript(KeyId:Integer):Word;{������������}
   Function CriptFolder(KeyId:Integer):Word;{������������}
   Function Sign(KeyId:Integer):Word;{���������}
   Function SignFolder(KeyId:Integer):Word;{���������}
   Function UnCaFolder(KeyId:Integer):Word;
   procedure VInitAsrKey;
  End;

implementation

Uses
 uMain;

{$R *.dfm}

{******������� ������������� � ���������� ������ � �����������*******}
{PathToSecret - ���� � �������� ������ ����������}
{PathToBase - ���� � �������� ������}
function CryptoInit(PathToSecret,PathToBase:String ):Word;
 stdcall; external 'WBOTHO.DLL' name 'CryptoInit';
function SignInit(PathToSecret,PathToBase:String ):Word;
 stdcall; external 'WBOTHO.DLL' name 'SignInit';
function SignDone:Word;
 stdcall; external 'WBOTHO.DLL' name 'SignDone';
function CryptoDone:Word;
 stdcall; external 'WBOTHO.DLL' name 'CryptoDone';
{***************���������� ������****************}
{�������� ������������� ����� ��������, �������������� ����}
{path - ���� � �������������� �����}
{sender_id - ��������� ��� ������ � 10-�������� ���������������}
function GetFileSenderID(path,sender_id:LPSTR):Word;
  stdcall; external 'WBOTHO.DLL' name 'GetFileSenderID';
{�������� ������ ���������, ������� ��������� ����}
{file_name - ������������� ����}
{abonents - ����� �����������}
{user_list - ������ ���������}
{ser - ����� �������(�����), ������ ��������� ����}
function GetCryptKeysF(file_name:LPSTR; abonents:PWORD;user_list:PWORD;ser:LPSTR):Word;
 stdcall; external 'WBOTHO.DLL' name 'GetCryptKeysF';
{file_in - �������� ����}
{file_out - ������������� ����}
{From - ������������� ����� ����������� ("XXXXSSSSSS")}
{open_keys_array - ������ ���������� �� �������� ����� �����������}
{open_keys_quantity - ���������� �����������}
function EnCryptFileEx(file_in,file_out,From:LPSTR;Open_Key_Array:Pointer;Open_Keys_Quantity:Word;Flags:DWORD):WORD;
 stdcall; external 'WBOTHO.DLL' name 'EnCryptFileEx';
{file_in - �������� ����}
{file_out - ������������� ����}
{node_From - ���� �������������}
{node_To - ������ ����������������� ������� �����������,}
{ser - ����� �������(�����), ���� ������������ ����}
function EnCryptFile(file_in,file_out:LPSTR;node_From:WORD;node_To:PWORD;ser:LPSTR):WORD ;
  stdcall; external 'WBOTHO.DLL' name 'EnCryptFile';
{file_in - ������������� ����}
{file_out - �������������� ����}
{abonent - ������������� �����  ����������("XXXXSSSSSS")}
{pub_key - ��������� �� �������� ���� �����������}
function DeCryptFileEx(file_in,file_out,abonent:LPSTR;pub_key:Pointer):WORD;
 stdcall; external 'WBOTHO.DLL' name 'DeCryptFileEx';
{*********������������ ���������� �����**************}
{buff - ��������� �� ����� ��� ��������� ������������������}
{rnd_size - ����� ��������� ������������������}
function Rndm(buff:Pointer;rnd_size:DWORD):WORD;
 stdcall; external 'WBOTHO.DLL' name 'Rndm';
function InitRndm (key_dev:String; key_ID:DWORD):WORD;
  stdcall; external 'WBOTHO.DLL' name 'InitRndm';
{*************�������� � �������� ����� �������***********************}
{path - ������ ���� � ����� � ��������� ������ �������}
function SignLogIn(path:LPSTR):WORD;
 stdcall; external 'WBOTHO.DLL' name 'SignLogIn';
function SignLogOut:WORD;
 stdcall; external 'WBOTHO.DLL' name 'SignLogOut';
{************������� � �������� �������***********}
{src_file_name - ��� �������������� �����}
{dst_file_name - ��� ������������ �����}
{name - ������������� ��������}
function SignFile(src_file_name,dst_file_name,name:LPSTR):WORD;
 stdcall; external 'WBOTHO.DLL' name 'SignFile';
{file_name - ������ ��� �����}
{count - ����� ������������ ��������}
{stat_array- ������ ����������� �������� ������ �������}
function check_file_sign(file_name:LPSTR;count:PByte;stat_array:pCheck_Status):WORD;
 stdcall; external 'WBOTHO.DLL' name 'check_file_sign';
procedure FreeMemory (lpMemory:Pointer);
 stdcall; external 'WBOTHO.DLL' name 'FreeMemory';
{file_name - ������ ��� �����}
{count - ���-�� ��������� �������� (-1)������� ��� �������}
function DelSign(file_name:LPSTR;count:Byte):WORD;
 stdcall; external 'WBOTHO.DLL' name 'DelSign';
{**************�������� �������� ���� �� �����������************}
{base_dir - ������� ���� � ����������� �������� ������}
{open_key_ID - ������������� ��������� �����}
{key - ��������� �� ����� ��� ��������� ����� 304 �����}
function ExtractKey(base_dir,open_key_ID:LPSTR;key:Pointer):WORD;
 stdcall; external 'WBOTHO.DLL' name 'ExtractKey';
{******** �������  ������ � ������� ************}
{key_dev - ������ � ������ ��������� ���������� ��� ���������� ��������� ������}
{key_ID  - ������������� ����� ��� ������ ������ ("")}
{function InitKey (key_dev:String; key_ID:String):Word;}
function InitKey (key_dev:Pointer; key_ID:LPSTR):WORD;
 stdcall; external 'WBOTHO.DLL' name 'InitKey';
{key_ID - ������������� �����}
{flag   - ������� ����������� �������� ����� �� "�����"0}
function ResetKeyEx(key_ID:LPSTR;flag:Integer):Word;
  stdcall; external 'WBOTHO.DLL' name 'ResetKeyEx';

Procedure TVerba.VerbaInit;{}
Begin
 {Key[1]:='2110941035';}
 Key[1]:='5110941035';
 {Key[2]:='6419941009';}
 Key[2]:='2291942009';
 {Key[3]:='2110941035';}
 Key[3]:='5110941035';
 Key[4]:='2110941035';
 Key[5]:='2110941035';
 Key[6]:='2110941035';
 Key[7]:='2110941035';
 Key[8]:='2110941035';
 OpenKey[1]:='941035';
 OpenKey[2]:='941009';
 OpenKey[3]:='941035';
 OpenKey[4]:='941009';
 PathKey[1]:='A:\';
 {PathKey[2]:='A:\';}
 PathKey[2]:='G:\';
 PathKey[3]:='H:\';
 PathKey[4]:='I:\';
 PathOpenKey[1]:='c:\\Verba\\1\\';
 PathOpenKey[2]:='c:\\Verba\\2\\';
 PathOpenKey[3]:='c:\\Verba\\3\\';
 PathOpenKey[4]:='c:\\Verba\\4\\';
 if Verba.Path311.Sertifikat311Sign<>'' then PathOpenKey[1]:=StringReplace(Verba.Path311.Sertifikat311Sign,'\', '\\', [rfReplaceAll, rfIgnoreCase]);

End;

Procedure TVerba.RepathFile;{���������� // � ���� � �����}

Begin
 PathFileIn:= StringReplace(PathFileIn,'\', '\\', [rfReplaceAll, rfIgnoreCase]);
 PathFileOut:= StringReplace(PathFileOut,'\', '\\', [rfReplaceAll, rfIgnoreCase]);
End;

Function TVerba.Uncript(KeyId:Integer):Word;{������������� 3 ������}
var
 err_code:Word;
 sender_key:array [0..304] of byte;
begin
 RepathFile;
 Result:=0;
 err_code:=InitRndm(PathKey[KeyId], 1);
 Result:=err_code;
 if err_code = 0 then begin
  err_code:=CryptoInit(PathKey[KeyId],PathOpenKey[KeyId]);
  Result:=err_code;
  if err_code = 0 then begin
   err_code:=GetFileSenderID(PChar(PathFileIn), PChar(Key[KeyId+4]));
   Result:=err_code;
   if err_code = 0 then begin
    err_code:=ExtractKey(PChar(Cripto.PathOpenKey[KeyId]),PChar(Key[KeyId+4]), @sender_key);
    Result:=err_code;
    if err_code = 0 then begin
     err_code:=DeCryptFileEx (PChar(PathFileIn), PChar(PathFileOut),PChar(Key[KeyId]) , @sender_key);
     Result:=err_code;
    end;
   end;
  end;
  CryptoDone;
 end;

End;

Function TVerba.UncriptFolder(KeyId:Integer):Word;{������������� 3 ������}
var
 err_code:Word;
 sender_key:array [0..304] of byte;
 FindRes:Integer;
 SerchFile:TSearchRec;
begin
 Result:=0;
 err_code:=InitRndm(PathKey[KeyId], 1);
 Result:=err_code;
 if err_code = 0 then begin
  err_code:=CryptoInit(PathKey[KeyId],PathOpenKey[KeyId]);
  Result:=err_code;
  if err_code = 0 then begin
   FindRes:=Findfirst(Folder+'*.*',faAnyFile,SerchFile);
   {������ ��� � ���������}
   While FindRes=0 do
   Begin
    If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
    Begin
     PathFileIn:=Cripto.Folder+SerchFile.Name;
     PathFileOut:=Cripto.FolderOut+SerchFile.Name;
     err_code:=GetFileSenderID(PChar(PathFileIn), PChar(Key[KeyId+4]));
     Result:=err_code;
     if err_code = 0 then
     begin
      err_code:=ExtractKey(PChar(Cripto.PathOpenKey[KeyId]),PChar(Key[KeyId+4]), @sender_key);
      Result:=err_code;
      if err_code = 0 then
      begin
       err_code:=DeCryptFileEx (PChar(PathFileIn), PChar(PathFileOut),PChar(Key[KeyId]) , @sender_key);
       Result:=err_code;
       If Result=0 then
       Begin
        DeleteFile(PathFileIn);
       End;
       If Result>0 then
       Begin
        Break;
       End;
      End;
     End;
     If err_code=29 then MoveFile(PChar(PathFileIn),PChar(PathFileOut));
    end;
    FindRes:=FindNext(SerchFile);
   end;
   FindClose(SerchFile);
  end;
  CryptoDone;
 end;
End;

Function TVerba.Sign(KeyId:Integer):Word;{������������� 3 ������}
var
 err_code: Word;
begin
 err_code:=InitKey(PChar(PathKey[KeyId]),'');
 Result:=err_code;
 if err_code = 0 then
 begin
  err_code := SignInit(PChar(PathKey[KeyId]), PChar(PathOpenKey[KeyId]));
  Result:=err_code;
  if err_code = 0 then
  begin
   err_code := SignFile(PChar(PathFileIn), PChar(PathFileOut), PChar(Key[KeyId]+'02'));
   Result:=err_code;
   SignDone;
   ResetKeyEx(PChar(Key[KeyId]+'02'), 1);
  End;
 End;
end;

Function TVerba.SignFolder(KeyId:Integer):Word;{������������� 3 ������}
var
 ColFiles:Integer;
 err_code: Word;
 FindRes:Integer;
 SerchFile:TSearchRec;
begin
 ColFiles:=0;
 err_code:=InitKey(PChar(PathKey[KeyId]),'');
 Result:=err_code;
 If err_code>0 then
 Begin
 End;
 if err_code = 0 then
 begin
  err_code := SignInit(PChar(PathKey[KeyId]), PChar(PathOpenKey[KeyId]));
  Result:=err_code;
  If err_code>0 then
  Begin
  End;
  if err_code = 0 then
  begin
   FindRes:=Findfirst(Folder+'*.*',faAnyFile,SerchFile);
   {������ ��� � ���������}
   While FindRes=0 do
   Begin
    If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
    Begin
     PathFileIn:=Cripto.Folder+SerchFile.Name;
     PathFileOut:=Cripto.FolderOut+SerchFile.Name;
     If KeyId=1 then err_code := SignFile(PChar(PathFileIn), PChar(PathFileOut), PChar(Key[KeyId]+'02'));
     If KeyId=3 then err_code := SignFile(PChar(PathFileIn), PChar(PathFileOut), PChar(Key[KeyId]+'01'));
     If err_code>0 then
     Begin
     End;
     Result:=err_code;
     If Result=0 then
     Begin
      DeleteFile(PathFileIn);
      ColFiles:=ColFiles+1;
     End;
     If Result>0 then Break;
    End;
    FindRes:=FindNext(SerchFile);
   End;
   FindClose(SerchFile);
  End;
  SignDone;
 End;
 If KeyId=1 then ResetKeyEx(PChar(Key[KeyId]+'02'), 1);
 If KeyId=3 then ResetKeyEx(PChar(Key[KeyId]+'01'), 1);
 If ColFiles>0 then
 Begin
 End;
end;

Function TVerba.Cript(KeyId:Integer):Word;{�������������}
var
 err_code, from: Word;
 CAbonent: array [0..1] of word;
begin
 err_code:=InitKey(PChar(PathKey[KeyId]),PChar(Key[KeyId]));
 Result:=err_code;
 if err_code = 0 then
 begin
  err_code:=CryptoInit(PathKey[KeyId],PathOpenKey[KeyId]);
  Result:=err_code;
  if err_code = 0 then
  begin
   CAbonent[0]:=StrToInt('0020'); CAbonent[1]:=0; from:=StrToInt(copy(Key[KeyId], 1, 4));
   Result := EnCryptFile(PChar(PathFileIn), PChar(PathFileOut), from, @CAbonent, PChar(copy(Key[KeyId], 5, 6)));
  end;
  CryptoDone;
  ResetKeyEx(PChar(Key[KeyId]), 1);
 End;
End;

Function TVerba.CriptFolder(KeyId:Integer):Word;{�������������}
var
 err_code, from: Word;
 ColFiles:Integer;
 CAbonent: array [0..1] of word;
 FindRes:Integer;
 SerchFile:TSearchRec;
begin
 err_code:=InitKey(PChar(PathKey[KeyId]),PChar(Key[KeyId]));
 Result:=err_code;
 if err_code = 0 then
 begin
  err_code:=CryptoInit(PathKey[KeyId],PathOpenKey[KeyId]);
  Result:=err_code;
  if err_code = 0 then
  begin
   CAbonent[0]:=StrToInt('9020'); CAbonent[1]:=0; from:=StrToInt(copy(Key[KeyId], 1, 4));
   FindRes:=Findfirst(Folder+'*.*',faAnyFile,SerchFile);
   {������ ��� � ���������}
   ColFiles:=0;
   While FindRes=0 do
   Begin
    If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
    Begin
     PathFileIn:=Cripto.Folder+SerchFile.Name;
     PathFileOut:=Cripto.FolderOut+SerchFile.Name;
     err_code:=EnCryptFile(PChar(PathFileIn), PChar(PathFileOut), from, @CAbonent, PChar(copy(Key[KeyId], 5, 6)));
     If err_code>0 then
     Begin
     End;
     Result:=err_code;
     If Result=0 then
     Begin
      DeleteFile(PathFileIn);
      ColFiles:=ColFiles+1;
     End;
     If Result>0 then Break;
    End;
    FindRes:=FindNext(SerchFile);
   End;
   FindClose(SerchFile);
  end;
  CryptoDone;
 End;
 ResetKeyEx(PChar(Key[KeyId]), 1);
 If ColFiles>0 then
 Begin
 End;
End;

Function TVerba.UnCaFolder(KeyId:Integer):Word;{�������������}
var
 err_code, from: Word;
 ColFiles:Integer;
 CAbonent: array [0..1] of word;
 FindRes:Integer;
 SerchFile:TSearchRec;
begin

 err_code:=InitRndm(PathKey[KeyId], 1);
 if err_code = 0 then
 begin
  err_code := SignInit(PChar(PathKey[KeyId]), PChar(PathOpenKey[KeyId]));
  Result:=err_code;
  if err_code = 0 then
  begin
   FindRes:=Findfirst(Folder+'*.*',faAnyFile,SerchFile);
   {������ ��� � ���������}
   ColFiles:=0;
   While FindRes=0 do
   Begin
    If (SerchFile.Name<>'.') and (SerchFile.Name<>'..') then
    Begin
     err_code:=DelSign(PChar(Folder+SerchFile.Name), 255);
     Result:=err_code;
     If err_code>0 then
     Begin
      Result:=err_code;
     End
     Else
     Begin
      ColFiles:=ColFiles+1;
     End;
    End;
    FindRes:=FindNext(SerchFile);
   End;
   FindClose(SerchFile);
  End;
 End;
 SignDone;
End;



{1. ������������� ������� ��������� �����:}
{������ 1. ��������� ��� ������������, ����� ���� asrkeyw.exe:}

procedure InitAsrKey;
var
 HWind, H1: HWND;
 Wind: String;
begin
 Wind:='asrkeyw';
 if ShellExecute(0,'open', PChar(Wind+'.exe'), nil, nil, SW_SHOWMINNOACTIVE) > 31 then begin
  HWind:=0;
  Repeat
   HWind:=FindWindow(nil, PChar(Wind));
  Until HWind<>0; //�����
  While not IsWindowVisible(HWind) do Application.ProcessMessages;
  // ���� �� ��������������� ������ ��������� �����, �� ������ �������������
  Repeat
   H1:=FindWindowEx(HWind, 0, 'Static', '��������� ����� ������� ��� ����������  ����� ...');
  Until H1<>0;
  while IsWindowVisible(H1) do begin
   SendMessage(HWind,WM_LButtonDown,1,1);
   SendMessage(HWind,WM_LButtonUp  ,1,1);
   Application.ProcessMessages;
  end;
  SendMessage (HWind, WM_CLOSE, 0, 0);
 end;
end;

Procedure TVerba.VInitAsrKey;
Begin
 InitAsrKey;
End;

{6. ������� ������� � �����, ������� ������� ��� ���������������, ��������� ���������� mpacker.dll:}
function DeCompressFile (infile, outfile: LPSTR):WORD; cdecl external 'mpacker.dll' name 'DeCompressFile';
procedure pDeSignFile (mFile: String);
var
 err_code: Word;
begin
 // ������� ��������������� ����
 DeCompressFile (PChar(mFile), PChar(mFile));
 // ������������� ������� ��������� �����
 err_code:=InitRndm(PChar('A:\'), 1);
 // ������������� �����������
 if err_code = 0 then begin
 // ������������� ����� �������
  err_code:=SignInit(PChar('A:'), PChar('����_��_������������'));
  if err_code = 0 then
   // �������� �������
   err_code:=DelSign(PChar(mFile), 255);
   // ���������� ������
   SignDone;
  end;
 End;

{7. �������������. ��� �� �� ������������ �������� � ���� �:, �� ������ ����������� ����� ����� �������� ����� ��� ������ �� ���� B:. ������� ����� �������������� � ���� �������:}
{function MapDisk(PathMap: String): Boolean;
var
 CurrentMap: String;
 function DiskPresent(Letter : Char) : Boolean;
 Begin
  Result:= ((GetLogicalDrives AND (Ord(Letter)-64)) > 0);
 End;
 function Subst: Boolean;
 begin
  Result:=True;
  if (not DefineDosDevice(0, PChar(DiskForSign + ':'), PChar(PathMap))) then begin
   AddLog('�� ������� ���������� ����������������� ���� [' + PathMap + '].');
   Result:=False;
  end else
  AddLog('�� ���������� ' + DiskForSign + ' ����������� ' + PathMap);
 end;
 function SubstQuery: string;
 var
  buff: array[0..256] of char;
  begin
   buff[0] := #0;
   QueryDosDevice(PChar(DiskForSign + ':'), buff, 256);
   Result := StrPas(buff);
   if Copy(Result,1,4) = '\??\' then Result := Copy(Result, 5, Length(Result)) else Result:='';
  end;
begin
 Result:=False;
 if DiskPresent(DiskForSign[1]) then
 begin
  CurrentMap := SubstQuery;
  if PathMap = CurrentMap then Result:=True
  else if (DefineDosDevice(DDD_REMOVE_DEFINITION, PChar(DiskForSign + ':'), PChar(CurrentMap))) then Result:=Subst
 end
 else Result:=Subst;
end;}


end.

