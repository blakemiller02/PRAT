#Blake Miller - October, 2023

$import = get-content C:\File.txt
#Import password document from DPAT or other tool


$parsed = foreach ($sam in $import) {
    if ($sam -match "Group.*")
    {}
    else {$sam -replace ".*DOMAIN", ""}
}
#Remove domain title from user entries and store into $parsed


$output = foreach ($sam in $parsed) {

    get-aduser $sam -properties mail | select samaccountname,mail,distinguishedname

}
#Store AD User SAM name, Email, and Name into $output
 

$recipients = $output | where {($_.distinguishedname -notmatch "OU=EXAMPLE") -and !([string]::IsNullOrEmpty($_.mail))} | select -expand mail | sort
#Filter out irrelevant OUs, store legitimate emails into $recipients(Uncomment if desired)

$samname = $output | where {($_.distinguishedname -notmatch "OU=EXAMPLE")} | select -expand samaccountname | sort
#Filter out irrelevant OUs, store legitimate SAM names in $samname


#$group = ($recipients | select -first 100) -join ";"
#Store 100 emails at a time into $group, concatenated with ; (Uncomment if desired)



$final = foreach ($user in $samname) {
    get-aduser $user -properties passwordlastset,mail | select mail,passwordlastset | Where-Object {$_.PasswordLastSet -lt (Get-Date).adddays(-10)}
}
#For each SAM Name, retrieve the AD user's PasswordLastSet, and email. 
#Filter out users who's PasswordLastSet is newer than X days prior to current day

    echo "This is how many users have changed their passsword: "($recipients.Count - $final.Count)
    #Users who have changed their password

    echo "This is who has not changed it, of 100/425, as well as the last time they did:"($final | sort mail | select -first 100 | where mail -NotLike "")
    #List emails and PasswordLastSet of users who have not changed their password

