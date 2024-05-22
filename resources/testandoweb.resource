*** Settings ***

Library     SeleniumLibrary
Library     FakerLibrary        locale=pt_BR
Library     String


***Variables***

${Browser}      chrome
${URL}         https://automacao.qacoders-academy.com.br/login
${novo_texto}    a


&{logarPagina}
...     campoEmail=//*[@id="email"]
...     campoSenha=//*[@id="password"]
...     btnEntrar=//button[@type='submit']
...     senhaInvalida=//div[@class='MuiAlert-message css-1xsto0d']
...     btnDeslogar=//button[@class='css-1nvbq2d']
  

&{preencherDados}
...     campoEmail=sysadmin@qacoders.com
...     campoSenha=1234@Test
...     senhaInvalida=1234@Te
...     campoPesquisar=Teste
...     campoNomeDiretoria=Teste Laura
...     limiteCaracteresDiretoria=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
...     editarDiretoria= editado

&{paginaCadastros}
...     cadastros=//div[@class="MuiListItemText-root css-1tsvksn" and @id="Cadastros"]
...     btnUsuarios=//*[@id="Usuários"]
...     campoPesquisar=//input[@class="MuiInputBase-input MuiOutlinedInput-input MuiInputBase-inputSizeSmall css-1o6z5ng"]
...     btnDiretorias=//*[@id="Diretorias"]
...     lblNomeDiretorias=//div[@class='css-wgzttu']
...     btnCadastroDiretorias=//button[@class='css-fvzsut']
...     lblDadosDiretorias=//h5[@class='css-np5g2k']
...     lblCodigoDiretoria=//div[@class='css-16dmbxr']

&{cadastroDiretorias}
...     campoNomeDiretoria=//*[@id="boardName"]
...     btnSalvarDiretorias=//button[@class='css-1vmo4go']
...     diretoriaInvalida=//div[@class='MuiAlert-message css-1xsto0d']
...     alertaCaracterDiretoria=//p[@class='css-bbipig']
...     lblEditarDiretoria=//h5[@class='css-np5g2k']
...     btnSalvarEdicao=//*[@id="save"]
...     btnBuscarDiretoria=(//button[@class='css-kab9pu'])[2]
...     CodDiretoriaCadastrada=(//ul[@class="css-76nm1l"]/div/span)

*** Keywords ****


Realizar Login com sucesso
    Go To   ${url}
    Maximize Browser Window
    Input Text  ${logarPagina.campoEmail}  ${preencherDados.campoEmail}
    Input Text  ${logarPagina.campoSenha}  ${preencherDados.campoSenha}
    Sleep   3
    Click Element  ${logarPagina.btnEntrar}
    Sleep  3


Validar url
    Location Should Contain  https://automacao.qacoders-academy.com.br/home


Realizar login com email válido e senha inválida

    Go To   ${url}
    Maximize Browser Window
    Input Text  ${logarPagina.campoEmail}   ${preencherDados.campoEmail}
    Input Text  ${logarPagina.campoSenha}   ${preencherDados.senhaInvalida}
    Sleep   3
    Click Element   ${logarPagina.btnEntrar}
    Wait Until Element Is Visible   ${logarPagina.senhaInvalida}
    Clear Element Text  xpath=//*[@id="password"]
    Sleep  2
    Input Text  ${logarPagina.campoSenha}  ${preencherDados.campoSenha}
    Sleep  2
    Click Element   ${logarPagina.btnEntrar}
    Sleep  2


Listar cadastros de usuários

    Click Element   ${paginaCadastros.cadastros}
    Sleep   3
    Click Element   ${paginaCadastros.btnUsuarios}
    Sleep   3
    Input Text  ${paginaCadastros.campoPesquisar}   ${preencherDados.campoPesquisar}
    Sleep  5
    

Cadastro de diretoria
    Click Element   ${paginaCadastros.cadastros}
    Sleep  3
    Click Element   ${paginaCadastros.btnDiretorias}
    Wait Until Element Is Visible  ${paginaCadastros.lblNomeDiretorias}
    Click Element   ${paginaCadastros.btnCadastroDiretorias}
    ${Nomes} =    FakerLibrary.Word
    ${Nome_diretorias} =    Set Variable    ${Nomes}
    Input Text      ${cadastroDiretorias.campoNomeDiretoria}  ${Nome_diretorias}
    Sleep  4
    Click Element   ${cadastroDiretorias.btnSalvarDiretorias}
    Sleep  2
    Wait Until Element Is Visible   ${paginaCadastros.lblCodigoDiretoria}
    Sleep  2
    Close Browser

    
Pesquisar cadastro diretoria
    Scroll Element Into View    (//button[@class='css-kab9pu'])[2]
    Sleep    2
    Click Element    ${cadastroDiretorias.btnBuscarDiretoria}
    Sleep    5
    Scroll Element Into View    (//button[@class='css-kab9pu'])[2]
    Sleep   3

Cadastro de diretoria inválida

    Click Element   ${paginaCadastros.cadastros}
    Sleep  3
    Click Element   ${paginaCadastros.btnDiretorias}
    Wait Until Element Is Visible  ${paginaCadastros.lblNomeDiretorias}
    Click Element   ${paginaCadastros.btnCadastroDiretorias}
    Wait Until Element Is Visible   ${paginaCadastros.lblDadosDiretorias}
    Input Text      ${cadastroDiretorias.campoNomeDiretoria}  ${preencherDados.campoNomeDiretoria}
    Sleep  4
    Click Element   ${cadastroDiretorias.btnSalvarDiretorias}
    Sleep  2
    Wait Until Element Is Visible   ${cadastroDiretorias.diretoriaInvalida}
    Sleep  2

Validar limite de caracteres Cadastro Diretoria

    Click Element   ${paginaCadastros.cadastros}
    Sleep  3
    Click Element   ${paginaCadastros.btnDiretorias}
    Wait Until Element Is Visible  ${paginaCadastros.lblNomeDiretorias}
    Click Element   ${paginaCadastros.btnCadastroDiretorias}
    Wait Until Element Is Visible   ${paginaCadastros.lblDadosDiretorias}
    Input Text      ${cadastroDiretorias.campoNomeDiretoria}  ${preencherDados.limiteCaracteresDiretoria}
    Sleep  4
    Click Element   ${cadastroDiretorias.btnSalvarDiretorias}
    Sleep  2
    Wait Until Element Is Visible   ${cadastroDiretorias.alertaCaracterDiretoria}
    Sleep  2


Editar diretoria com sucesso

    Click Element   ${paginaCadastros.cadastros}
    Sleep  3
    Click Element   ${paginaCadastros.btnDiretorias}
    Wait Until Element Is Visible  ${paginaCadastros.lblNomeDiretorias}
    Sleep  2
    Click Element   xpath=//ul[@class="css-18psgb0"]/li[div/p[text()="03"]]/div/button[@id="edit"]
    Sleep  2
    Wait Until Element Is Visible  ${cadastroDiretorias.lblEditarDiretoria}
    ${texto_existente} =    Get Value    ${cadastroDiretorias.campoNomeDiretoria}
    ${texto_atualizado} =    Set Variable    ${texto_existente}${novo_texto}
    Input Text      ${cadastroDiretorias.campoNomeDiretoria}  ${texto_atualizado}
    Sleep  3
    Click Element   ${cadastroDiretorias.btnSalvarEdicao}
    Sleep  3





Realizar logout
    Click Element   ${logarPagina.btnDeslogar}
    Sleep   3