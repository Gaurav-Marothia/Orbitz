*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Begin Web Test
    Open Browser    about:blank    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait  3s
    Set Selenium Speed  1s

End Web Test
    Close Browser