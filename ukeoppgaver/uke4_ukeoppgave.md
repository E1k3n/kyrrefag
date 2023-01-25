

CREATE USER 




1. [x]   (Del av oblig 1) I denne oppgaven skal dere rulle ut bookface løsningen og bli klare til å ta imot trafikk og tjene kyrrecoins!  
      
    1.  Lag en ny virtuell maskin som skal være database-serveren. Kall den gjerne db1. Tilsammen skal dere nå ha fem servere, en lastbalanserer, to webservere, en manager og en database. Denne serveren kan gjerne være mer robust, f.eks. gx3.c4r4.  
          
        
    2.  Bruk oppskriften i denne linken til å sette opp bookface. Database-delen (cockroachDB) gjøres på db1. Oppsettet av webserveren gjøres på begge webserverne. Når det snakkes om "$webhost" og en floating IP, så skal dere bruke den adressen som peker mot lastbalansereren. Det sikrer at alle linkene i bookface peker mot lastbalansereren. Databasen og webserverne selv trenger ingen floating IP. Det betyr, at man må bruke løsninger som foxyproxy for å se status-siden til cockroachDB.  
          
        [https://github.com/hioa-cs/bookface](https://github.com/hioa-cs/bookface)  
          
        (OBS: Legg merke til at du også må installere pakken php-pgsql på webserverne: apt-get install php-pgsql )  
        (**OBS2**: Det kan være lurt å kjøre "sudo service apache2 restart", hvis man får feilmelding om at en driver ikke kunne lastes )  


- **CREATE USER zuck**

- Lagt til config.php i kyrrefag


          
        
2. [x]  Hva skjer dersom db1 rebooter? Se hva som skjer med bookface siden deres når db1 startes på nytt. Dere kan like gjerne huske den feilmeldingen, siden dere nok møter den ofte fremover. Det kan også være lurt å finne ut hvordan man starter cockroachdb igjen på db1.  
- **SQLSTATE[08006] [7] connection to server at "192.168.132.116", port 26257 failed: Connection refused Is the server running on that host and accepting TCP/IP connections?**
- **For å starte cockroachdb på nytt:**
```
cockroach start --insecure --store=/bfdata --listen-addr=0.0.0.0:26257 --http-addr=0.0.0.0:8080 --background --join=localhost:26257
```



    
3. [x]  (Del av oblig 1) Denne oppgaven forutsetter at dere ble ferdige med oppgave 7 fra forrige uke, og at dere kan kjøre "openstack server list" på manager.  
      
    I denne oppgaven skal vi installere et nytt verktøy på manager som lar dere sjekke status og gjøre enkle endringer i oppetidsspillet. Følg instruksjonene dere finner her:  
      
    [https://github.com/kybeg/uc-client](https://github.com/kybeg/uc-client)  
      
    Når dere har en fungerende, men tom, bookface side som dere kan nå via deres floating IP addresse, er det på tide å "gå live" og åpne for trafikk.  
      
    Først må dere registrere floating IP addressen deres i systemet. Kjør kommandoen nedenfor, men sørg for at dere har riktig IP for deres bookface.  
      
    
    uc set endpoint 10.212.X.X
    
      
    Skulle dere være uheldige med IP'en, så kan kommandoen over kjøres flere ganger.  
      
    Sjekk status med kommandoen:  
      
    uc status  
      
    Når dere er klare for å sette i gang, skriver dere følgende:  
      
    uc traffic on  
      
    Gratulerer! Etter ca 15 minutter eller mindre burde dere se en endring på bookface og når dere kjører "uc status" på nytt på manager.  
      
    For mer detaljert informasjon om oppetidsspillet, se "Informasjon om Oppetidsspillet" under "Undervisningsmateriel". Der er det også en link til et dashboard hvor dere kan følge status over tid.  
      
    Husk: Fra nå av tjener dere Kyrrecoins så lenge siden er oppe. Når den er nede, taper dere penger. Dere kan ikke endre på bookface koden. Det er meningen at ting ikke er helt på skinner nå. Etter hvert som vi lærer mer, burde også bookface bli både raskere og mer stabil.  
      
    
4. [ ]  For å kjøre SQL spørringer manuelt rett mot databasen, kan man bruke cockroachDB-kommandoen fra kommandolinjen og deretter åpnes SQL konsollen. Dette kan være litt upraktisk når man heller vil automatisere det. Hva om man ønsker å kjøre en SQL spørring direkte mot databasen rett fra kommandolinjen? For eksempel, dersom man raskt vil telle antall linjer i tabellen "users"? Slikt ville blitt svært nyttig i script senere. Kan dere finne ut hvordan man gjør det? ( Det kan tenkes at dere må google litt. )  
- **
    
5.  Hvordan kan man se en webside på "innsiden" av skyhigh, uten at man bruker en floating IP og åpning i security groups? Svaret er å åpne en tunell ved hjelp av SSH og å bruke en utvidelse til nettleseren som bruker tunellen til å surfe. Det blir altså en slags VPN løsning. Se videoen om FoxyProxy og bruk den til å se cockroachDB sitt Dashboard. Hint: Når du har fått FoxyProxy til å fungere, så bruk den interne IP addressen til db1 og port 8080 i nettleseren din.  
      
    
6.  Ekstra oppgave for de som er interessert: Hvor lagrer cockroachDB logfilen sin?  
      
    
7.  Ekstra oppgave for de som er interessert: Hva er "oom killer" i Linux? Hva tror du det kan ha med cockroachDB å gjøre?  
      
    
8.  Ekstra oppgave for de som er interessert: Å studere lange log filer kan være slitsomt. Finnes det en kommando som bare lar deg se slutten av en fil? Enda bedre: hva om du kan se slutten av en fil og ny informasjon fortløpende?
9.  Ekstra oppgave for de som er interessert: Hvor mye er klokken? Skriv "date" på manager. Er alt som det skal være?
Klokken er stilt en time feil. Hvordan automatiserer vi dette? timedatectl
timedatectl set-timezone "Europe/Oslo"
Legge dette i .bashrc?


Omkiller = tom for minne

tail -> Tar de siste 10 linjene av en loggfil. 
tail -20 tar de siste 20 linjene av fila
tail -f -> Fortsetter å lese 
	Med denne kan vi se hva som skjer. Gjør dette at vi kan sjekke om det står omkiller, så oppskalerer vi? typ med grep


# Todo:
- [ ] lag aliaser til kommandoer du kommer itl å bruke fote
på root@db
alias taildb="clear && tail -f /bfdata/logs/cockroach.log"
Hjemme:
- [ ] alias skyhigh="ssh ubuntu@floating-til-manager"