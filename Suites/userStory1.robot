***Settings***
Resource  ../Config/ImportRessources.robot

Test Setup  Ouvrir Application Tutorials Ninja
Test Teardown  Close Chrome Browser


***Variables***

${firstname}  john
${lastname}  Smith
${email}  testemail@yoomail.com
${telephone}  060102030405 
${password}  pass@123

${URL}  https://tutorialsninja.com/demo
${my_account_dropdown}  //a[@title="My Account"]
${register_link}  //a[text()="Register"]
${login_link}  //a[text()="Login"]
${login_submit_button}  //input[@value="Login"]

${firstname_input}  //input[@id='input-firstname']
${lastname_input}  //input[@id='input-lastname'] 
${email_input}  //input[@id='input-email']
${telephone_input}  //input[@id='input-telephone']
${password_input}  //input[@id='input-password']
${confirm_input}  //input[@id='input-confirm']
${privacy_checkbox}  //input[@name='agree']
${continue_button}  //input[@type="submit"]
${success_message}  //div[@id="content"]/h1

${wrong_email}  testemail2@yopmail.com
${wrong_password}  incorrectpassword
${error_message}  //div[contains(@class,"alert-danger")]


***Test Cases***
Inscription d'un Nouveau Compte
    [Documentation]  ce cas de test vérifie le cas passant de la création d'un nouveau compte 
    [Tags]  RBF001
    Given Naviguer sur la page d'inscription
    When Remplir tous les champs du formulaire
    And Cliquer sur le bouton "continuer"
    Then Vérifier la création réussie du compte

Se connecter avec des identifiants valides
    [Documentation]  ce cas de test vérifie le cas passant de connection 
    [Tags]  RBF002
    Given L'utilisateur est sur la page de login
    When il entre un email et un password valide
    And clique sur le bouton "Login"
    Then l'utilisateur est bien connecté 

Se connecter avec des identifiants invalides
    [Documentation]  ce cas de test vérifie le cas négatif de connection 
    [Tags]  RBF003
    Given L'utilisateur est sur la page de login
    When il entre un email et un password invalide
    And clique sur le bouton "Login"
    Then un message d'erreur "Warning: No match" s'affiche
    And l'utilisateur n'est pas connecté


***Keywords***

Ouvrir Application Tutorials Ninja
    [Documentation]  ce keyword permet d'ouvrir le site web Demo Tutorials Ninja
    SeleniumLibrary.Open Browser  url=${URL}  browser=chrome
    SeleniumLibrary.Maximize Browser Window

Close Chrome Browser
    [Documentation]  ce keyword permet de fermer le navigateur Chrome
    SeleniumLibrary.Capture Page Screenshot  close_browser.png
    SeleniumLibrary.Close Browser

Naviguer sur la page d'inscription
    [Documentation]  ce keyword permet de vérifier que l'utilisateur est sur la page d'inscription
    SeleniumLibrary.Click Element  locator=${my_account_dropdown}
    SeleniumLibrary.Click Element  locator=${register_link}
    ${url}  SeleniumLibrary.Get Location
    Should Contain  container=${url}  item=account/register

Générer email unique
    ${timestamp}=    Get Time    epoch
    ${email}=    Set Variable    test${timestamp}@yopmail.com
    RETURN    ${email}

Remplir tous les champs du formulaire
    [Documentation]  ce keyword permet de remplir tous les champs du formulaire d'inscription
    ${email}=    Générer email unique
    SeleniumLibrary.Input Text  locator=${firstname_input}  text=${firstname}
    SeleniumLibrary.Input Text  locator=${lastname_input}  text=${lastname}
    SeleniumLibrary.Input Text  locator=${email_input}  text=${email}
    SeleniumLibrary.Input Text  locator=${telephone_input}  text=${telephone}
    SeleniumLibrary.Input Text  locator=${password_input}  text=${password}
    SeleniumLibrary.Input Text  locator=${confirm_input}  text=${password}  
    SeleniumLibrary.Click Element  locator=${privacy_checkbox}

Cliquer sur le bouton "continuer"
    [Documentation]  ce keyword permet de cliquer sur le bouton "continuer" pour valider l'inscription
    SeleniumLibrary.Click Element  locator=${continue_button}

Vérifier la création réussie du compte
    [Documentation]  ce keyword permet de vérifier que le compte a été créé avec succès
    ${url}  SeleniumLibrary.Get Location
    Should Contain  container=${url}  item=account/success
    ${message}  SeleniumLibrary.Get Text  locator=${success_message}
    Should Contain  container=${message}  item=Your Account Has Been Created!


# Test Case two 
L'utilisateur est sur la page de login
    [Documentation]  ce keyword permet de vérifier que l'utilisateur est sur la page de login
    Click Element  locator=${my_account_dropdown}
    Click Element  locator=${login_link}
    ${url}  SeleniumLibrary.Get Location
    Should Contain  container=${url}  item=account/login

il entre un email et un password valide
    [Documentation]  ce keyword permet de saisir un email et un password valide pour se connecter
    Input Text  locator=${email_input}  text=${email}
    Input Text  locator=${password_input}  text=${password}

clique sur le bouton "Login"
    [Documentation]  ce keyword permet de cliquer sur le bouton "Login" pour se connecter
    Click Element    ${login_submit_button}

l'utilisateur est bien connecté
    [Documentation]  ce keyword permet de vérifier que l'utilisateur est connecté avec succès
    # ${url}  SeleniumLibrary.Get Location
    # Should Contain  container=${url}  item=account/account
    Wait Until Location Contains    account/account    10s
    Location Should Contain    account/account


# Test Case three
il entre un email et un password invalide
    [Documentation]  ce keyword permet de saisir un email et un password invalide pour se connecter
    Input Text  locator=${email_input}  text=${wrong_email}
    Input Text  locator=${password_input}  text=${wrong_password}

un message d'erreur "Warning: No match" s'affiche
    [Documentation]  ce keyword permet de vérifier que le message d'erreur d'affiche lorsque les identifiants sont invalides
    Wait Until Element Is Visible    ${error_message}    10s
    ${message}  SeleniumLibrary.Get Text  locator=${error_message}
    Should Contain  container=${message}  item=Warning: No match

l'utilisateur n'est pas connecté
    [Documentation]  ce keyword permet de vérifier que l'utilisateur n'est pas connecté lorsque les identifiants sont invalides
    ${url}  SeleniumLibrary.Get Location
    Should Contain  container=${url}  item=account/login

Close Chrome Browser
    [Documentation]  ce keyword permet de fermer le navigateur Chrome
    SeleniumLibrary.Capture Page Screenshot  close_browser.png
    SeleniumLibrary.Close Browser