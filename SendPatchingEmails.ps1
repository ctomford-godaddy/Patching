$groups = "ops-mcx" # Get-Content .\groups.txt
$smtpServer = "p3plemlrelay-v01.prod.phx3.secureserver.net"
$from = "sre_gpd@godaddy.com"
$subject = "Test Email"
$body = "This is a test email sent via powershell."

foreach ($group in $groups) {
  try {
    $members = Get-ADGroupMember -Identity $group
    $to = ""
    foreach ($member in $members) {
      $user = Get-ADUser -Identity $member -Properties EmailAddress
      $to += $user.EmailAddress + ","
    }
    Write-Host "Sending email to group: $group"
    Send-MailMessage -SmtpServer $smtpServer -From $from -To $to -Subject $subject -Body $body
  }
  catch {
    Write-Host "An error occurred: $($_.Exception.Message)"
  }
}