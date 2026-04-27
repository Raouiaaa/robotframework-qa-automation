***Settings***
Resource  ../Config/ImportRessources.robot

Test Setup  Ouvrir Application Tutorials Ninja
Test Teardown  Close Browser  


***Variables***
${URL}  https://tutorialsninja.com/demo/
${search_icon}  //i[@class="fa fa-search"]
${search_page_title}  //h1[text()="Search"]

${input_search}  //input[@id="input-search"]
${product_name}  iMAC
${select_category}  //select[@name="category_id"]
${button_search}  //input[@id="button-search"]
${product_result}  //a[text()="iMac"]
${no_product_matching_message}  //p[contains(text(),'There is no product that matches the search criteria.')]

${search_result_title}  //h1[text()="Search - Mac"]
${list_view}  //button[@id="list-view"]
${grid_view}  //button[@id="grid-view"]

***Test Cases***

Verifier la naviguation à la page "Search" depuis la page d'accueil
    [Documentation]  ce cas de test vérifie la naviguation à la page "Search" depuis la page d'accueil
    [Tags]  RBF004
    Given L'utilisateur est sur la page d'accueil
    When il clique sur l'icône de recherche
    Then l'utilisateur est redirigé vers la page "Search"
    And l'url de le page contient le nom "/Search"

Rechercher un produit en sélectionnant la catégorie qui lui correspond.
    [Documentation]  ce cas de test vérifie la recherche d'un produit en sélectionnant sa catégorie correspondante
    [Tags]  RBF005
    Given L'utilisateur est sur la page de recherche 
    When il entre le nom du produit  iMac
    And sélectionne sa catégorie
    And clique sur le bouton "Search"
    Then le produit est bien affiché sur les résultats de la recherche

Rechercher un produit en sélectionnant une catégorie incorrecte.
    [Documentation]  ce cas de test vérifie la recherche d'un produit en sélectionnant une catégorie incorrecte
    [Tags]  RBF006
    Given L'utilisateur est sur la page de recherche 
    When il entre le nom du produit  iMac
    And sélectionne une catégorie incorrecte
    And clique sur le bouton "Search"
    Then le produit n'est pas affiché
    And un texte "There is no product that matches the search criteria." s'affiche sur la page

Vérifier l'affichage des produits recherchés avec la vue "List" et la vue "Grid"
    [Documentation]  ce cas de test vérifie l'affichage des produits recherchés avec la vue "List" et la vue "Grid"
    [Tags]  RBF007
    Given L'utilisateur a fait la recherche avec un nom de produit
    AND la page affiche les nombres de produits sous la vue "Grid"
    When il modifie la vue d'affichage des produits affichés pour la vue "List"
    Then les mêmes produits sont affichés


***Keywords***

Ouvrir Application Tutorials Ninja
    [Documentation]  ce keyword permet d'ouvrir le site web Demo Tutorials Ninja
    Open Browser  url=${URL}  browser=chrome
    # we might add proxy info or vpn info 
    Maximize Browser Window

L'utilisateur est sur la page d'accueil
    [Documentation]  ce keyword permet de vérifier que l'utilisateur est sur la page d'accueil
    ${url}  Get Location
    Should Contain  container=${url}  item=tutorialsninja.com/demo

il clique sur l'icône de recherche
    [Documentation]  ce keyword permet de cliquer sur l'icône de recherche pour accéder à la page "Search"
    Click Element  locator=${search_icon}


l'utilisateur est redirigé vers la page "Search"
    [Documentation]  ce keyword permet de vérifier que l'utilisateur est redirigé vers la page "Search"
    ${search_title}  SeleniumLibrary.Get Text  locator=${search_page_title}
    Should Contain  container=${search_title}  item=Search

l'url de le page contient le nom "/Search"
    [Documentation]  ce keyword permet de vérifier que l'url de la page contient le nom "/Search"
    ${url}  Get Location
    Should Contain  container=${url}  item=/search

L'utilisateur est sur la page de recherche
    [Documentation]  ce keyword permet de vérifier que l'utilisateur est sur la page de recherche
    il clique sur l'icône de recherche
    l'url de le page contient le nom "/Search"
    l'utilisateur est redirigé vers la page "Search"

il entre le nom du produit
    [Documentation]  ce keyword permet de saisir le nom du produit à rechercher
    [Arguments]    ${product_name}
    Input Text    ${input_search}    ${product_name}

sélectionne sa catégorie
    [Documentation]  ce keyword permet de sélectionner la catégorie du produit à rechercher
    Select From List By Value    ${select_category}    27

clique sur le bouton "Search"
    [Documentation]  ce keyword permet de cliquer sur le bouton "Search" pour lancer la recherche
    Click Element  locator=${button_search}

le produit est bien affiché sur les résultats de la recherche
    [Documentation]  ce keyword permet de vérifier que le produit recherché est bien affiché sur les résultats de la recherche
    Page Should Contain Element  locator=${product_result}

sélectionne une catégorie incorrecte
    [Documentation]  ce keyword permet de sélectionner une catégorie incorrecte pour la recherche du produit
    Select From List By Value    ${select_category}    47

le produit n'est pas affiché
    [Documentation]  ce keyword permet de vérifier que le produit recherché n'est pas affiché sur les résultats de la recherche
    Page Should Not Contain Element  locator=${product_result}

un texte "There is no product that matches the search criteria." s'affiche sur la page
    [Documentation]  ce keyword permet de vérifier que le texte "There is no product that matches the search criteria." s'affiche sur la page lorsque le produit recherché n'est pas trouvé
    # Page Should Contain  There is no product that matches the search criteria.
    Wait Until Page Contains Element    ${no_product_matching_message}    10s

L'utilisateur a fait la recherche avec un nom de produit
    [Documentation]  ce keyword permet de vérifier que l'utilisateur a fait la recherche avec un nom de produit
    L'utilisateur est sur la page de recherche
    il entre le nom du produit  Mac
    clique sur le bouton "Search"
    # Page Should Contain Element  locator=${xpath_search_result_title}

la page affiche les nombres de produits sous la vue "Grid"
    [Documentation]  ce keyword permet de vérifier que la page affiche les nombres de produits sous la vue "Grid"
    # Element Attribute Value Should Contain    ${xpath_grid_view}    class    active
    ${grid_class}=    Get Element Attribute    ${grid_view}    class
    Should Contain    ${grid_class}    active

il modifie la vue d'affichage des produits affichés pour la vue "List"
    [Documentation]  ce keyword permet de modifier la vue d'affichage des produits affichés pour la vue "List"
    Click Element  locator=${list_view}

les mêmes produits sont affichés
    [Documentation]  ce keyword permet de vérifier que les mêmes produits sont affichés après avoir modifié la vue d'affichage des produits affichés pour la vue "List"
    # Sleep 10s
    Wait Until Page Contains Element    ${search_result_title}    10s
    ${list_class}=    Get Element Attribute    ${list_view}    class
    Should Contain    ${list_class}    active