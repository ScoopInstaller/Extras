Import-Module $ModifyPSProfile
RemovefromProfile 'Import-Module scoop-completion'
AppendtoProfile 'Import-Module scoop-completion'
Remove-Module -Name ModifyPSProfile
