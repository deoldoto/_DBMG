unit restRequestSingleton;

interface

uses  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, System.JSON, rest.Json;

type
  TRestRequestSingleton = class
    private
      client: TRESTClient;
      request: TRESTRequest;
      response: TRESTResponse;
      constructor Create;
    public
    class Function obterInstancia: TRestRequestSingleton;
    class function NewInstance: TObject; override;
    function obterRequisicao: TRestRequest;
    function obterClient: TRESTClient;
    function obterResponse: TRESTResponse;
    procedure limparRequisicao;
  end;

implementation
var instancia: TRestRequestSingleton;

{ TRestRequestSingleton }

constructor TRestRequestSingleton.Create;
begin
  client := TRESTClient.create(nil);
  request := TRestRequest.Create(nil);
  response := TRESTResponse.Create(nil);
  request.Client := client;
  request.Response := response;
  client.ResetToDefaults;
  request.ResetToDefaults;
  response.ResetToDefaults;

  response.ContentType := 'application/json';
  request.Method := TRESTRequestMethod.rmget;
  request.Body.ClearBody;
  Request.ContentType;
  client.AcceptEncoding:='UTF-8';
  client.ContentType:='application/json';

end;

procedure TRestRequestSingleton.limparRequisicao;
begin
  client.ResetToDefaults;
  request.ResetToDefaults;
  response.ResetToDefaults;
end;

class function TRestRequestSingleton.NewInstance: TObject;
begin
 if not Assigned(Instancia) then
  begin
    Instancia := TRestRequestSingleton(inherited NewInstance);
  end;

  result := Instancia;
end;

function TRestRequestSingleton.obterClient: TRESTClient;
begin
  Result := client;
end;

class function TRestRequestSingleton.obterInstancia: TRestRequestSingleton;
begin
  if not assigned(instancia) then
    result := TRestRequestSingleton.Create;
  Result := instancia;
end;

function TRestRequestSingleton.obterRequisicao: TRestRequest;
begin
  Result := request;
end;

function TRestRequestSingleton.obterResponse: TRESTResponse;
begin
  Result := response;
end;

end.

