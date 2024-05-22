*** Settings ***

Library  SeleniumLibrary
Library     FakerLibrary        locale=pt_BR
Library     String
Resource  ../resources/testandoweb.resource
Suite Setup  Open Browser  about:blank  chrome
Suite Teardown  Close Browser

***Test Cases***

10 - Teste Completo
    Realizar login com email válido e senha inválida
    Cadastro de diretoria
    Realizar logout



01- Acessar com email válido e senha inválida
    Realizar login com email válido e senha inválida
    Capture Page Screenshot
    
02 - Realizar login com sucesso

    Realizar Login com sucesso
    Validar url
    #Capture Page Screenshot

03 - Listar cadastros de usuários
    Realizar Login com sucesso
    Sleep  2
    Listar cadastros de usuários


04- Realizar logout
    Realizar Login com sucesso
    Realizar logout


05- Cadastro de Diretoria
    Realizar Login com sucesso
    Cadastro de diretoria
    

06 - Cadastro de Diretoria inválida
    Realizar Login com sucesso
    Cadastro de diretoria inválida

07 - Validar limite de caracter Cadastro Diretoria

    Realizar Login com sucesso 
    Validar limite de caracteres Cadastro Diretoria

08 - Editar diretoria com sucesso

    Realizar Login com sucesso
    Editar diretoria com sucesso