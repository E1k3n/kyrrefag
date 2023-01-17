### Ukeoppgaver uke 3 - Arkitekturer og lastbalansering

[Ukeoppgaver uke 3 - Arkitekturer og lastbalansering](https://ntnu.blackboard.com/webapps/blackboard/content/listContent.jsp?course_id=_33872_1&content_id=_1950914_1# "Alternative formater")

1. **( DEL AV OBLIG )** Opprett tre virtuelle maskiner: balancer, www1 og www2. Vi begynner med gx1.1c1r instanser for nå.

  

2. **( DEL AV OBLIG )** Gå til «Network -> Floating IPs» i OpenStack og sørg for at en ny «public» IP er allokert til prosjektet deres. Forsøk å knytte den IP adressen til balancer.

  

3. **( DEL AV OBLIG )** Installer Apache+PHP på www1 og www2. Man man installere ting på Linux som "root" brukeren. Ubuntu-filsystemet er satt opp slik at brukeren "ubuntu" kan bli root, ved at man kjører kommandoen "sudo su". Legg merke til at promptet har endret seg når man er root.

  

Installasjonen kan så gjøres med følgende kommandoer:

  

apt-get update  
apt-get install apache2 libapache2-mod-php

  

4. **( DEL AV OBLIG )** Test Apache+PHP på www1 og www2. Man kan f.eks lage en enkel webside på hver av webserverne, ved å endre på standard-filen /var/www/html/index.html.

  

Man kan først fjerne den eksisterende filen:

rm /var/www/html/index.html

  

Så lager dere en ny:

nano /var/www/html/index.html

  

Det er ikke viktig med HTML for å se at det fungerer. Man kan f.eks bare ha en enkel tekst: "Hei fra www1" og "Hei fra www2".

  

Så kan dere teste om websiden lar seg laste ned. Da vet dere at webserveren fungerer som den skal. Denne kommandoen kan kjøres på manager eller en av webserverne.  

curl http://<IP-TIL-VM>

f.eks: curl http://192.168.0.40

  

Dersom du ikke vil ha status-informasjonen i tillegg, så legg til "-s" i curl kommandoen.

  

5. **( DEL AV OBLIG )** Installer haproxy på balancer og sett opp lastbalansering hvor www2 og www1 deler på belastningen basert på det som står i slidene.

Installasjon av haproxy gjøres som root-brukeren:

apt-get update  
  
apt-get install haproxy net-tools

Deretter må man gå inn og endre konfigurasjonsfilen her: /etc/haproxy/haproxy.cfg. Denne filen inneholder allerede det meste man trenger, men dere må definere en frontend, en backend og stats.

nano /etc/haproxy/haproxy.cfg

Her er et eksempel dere kan bruke. Legg det til i bunnen av det som allerede er der. (Husk å legge inn riktig IP hvor det står "IP TIL ...")  

  
frontend main  
bind *:80  
mode http  
default_backend webservers  
  
backend webservers  
balance roundrobin  
server www1 IP TIL WWW1  
server www2 IP TIL WWW2  
  
listen stats  
bind *:1936  
stats enable  
stats uri /  
stats hide-version  
stats auth someuser:password

Det kan være lurt å sjekke om syntaksen er riktig før man starter haproxy. Heldigvis har haproxy en egen funksjon for å sjekke at alt er i orden. Prøv følgende:

  
  
haproxy -c -f /etc/haproxy/haproxy.cfg

Dersom filen godkjennes, kan man starte haproxy slik:

  
service haproxy start  
service haproxy restart  

  

( Grunnen til at dere kjører både start og restart, er at hos noen av dere kjører haproxy fra før, og da skjer det ingen ting når dere skriver "start". Hos andre kjører haproxy ikke, og da kommer restart ikke til å fungere. Gjør dere begge deler, burde det fungere til slutt. )

Dere kan også sjekke om haproxy kjører med denne kommandoen (se hvem som lytter på port 80 og 1936):

  
  
netstat -anltp

Utskriften burde inneholde en linje slik som dette:

tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      2196/haproxy

Gjør dere endringer i haproxy.cfg senere, må dere huske å restarte haproxy:

service haproxy restart

Test med wget/curl om du nå får lastet ned en webside gjennom lastbalansereren. Fungerer det både med den private og den flytende IP’en til balancer?  

**HUSK: Det kommer ikke til å fungere med en floating-ip uten at man åpner for port 80 i security groups.**

  

6. ( DEL AV OBLIG ) Gå inn i riktig gruppe i blackboard, slik at dere kan få tilsendt de obligatoriske oppgavene.  

7. ( DEL AV OBLIG ) Denne oppgaven skal gjøres på manager.

En viktig del av kurset er å kunne styre de virtuelle maskinenen fra kommandolinjen og å lage små shellscript som automatiserer deler av driften. Vi vil allikevel unngå at dere legger inn deres egne brukernavn og passord inn i disse scriptene, da dette ville blitt synlig for andre i gruppen. I stedet har vi en løsning der hver gruppe har en ekstra bruker, som kan brukes til automatiseringen. Vi kaller denne brukeren "service brukeren" i dette kurset.

**a) Finn brukernavn og passord til service brukeren.**

Brukernavnet er avhengig av navnet på gruppen. Er man f.eks gruppe 15, vil brukernavnet være DCSG2003_V23_group15_service. For å finne passordet må man inn på skyhigh sin webside med sin vanlige NTNU bruker og gå til "Object Store" -> "Containers". Der ligger det en fil med passordet, som dere kan laste ned.

