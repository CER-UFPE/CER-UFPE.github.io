#!/bin/bash

echo "==============================================="
echo "      CER-UFPE :: E-mail Header Builder        "
echo "==============================================="
echo
echo "Insert the following information to build your email header:"

read -p "Full name: " FULL_NAME
read -p "Job title at CER: " JOB_TITLE
read -p "UFPE mail user(login): " UFPE_USER_MAIL

echo
read -p "Do you have a second job location? (y/n): " HAS_SECOND_JOB
if [[ "$HAS_SECOND_JOB" == "y" || "$HAS_SECOND_JOB" == "Y" ]]; then
    read -p "second job location: " SECOND_JOB_LOCATION
    read -p "second job title: " SECOND_JOB_TITLE
    read -p "second job organization: " SECOND_JOB_ORGANIZATION
fi

echo
read -p "Do you want to add your mobile number? (y/n): " ADD_MOBILE
if [[ "$ADD_MOBILE" == "y" || "$ADD_MOBILE" == "Y" ]]; then
    read -p "Mobile number [+xx (xx) xxx xxx xxx]: " MOBILE_NUMBER
fi


echo
echo "-------------------------------------------------"
echo "FULL NAME: $FULL_NAME"
echo "JOB TITLE: $JOB_TITLE"
echo "UFPE USER MAIL: $UFPE_USER_MAIL"
if [[ "$HAS_SECOND_JOB" == "y" || "$HAS_SECOND_JOB" == "Y" ]]; then
    echo "SECOND JOB LOCATION: $SECOND_JOB_LOCATION"
    echo "SECOND JOB TITLE: $SECOND_JOB_TITLE"
    echo "SECOND JOB ORGANIZATION: $SECOND_JOB_ORGANIZATION"
fi
if [[ "$ADD_MOBILE" == "y" || "$ADD_MOBILE" == "Y" ]]; then
    echo "MOBILE NUMBER: $MOBILE_NUMBER"
fi
echo "-------------------------------------------------"

read -p "Is all the information above correct? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "Aborted by user."
    exit 1
fi

# -------------------------------------------------------
# MAIL HEADER TEMPLATE

HTML_CONTENT="
    <html>
    <body style='background-color: black;'>
    <table cellpadding='0' cellspacing='0' border='0' style='font-family: Arial, sans-serif; background-color: white; box-shadow: 0 2px 8px rgba(0,0,0,0.12); border-radius: 6px;'>
    <tr>
        <!-- Coluna 1: Imagem à esquerda -->
        <td align='center' valign='middle' style='min-width: 240px; min-height: 100px; background: url(\"https://cer-ufpe.github.io/CER-email-header-left.png\") no-repeat center center; background-size: auto;'>
        </td>
        <!-- Coluna 2: Dados de contato -->
        <td align='left' bgcolor='white' valign='middle' style='padding: 10px 20px 10px 15px; background-color: white; min-width: 230;'>
        <div style='font-size: 16px; margin-bottom: 5px;'>
        <strong>
            <!--MUDAR: NOME COMPLETO-->
            $FULL_NAME
        </strong>
        </div>

        <!-- LOTACOES -->
        <div style='font-size: 12px; color: #01375b; font-style: italic; font-weight: bold; margin: 10px 0 0 0;'>
            <span style='font-size: 12px; color: #3c3c3c; font-style: italic; font-weight: bold;'>$JOB_TITLE | </span>
            Center for Renewable Energy
        </div>
        <div style='font-size: 12px; color: #545454; font-style: italic; margin-bottom:5px;'>
            of the Federal University of Pernambuco (CER-UFPE)
        </div>"

# LOTACOES
if [[ "$HAS_SECOND_JOB" == "y" || "$HAS_SECOND_JOB" == "Y" ]]; then
    HTML_CONTENT+="
    <div style='font-size: 12px; color: #01375b; font-style: italic; font-weight: bold; margin: 10px 0 0 0;'>
        <span style='font-size: 12px; color: #3c3c3c; font-style: italic; font-weight: bold;'>$SECOND_JOB_TITLE | </span>
        $SECOND_JOB_LOCATION
    </div>
    <div style='font-size: 12px; color: #545454; font-style: italic; margin-bottom:5px;'>
        of the $SECOND_JOB_ORGANIZATION
    </div>"
fi

HTML_CONTENT+="
    <!-- CONTATOS -->
    <div style='font-size: 11px; margin: 10px 0 2px 0;'>
      <img src='https://cer-ufpe.github.io/e-mail-icon.png' height='16px' alt='Email' style='vertical-align: middle;'>
      <!--MUDAR: EMAIL-->
      <a href='mailto:$UFPE_USER_MAIL@ufpe.br' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'>
        <!--MUDAR: EMAIL-->
        $UFPE_USER_MAIL@ufpe.br
      </a>
    </div>
    <div style='font-size: 11px; margin-bottom: 2px;'>
      <img src='https://cer-ufpe.github.io/phone-icon.png' height='15px' alt='Office' style='vertical-align: middle;'>
      <!--MUDAR: OFFICE PHONE-->
      <a href='tel:+558121267326' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'>
        <!--MUDAR: OFFICE PHONE-->
        +55 81 2126-7326
      </a>
    </div>"

# MOBILE PHONE
if [[ "$ADD_MOBILE" == "y" || "$ADD_MOBILE" == "Y" ]]; then
    HTML_CONTENT+="
        <div style='font-size: 11px; margin-bottom: 2px;'>
        <img src='https://cer-ufpe.github.io/mobile-icon.png' height='15px' alt='Mobile' style='vertical-align: middle;'>
        <a href='tel:$MOBILE_NUMBER' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'>
            $MOBILE_NUMBER
        </a>
        </div>"
fi

HTML_CONTENT+="
    <div style='font-size: 11px; margin-bottom: 2px;'>
      <img src='https://cer-ufpe.github.io/web-icon.png' height='16px' alt='Email' style='vertical-align: middle;'>
      <a href='https://cer.ufpe.br' style='color: #1a2e3b; text-decoration: none; font-size: 11px;'>https://cer.ufpe.br</a>
    </div>
    </td>
    <td style='padding-left: 125px; background: url(\"https://cer-ufpe.github.io/CER-email-header-right.png\") no-repeat right bottom;'>
    </td>
  </tr>
</table>
</body>
</html>
"

OUTPUT_FILE="email-header.html"
echo "$HTML_CONTENT" > "$OUTPUT_FILE"
echo "Arquivo HTML criado: $OUTPUT_FILE"
