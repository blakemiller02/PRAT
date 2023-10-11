foreach ($nerd in $final) {
    Set-ADUser $nerd -ChangePasswordAtLogon $true
}
	