**b) Laste ned RC-filen med autentiseringsdetaljer.**

For å bruke service brukeren fra kommandolinjen trenger man mer enn kun brukernavn og passord. Den enkleste måten å ned resten på er å logge seg ut av skyhigh med sin NTNU bruker og deretter logge seg inn som service brukeren (Husk å velge "Openstack accounts" og ikke "NTNU accounts" når man bruker service brukeren).

Når man er logget inn som service brukeren går man først på "API Access" i menyen på venstre side og trykker på knappen på høyre som heter "Download Openstack RC file". Velg Openstack RC File.

**c) Send RC filen til manager**

Nå har alstå en av dere denne RC filen lokalt på sin maskin, men denne filen må til manager. Man kan prøve seg på klipp-og-lim, men det blir ofte rot med linjer som blandes. Det er bedre med scp-kommandoen. Dersom ditt brukernavn på din Windows maskin er olanormann, så kan du finne frem til RC filen fra din lokale WSL ubuntu kommandolinje slik:

cd /mnt/c/Users/olanormann/Downloads

Bruker du PowerShell, så trenger du bare kjøre kommandoen:

cd Downloads

Deretter kan du sende den til din manager. Sørg for riktig gruppenummer og riktig IP for "manager-ip". Dersom du pleier å bruke ssh sammen med konkrete nøkler, må du også huske å bruke de nøklene med scp:

scp DCSG2003_V22_group15-openrc.sh ubuntu@manager-ip:

**d) Legg inn passordet i RC filen**  

Resten av dette skjer på manager. Nå skal dere altså logge inn på manager og RC filen skal ligge i ubuntu brukerens hjemmeområde. ( Dere kan sjekke med "ls" ) Åpne gjerne RC filen og se hva som gjøres der.

Denne filen er et lite shellscript som setter en rekke variabler i shellet. Det er bare ett lite problem: Passordet blir ikke satt. Istedet blir man spurt om å taste inn passord hver gang man kjører dette scriptet. Det er lurt, men upraktisk for oss. Dere må endre på RC filen ved å først finne disse tre linjene:  
  

# With Keystone you pass the keystone password.  
echo "Please enter your OpenStack Password for project $OS_PROJECT_NAME as user $OS_USERNAME: "  
read -sr OS_PASSWORD_INPUT  
export OS_PASSWORD=$OS_PASSWORD_INPUT

og endre det til å se slik ut ( husk å sette inn service brukerens passord her i stedet for "service bruker passord"):

# With Keystone you pass the keystone password.  
# echo "Please enter your OpenStack Password for project $OS_PROJECT_NAME as user $OS_USERNAME: "  
# read -sr OS_PASSWORD_INPUT  
export OS_PASSWORD="service bruker passord"

Rad 2 og 3 er kommentert ut og variabelen OS_PASSWORD får satt inn passordet. Lagre filen.

**e) Installér openstack klienten**

Kjør følgende for å installere openstack klienten ( antar at man er root her, altså sudo su først. )

sudo apt-get update

sudo apt-get install python3-openstackclient

( **En liten avdvarsel her:** Det finnes både python-openstackclient og python3-openstackclient. Det er anbefalt å bare gå for python3- versjonen når dere laster ned openstack-relaterte pakker. Ellers blir det rot i hvilken av versjonene som brukes og noen funksjoner vil ikke fungere skikkelig. )

Det er flere pakker som blir installert sammen med denne, så det kan ta ett øyeblikk til dette er ferdig.

**f) Kjør RC filen og test openstack kommandoen**  

Openstack vil bruke variablene som RC scriptet setter. Vi må derfor kjøre RC filen før klienten fungerer:

source DCSG2003_V22_group15-openrc.sh

  

Nå kan man teste ved å kjøre følgende:  

openstack server list

Dersom dette gir dere en oversikt over de virtuelle maskinene dere har, så er dere nesten i havn! Problemet er at dere må "source" RC filen hver gang man skal bruke openstack kommandoene. Variablene som blir satt vil bare være der til man logger ut. Logger man inn på nytt, må man også kjøre RC filen på nytt. Det må vi fikse:

**g) Sørg for at RC filen er aktiv hver gang man logger inn på manager**

Det er en ulempe, at man må kjøre RC filen hver gang man har tenkt å bruke openstack. Det ville vært bedre om den kjøres automatisk når man logger inn. Løsningen er å legge dette til oppstartsfilen til ubuntu-brukeren på manager.

Man kan f.eks legge til følgende nederst på filen .bashrc i ubuntu-brukerens eller root-brukerens hjemmeområde, hhv. /home/ubuntu/.bashrc og /root/.bashrc.  Legg merke til at den filen begynner med et punktum!

source /home/ubuntu/DCSG2003_V22_group15-openrc.sh

Dette kan man teste ved å logge inn på manager på nytt og se om man kan kjøre "openstack server list" med en gang uten å måtte kjøre "source"-kommandoen først.

**Husk til senere:** Dersom dere senere i emnet begynner å kjøre script som skal bruke openstack kommandoer, må dere huske at RC filen ikke nødvendigvis har blitt kjørt. Da er det lurt å legge til den samme "source ... " linjen tidlig i scriptet.