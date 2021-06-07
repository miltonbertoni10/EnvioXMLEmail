program Project1;

uses
  Vcl.Forms,
  UTeste in 'UTeste.pas' {Form1},
  uClassEmail in 'uClassEmail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
