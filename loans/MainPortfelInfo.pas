unit MainPortfelInfo;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, DBCtrls, DataModule, ComCtrls, Mask;

type
  TMainPortfelInfo = class(TObject)
  public

    Procedure MainLoanPortfelLoadData; {�������� ������ �� �������}
end;


implementation

Uses
 Main;

Procedure TMainPortfelInfo.MainLoanPortfelLoadData;
{�������� ������}
Var
 SummRUR:Int64; {643}
 SummUSD:Int64; {840}
 SummEUR:Int64; {978}
 SummUAH:Int64; {980}
 SummZRUR:Int64; {643}
 SummZUSD:Int64; {840}
 SummZEUR:Int64; {978}
 SummZUAH:Int64; {980}
 SummTRUR:Int64; {643}
 SummTUSD:Int64; {840}
 SummTEUR:Int64; {978}
 SummTUAH:Int64; {980}
 SummPRUR:Int64; {643}
 SummPUSD:Int64; {840}
 SummPEUR:Int64; {978}
 SummPUAH:Int64; {980}
Begin
  SummRUR:=0; {643}
  SummUSD:=0; {840}
  SummEUR:=0; {978}
  SummUAH:=0; {980}
  SummZRUR:=0; {643}
  SummZUSD:=0; {840}
  SummZEUR:=0; {978}
  SummZUAH:=0; {980}
  SummTRUR:=0; {643}
  SummTUSD:=0; {840}
  SummTEUR:=0; {978}
  SummTUAH:=0; {980}
  SummPRUR:=0; {643}
  SummPUSD:=0; {840}
  SummPEUR:=0; {978}
  SummPUAH:=0; {980}
  MainForm.MainLoansList.DataSource.DataSet.First;
  while NOT MainForm.MainLoansList.DataSource.DataSet.Eof do begin
   if MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_CURRENCY').AsInteger=643  then
   Begin
    SummRUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_SUMM').AsInteger;
    SummZRUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('TOTAL_CREDIT_SUMM').AsInteger;
    SummTRUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('DEBT_OUT_OF_DATE').AsInteger;
    SummPRUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('PERCENT_OUT_OF_DATE').AsInteger;
   End;
   if MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_CURRENCY').AsInteger=840  then
   Begin
    SummUSD:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_SUMM').AsInteger;
    SummZUSD:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('TOTAL_CREDIT_SUMM').AsInteger;
    SummTUSD:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('DEBT_OUT_OF_DATE').AsInteger;
    SummPUSD:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('PERCENT_OUT_OF_DATE').AsInteger;
   End;
   if MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_CURRENCY').AsInteger=978  then
   Begin
    SummEUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_SUMM').AsInteger;
    SummZEUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('TOTAL_CREDIT_SUMM').AsInteger;
    SummTEUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('DEBT_OUT_OF_DATE').AsInteger;
    SummPEUR:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('PERCENT_OUT_OF_DATE').AsInteger;
   End;
   if MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_CURRENCY').AsInteger=980  then
   Begin
    SummUAH:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('LOAN_SUMM').AsInteger;
    SummZUAH:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('TOTAL_CREDIT_SUMM').AsInteger;
    SummTUAH:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('DEBT_OUT_OF_DATE').AsInteger;
    SummPUAH:=SummRUR+MainForm.MainLoansList.DataSource.DataSet.FieldByName('PERCENT_OUT_OF_DATE').AsInteger;
   End;
   MainForm.MainLoansList.DataSource.DataSet.Next;
  end;
  MainForm.MainInfoPortfelSumRUR.Caption:='� RUR - '+inttostr(SummRUR);
  MainForm.MainInfoPortfelSumUSD.Caption:='� USD - '+inttostr(SummUSD);
  MainForm.MainInfoPortfelSumEUR.Caption:='� EUR - '+inttostr(SummEUR);
  MainForm.MainInfoPortfelSumUAH.Caption:='� UAH - '+inttostr(SummUAH);

  MainForm.MainInfoPortfelSumZRUR.Caption:='� RUR - '+inttostr(SummZRUR);
  MainForm.MainInfoPortfelSumZUSD.Caption:='� USD - '+inttostr(SummZUSD);
  MainForm.MainInfoPortfelSumZEUR.Caption:='� EUR - '+inttostr(SummZEUR);
  MainForm.MainInfoPortfelSumZUAH.Caption:='� UAH - '+inttostr(SummZUAH);

  MainForm.MainInfoPortfelSumTRUR.Caption:='� RUR - '+inttostr(SummTRUR);
  MainForm.MainInfoPortfelSumTUSD.Caption:='� USD - '+inttostr(SummTUSD);
  MainForm.MainInfoPortfelSumTEUR.Caption:='� EUR - '+inttostr(SummTEUR);
  MainForm.MainInfoPortfelSumTUAH.Caption:='� UAH - '+inttostr(SummTUAH);

  MainForm.MainInfoPortfelSumPRUR.Caption:='� RUR - '+inttostr(SummPRUR);
  MainForm.MainInfoPortfelSumPUSD.Caption:='� USD - '+inttostr(SummPUSD);
  MainForm.MainInfoPortfelSumPEUR.Caption:='� EUR - '+inttostr(SummPEUR);
  MainForm.MainInfoPortfelSumPUAH.Caption:='� UAH - '+inttostr(SummPUAH);

End;


end.
