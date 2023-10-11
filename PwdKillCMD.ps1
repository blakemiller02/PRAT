foreach ($nerd in $final) {
    Set-ADUser -ChangePasswordAtLogon $true
}
	
