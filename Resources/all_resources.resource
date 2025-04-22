*** Settings ***
Variables  consts.py
Variables  consts-user01.py

Variables  ../PageObjects/locators-common.py


Library  String
Library  Collections
Library  DateTime
# Library  Browser
Library  OperatingSystem
Library  RequestsLibrary



Resource  CommonKeywords.resource
Resource  apiKeywords.resource
Resource  stringKeywords.resource
# Resource  OrderNowKeywords.resource
# Resource  CartKeywords.resource
