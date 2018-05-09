FROM mcr.microsoft.com/powershell:ubuntu16.04
RUN curl -f -O https://dl.eff.org/certbot-auto
RUN chmod a+x certbot-auto
ADD Create-CertificateAndSleep.ps1 .
CMD pwsh -ep ByPass ./Create-CertificateAndSleep.ps1 $domain $registrationEmailAddress