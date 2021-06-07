unit UTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,XMLDoc,IdHTTP, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,DBXJSON,
  FormatedGroupBox, Vcl.Mask,uClassEmail,Xml.XMLIntf;

type
  TForm1 = class(TForm)
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtLogradouro: TEdit;
    edtCidade: TEdit;
    edtEstado: TEdit;
    edtPais: TEdit;
    IdHTTP1: TIdHTTP;
    edtNome: TEdit;
    edtEmail: TEdit;
    FormatedGroupBox1: TFormatedGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    msCpf: TMaskEdit;
    edtIdentidade: TEdit;
    msTelefone: TMaskEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    msCep: TMaskEdit;
    btnGravar: TButton;
    procedure msCepExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }

  procedure consultaCep(ACep : string);
  procedure getValuesEngereco(AJSONObject : TJSONObject);
  procedure geraXML();
  procedure enviaEmail();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.btnGravarClick(Sender: TObject);
begin
  enviaEmail;
end;

procedure TForm1.consultaCep(ACep : string);
var
  TSConsulta   : TStringList;
  JSONObject   : TJSONObject;

begin
  TSConsulta := TStringList.Create;
  try

    TSConsulta.text    := idhttp1.URL.URLDecode(idhttp1.Get('http://viacep.com.br/ws/'+ ACep +'/json/'));

    JSONObject := TJSONObject.ParseJSONValue(UTF8Decode(TSConsulta.Text)) as TJSONObject;

    getValuesEngereco(JSONObject);

  finally
    FreeAndNil(TSConsulta);
  end;

end;

procedure TForm1.enviaEmail;
var
 email : TMail;
begin
  email := TMail.Create;

  try
    geraXML;

    //Email de quem est� enviando
    email.FromAddress :=  '';

    //Nome de quem est� enviando
    email.FromName    := '';

    //Email de destino
    email.RecipientsAddress := '';

    //Assunto
    email.Subject := '';

    //Corpo do email
    email.Body := '';

    //Caminho do arquivo XML
    //Deve ser o mesmo caminho onde foi salvo o XML
    email.Attachment := 'c:/XML/Dados.xml';

    email.Send;

  finally
    FreeAndNil(email);
  end;

end;

procedure TForm1.msCepExit(Sender: TObject);
begin
  if msCep.Text = '' then
  begin
    MessageDlg('Para realizar a consulta � necessario informar o CEP.',mtInformation,[mbOK],0);
    msCep.SetFocus;
    Exit;
  end;

  consultaCep(msCep.Text);
end;

procedure TForm1.geraXML;
var
 xml : TXMLDocument;
 xmlNode : IXmlNode;
 endereco : IXmlNode;
begin

  xml := TXMLDocument.Create(nil);

  try

     xml.Active := True;
     xmlNode := xml.AddChild('Cadastro');
     xmlNode.AddChild('Nome').NodeValue := edtNome.Text;
     xmlNode.AddChild('Identidade').NodeValue := edtIdentidade.Text;
     xmlNode.AddChild('CPF').NodeValue := msCpf.EditText;
     xmlNode.AddChild('telefone').NodeValue := msTelefone.EditText;
     xmlNode.AddChild('Email').NodeValue := edtEmail.Text;

     endereco := xml.CreateNode('Endereco', ntElement);
     endereco.AddChild('Cep').NodeValue := msCep.EditText;
     endereco.AddChild('Logradouro').NodeValue := edtLogradouro.Text;
     endereco.AddChild('Numero').NodeValue := edtNumero.Text;
     endereco.AddChild('Complemento').NodeValue := edtComplemento.Text;
     endereco.AddChild('Bairro').NodeValue := edtBairro.Text;
     endereco.AddChild('Cidade').NodeValue := edtCidade.Text;
     endereco.AddChild('Estado').NodeValue := edtEstado.Text;
     endereco.AddChild('Pais').NodeValue := edtPais.Text;

     xmlNode.ChildNodes.Add(endereco);

     xml.SaveToFile('c:/XML/Dados.xml');

  finally
  end;

end;

procedure TForm1.getValuesEngereco(AJSONObject: TJSONObject);
var
  lJsonValue : TJSONValue;
begin
  lJsonValue :=   AJSONObject.Get('logradouro').JsonValue;
  edtLogradouro.text := lJsonValue.Value;

  lJsonValue :=   AJSONObject.Get('complemento').JsonValue;
  edtComplemento.text := lJsonValue.Value;

  lJsonValue :=   AJSONObject.Get('bairro').JsonValue;
  edtBairro.text := lJsonValue.Value;

  lJsonValue :=   AJSONObject.Get('localidade').JsonValue;
  edtCidade.text := lJsonValue.Value;

  lJsonValue :=   AJSONObject.Get('uf').JsonValue;
  edtEstado.text := lJsonValue.Value;

end;

end.
