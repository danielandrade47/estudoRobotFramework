*** Settings ***
Resource    ../main.robot

*** Variables ***
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             class:lista-suspensa
${BOTAO_CARD}             id:form-botao
@{SELECIONAR_TIMES}       
...    //option[contains(.,'Programação')]
...    //option[contains(.,'Front-End')]
...    //option[contains(.,'Data Science')]
...    //option[contains(.,'Devops')] 
...    //option[contains(.,'UX e Design')]
...    //option[contains(.,'Mobile')]
...    //option[contains(.,'Inovação e Gestão')]
  
*** Keywords ***   
Dado que eu preencha os campos do formulário
    ${NOME_COLABORADOR}    FakerLibrary.First Name
    Input Text             ${CAMPO_NOME}      ${NOME_COLABORADOR}
    ${CARGO}               FakerLibrary.Job
    Input Text             ${CAMPO_CARGO}     ${CARGO}
    ${IMAGEM}              FakerLibrary.Image URL    width=100    height=100
    Input Text             ${CAMPO_IMAGEM}    ${IMAGEM}
    Click Element          ${CAMPO_TIME}
    Click Element          ${SELECIONAR_TIMES}[0]

E clique no botão Criar Card
    Click Element    ${BOTAO_CARD}

Então identificar o card no time esperado
    Element Should Be Visible    class:colaboradores

Então identificar 3 cards criados no mesmo time
    FOR    ${i}    IN RANGE    1    3
        Dado que eu preencha os campos do formulário
        E clique no botão Criar Card
    END
    Sleep    5
Então deve criar e identificar um card em cada time disponível
    FOR    ${index}    ${time}    IN ENUMERATE    @{SELECIONAR_TIMES}
        Dado que eu preencha os campos do formulário
        Click Element    ${time}
        E clique no botão Criar Card
    END

Dado que eu clique no botao criar card
    Click Element    ${BOTAO_CARD}

Então o sistema deve exibir mensagens de campo obrigatório
    Element Should Be Visible    id:form-nome-erro
    Element Should Be Visible    id:form-cargo-erro
    Element Should Be Visible    id:form-times-erro
