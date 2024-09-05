*** Settings ***
Variables  consts.py
Variables  consts-user01.py

Variables  ../PageObjects/locators-common.py


Library  String
Library  Collections
Library  DateTime
Library  Browser  auto_closing_level=MANUAL
Library  OperatingSystem

Resource  CommonKeywords.resource
# Resource  LoginKeywords.resource
# Resource  HomePageKeywords.resource
# Resource  OrderNowKeywords.resource
# Resource  CartKeywords.resource
