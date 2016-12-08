 @summary
 Feature: QRcode for the website
  In order to visit the IAP Poster Judging System
  As a judge or admin
  I want to view the website by scanning QRcode
  Background:
        Given the following users exist:
          |name | company_name| access_code| role |
          |admin| TAMU        | admin      | admin|
        And I delete qrcode img
        And I logged in as "admin"
 Scenario: QRcode is successfully generated
        Then I should see the qrcode
        When I press "download QR code"
        Then I see a popup window for download "qrcode.png"
