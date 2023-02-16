unit pessoaController;

interface

uses pessoaService, UPessoa,  System.SysUtils, listPessoa ;

 type TPessoaController = class

 private

 public
  function InserirPessoa(Pessoa: TPessoa): String;

  function ListarPessoas(): tListPessoa;
  function BuscarPessoaPorId(const id: String): tListPessoa;
  function alterarPessoa(pessoa: TPessoa): String;
  function excluirPessoa(const id: integer): String;


 end;

implementation

{ TPessoaController }

function TPessoaController.alterarPessoa(pessoa: TPessoa): String;
var
  pessoaService: TPessoaService;
begin
  pessoaService := TPessoaService.Create;
  try
    try
      pessoaService.alterarPessoa(pessoa);
    except on E: Exception do
      begin
        result := 'erro ao altear pessoa: ' + e.Message;
        WriteLn(result);
      end;
    end;
  finally
    pessoaService.Free;
  end;

end;

function TPessoaController.BuscarPessoaPorId(const id: String): tListPessoa;
var
  pessoaService: TPessoaService;
begin
  pessoaService := TPessoaService.Create;
  result := tListPessoa.create;
  try
    try
      result := pessoaService.BuscarPessoaPorId(id);
    except on E: Exception do
      begin
       // result := 'erro ao salvar pessoa: ' + e.Message;
      //  WriteLn(result);
      end;
    end;
  finally
    pessoaService.Free;
  end;

end;

function TPessoaController.excluirPessoa(const id: integer): String;
var
  pessoaService: TPessoaService;
begin
  pessoaService := TPessoaService.Create;
  try
    try
      pessoaService.excluirPessoa(id);
    except on E: Exception do
      begin
        result := 'erro ao deletear pessoa: ' + e.Message;
        WriteLn(result);
      end;
    end;
  finally
    pessoaService.Free;
  end;

end;


function TPessoaController.InserirPessoa(Pessoa: TPessoa): String;
var
  pessoaService: TPessoaService;
begin
  pessoaService := TPessoaService.Create;
  try
    try
      result := pessoaService.InserirPessoa(pessoa);
    except on E: Exception do
      begin
        result := 'erro ao salvar pessoa: ' + e.Message;
        WriteLn(result);
      end;
    end;
  finally
    pessoaService.Free;
  end;
end;

function TPessoaController.ListarPessoas: tListPessoa;
var
  pessoaService: TPessoaService;
begin
  pessoaService := TPessoaService.Create;
  Result := tListPessoa.create;
  try
    try
      result := pessoaService.ListarPessoas;
    except on E: Exception do
      begin
       // result := 'erro ao salvar pessoa: ' + e.Message;
      //  WriteLn(result);
      end;
    end;
  finally
    pessoaService.Free;
  end;

end;

end.
