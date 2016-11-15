 @summary
 Feature: QRcode for the website
  In order to visit the IAP Poster Judging System
  As a judge or admin
  I want to view the website by scanning QRcode

 Scenario: QRcode is successfully generated
        Given I am on the login page
        Then I should see the qrcode
        When I press "download QR code"
        Then I see a popup window for download "qrcode.png"
