unit uClassEmail;

interface

uses
IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
IdExplicitTLSClientServerBase,Vcl.StdCtrls, System.SysUtils, Vcl.Dialogs,
System.UITypes;

type
 TMail = class

  Strict Private
  // Parametros de Configuração de Email
  Port: integer; // porta do servidor de email ex // ''''''''465'''''''' porta do gmail
  host: String; // host do servidor de email ex // ''''''''smtp.gmail.com'''''''' host do gmail
  UserName: string; // username do servidor de email ex // ''''''''devsouza01@gmail.com''''''''
  Password: String; // Senha do Username(Email) do servidor de Email
  // Conteudo da Mensagem

  private
    IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    IdText: TIdText;
    IdAttachment: TIdAttachmentFile;
    // Conteudo do Email
    FFromAddress: String; // Endereco de Partida
    FFromName: String; // Nome Do usuario de Partida
    FRecipientsAddress: String; // Endereco do Destinatario
    FBody: String; // Corpo da Mensagem
    FSubject: String; // Assunto
    FReplyToAddress: String; // Responder a
    FAttachment: String; // Caminho do Anexo
    procedure SetBody(const Value: String);
    procedure SetFromAddress(const Value: String);
    procedure SetFromName(const Value: String);
    procedure SetRecipientsAddress(const Value: String);
    procedure SetReplyToAddress(const Value: String);
    procedure SetSubject(const Value: String);
    procedure SetAttachment(const Value: String);
    function GetAttachment: String;
    function GetBody: String;
    function GetFromAddress: String;
    function GetFromName: String;
    function GetRecipientsAddress: String;
    function GetReplyToAddress: String;
    function GetSubject: String;

  Public
    // proriedades
    property FromAddress : String read GetFromAddress write SetFromAddress;
    property FromName : String read GetFromName write SetFromName;
    property ReplyToAddress : String read GetReplyToAddress write SetReplyToAddress;
    property RecipientsAddress : String read GetRecipientsAddress write SetRecipientsAddress;
    property Subject : String read GetSubject write SetSubject;
    Property Body : String read GetBody write SetBody;
    property Attachment : String read GetAttachment write SetAttachment;

    // Metodos
    procedure Send(); // Procedure para enviar Email
    constructor Create();
    destructor Destroy();override;
End;

implementation

{ TMail }

constructor TMail.Create;
begin

  Self.Port := 465;
  Self.host := 'smtp.gmail.com';

  //Email do SMTP - Já está padronizado para Gmail
  Self.UserName := '';

  //Senha do Gmail
  Self.Password := '';

  // instanciação dos objetos Necesarios
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create();
  IdSMTP := TIdSMTP.Create();
  IdMessage := TIdMessage.Create();
  try
    // Configuração do protocolo SSL (TIdSSLIOHandlerSocketOpenSSL)
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    // Configuração do servidor SMTP (TIdSMTP)
    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS := utUseImplicitTLS;
    IdSMTP.AuthType := satDefault;

    // Configuração do servidor de Email
    IdSMTP.Port := Self.Port;
    IdSMTP.host := Self.host;
    IdSMTP.UserName := Self.UserName;
    IdSMTP.Password := Self.Password;

  except
    on e: Exception do
      ShowMessage('Erro ao instanciar Email.');
  end;
end;

destructor TMail.Destroy;
begin
  FreeAndNil(IdSSLIOHandlerSocket);
  FreeAndNil(IdSMTP);
  FreeAndNil(IdMessage);
inherited;
end;

function TMail.GetAttachment: String;
begin
  Result := FAttachment;
end;

function TMail.GetBody: String;
begin
  Result := FBody;
end;

function TMail.GetFromAddress: String;
begin
  Result := FFromAddress;
end;

function TMail.GetFromName: String;
begin
  Result := FFromName;
end;

function TMail.GetRecipientsAddress: String;
begin
  Result := FRecipientsAddress;
end;

function TMail.GetReplyToAddress: String;
begin
  Result := FReplyToAddress;
end;

function TMail.GetSubject: String;
begin
  Result := FSubject;
end;

procedure TMail.Send;
begin
  try

    // Configuração da mensagem (TIdMessage)
    IdMessage.From.Address := self.FromAddress;
    IdMessage.From.Name := self.FromName;
    IdMessage.ReplyTo.EMailAddresses := self.ReplyToAddress;
    IdMessage.Recipients.Add.Text := self.RecipientsAddress;
    IdMessage.Subject := self.Subject;
    IdMessage.Encoding := meMIME;

    IdText := TIdText.Create(IdMessage.MessageParts);

    IdText.Body.Add(self.Body);

    IdText.ContentType := 'text/html; charset=utf-8';


    IdAttachment := TIdAttachmentFile.Create(IdMessage.MessageParts,Attachment);

  except
    on e : Exception do
      ShowMessage(e.Message);
  end;

  try
    // Conexão e autenticação
    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
        Exit;
      end;
    end;

    // Envio da mensagem
    try
      IdSMTP.Send(IdMessage);
      ShowMessage('Mensagem Enviada!');
    except
      On e: Exception do
        ShowMessage(e.Message);
    end;
  finally
    IdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
  end;
end;

procedure TMail.SetAttachment(const Value: String);
begin
  FAttachment := Value;
end;

procedure TMail.SetBody(const Value: String);
begin
  FBody := Value;
end;

procedure TMail.SetFromAddress(const Value: String);
begin
  FFromAddress := Value;
end;

procedure TMail.SetFromName(const Value: String);
begin
  FFromName := Value;
end;

procedure TMail.SetRecipientsAddress(const Value: String);
begin
  FRecipientsAddress := Value;
end;

procedure TMail.SetReplyToAddress(const Value: String);
begin
  FReplyToAddress := Value;
end;

procedure TMail.SetSubject(const Value: String);
begin
  FSubject := Value;
end;

end.
