param(
    $domain,
    $registrationEmailAddress
)

./certbot-auto certonly --noninteractive --agree-tos --email $registrationEmailAddress --standalone --domains $domain
$secrets=@( 
    @{ name="ssl.fullchain.pem.$($domain)";value=Get-Content "/etc/letsencrypt/live/$($domain)/fullchain.pem"} 
    @{ name="ssl.privkey.pem.$($domain)";value=Get-Content "/etc/letsencrypt/live/$($domain)/privkey.pem"}     
    @{ name="ssl.cert.pem.$($domain)";value=Get-Content "/etc/letsencrypt/live/$($domain)/cert.pem"}     
    @{ name="ssl.chain.pem.$($domain)";value=Get-Content "/etc/letsencrypt/live/$($domain)/chain.pem"}     
)

$secrets|%{
    $secret=$_
    aws ssm put-parameter --overwrite --name $secret.name --value "`"$($secret.value)`"" --type  SecureString
}

Start-Sleep -Seconds 86400