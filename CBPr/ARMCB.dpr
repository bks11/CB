program ARMCB;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uRep311 in 'uRep311.pas',
  Data in 'Data.pas' {dmData: TDataModule},
  Arhivator in 'Arhivator.pas',
  Verba in 'Verba.pas',
  CriptoMudule in 'CriptoMudule.pas',
  krutilka in 'krutilka.pas',
  urep3251 in 'urep3251.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
