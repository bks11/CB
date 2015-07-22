unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, DockTabSet, StdCtrls, CheckLst, ExtCtrls, ComCtrls, Buttons,
  WideStrings, FMTBcd, DB, SqlExpr;

Type

 Object311P = Object
  Path : record
   InS:String;
   InP:String;
   OutP:String;
   InK:String;
   OutK:String;
   InArh:String;
   OutArh:String;
   InPAr:String;
   OutPAr:String;
   InPak:String;
   OutPak:String;
   InCB:String;
   OutCB:String;
  End;
  Procedure LoadPath; {��������� ���� � ������}
  Procedure SozdPath; {������� �������� ���� �� ���}
 End;

implementation

Uses
 Unit1;

Procedure Object311P.LoadPath;
Var
 Pathh:String;
Begin
 {Form1.SQLQuery1.SQL.Clear;
 Form1.SQLQuery1.SQL.Add('select * from Path_311 where Id=1');
 Form1.SQLQuery1.Active:=True;
 Pathh:=Form1.SQLQuery1.FieldByName('Path').AsString;
 Form1.SQLQuery1.Active:=False; }
 Path.InS:='D:\CB\311\���������\';
 Path.InP:='D:\CB\311\�� �������\';
 Path.OutP:='D:\CB\311\� �������\';
 Path.InK:='D:\CB\311\�� �����������\';
 Path.OutK:='D:\CB\311\� �����������\';
 Path.InArh:='D:\CB\311\�� ���������\';
 Path.OutArh:='D:\CB\311\� ���������\';
 Path.InPAr:='D:\CB\311\�� ������� ������\';
 Path.OutPAr:='D:\CB\311\� ������� ������\';
 Path.InPak:='D:\CB\311\�� �������������\';
 Path.OutPak:='D:\CB\311\� �������������\';
 Path.InCB:='D:\CB\311\�� ��\';
 Path.OutCB:='D:\CB\311\� ��\';
End;

Procedure Object311P.SozdPath;
Begin
 if DirectoryExists('D:\CB')=false then CreateDir('D:\CB');
 {������� ����� �������� ������}
 if User.Prava.Verba then
 Begin
  if DirectoryExists('D:\CB\�����\')=false then CreateDir('D:\CB\�����\');
  if DirectoryExists('D:\CB\�����\311\')=false then CreateDir('D:\CB\�����\311\');
  if DirectoryExists('D:\CB\�����\311\�� �������\')=false then CreateDir('D:\CB\�����\311\�� �������\');
  if DirectoryExists('D:\CB\�����\311\� �������\')=false then CreateDir('D:\CB\�����\311\� �������');
  if DirectoryExists('D:\CB\�����\311\�� �����������\')=false then CreateDir('D:\CB\�����\311\�� �����������');
  if DirectoryExists('D:\CB\�����\311\� �����������\')=false then CreateDir('D:\CB\�����\311\� �����������');
  if DirectoryExists('D:\CB\�����\311\�� ������� ������\')=false then CreateDir('D:\CB\�����\311\�� ������� ������');
  if DirectoryExists('D:\CB\�����\311\� ������� ������\')=false then CreateDir('D:\CB\�����\311\� ������� ������');
 End;
 if User.Prava.P311 then
 Begin
  if DirectoryExists('D:\CB\311\')=false then CreateDir('D:\CB\311\');
  if DirectoryExists('D:\CB\311\')=false then CreateDir('D:\CB\311\');
 End;
End;

end.
