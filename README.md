# PRAT
Password Reset Audit Tool

PRAT is a tool designed to take a domain password audit output and extract AD users from it, group them by 100 (if needed) and then track whether or not they have changed their password since the date of the domain password audit. The first script takes the input, separates email addresses and SAM names, then parses the SAM IDs to check the PasswordLastReset property on the AD account. The second will take all users left in $final and change their password to expire at next logon. This is meant to be used in conjunction with a tool such as Domain Password Audit Tool (DPAT) https://github.com/clr2of8/DPAT
