##### Ukeoppgaver:

1.  Opprett en gruppe, som beskrevet over.  
       NTNuWu
    
2.  Dersom du har Windows, installer Ubuntu shell (WSL), slik at du kan koble deg på de virtuelle maskinene. Denne beskrivelsen kan hjelpe:  
      
    Du kan ha en lokal virtuell Linux maskin med f.eks virtualbox, men det er nokså slitsomt i lengden og anbefales ikke. Har du Mac eller Linux er alt i orden.  
      
    
3. [x]  Hva er en ssh-nøkkel og hvorfor trenger dere det?  
      En ssh-nøkkel er en autentiseringsmetode som blir brukt til å få tilgang på tvers av systemer. Det brukes til å etablere en kryptert forbindelse mellom en lokal host og en remote host.
    
4. [x]  Hvert gruppemedlem burde gjøre dette:  
      
    1. [x]  Åpne opp et ubuntu shell på maskinen deres. (Dersom dere ikke har WSL installert, kan dere åpne et Windows PowerShell i stedet ).  
        
    2. [x]  Lag en ssh-nøkkel på maskinen deres med kommandoen “ssh-keygen”. Bare trykk ENTER på alle spørsmålene. Dere trenger ikke passphrase. PS: Dersom du allerede har nøkler på din maskin vær forsiktig at du ikke overskriver dem. Det må også være en rsa nøkkel for at det skal kunne legges inn i SkyHigh.  
          
        
    3. [x]  Gå på https://skyhigh.iik.ntnu.no og logg dere på med NTNU brukernavn og passord (husk at dere må være på "NTNU accounts").  
          
        - [ ] Nå er dere inne på SkyHigh. Under "Compute" -> "Key Pairs", trykk på knappen oppe til høyre som heter "Import Public Key".   
          
        Kopier innholder av den offentlige nøkkelen deres. Det enkleste er å kjøre følgende kommando:  
          
        cat .ssh/id_rsa.pub  
          
        - [x] Kopier alt som ble skrevet ut og lim det inn i boksen i dialogen for å importere nøkkelen. Gi den også et fornuftig navn, slik som "laptop".  
          
        
    4.  Legg merke til, at dere ikke kan se hverandres nøkler. Selv om dere er inne i samme gruppe i skyen, og forvalter de samme ressursene, så er nøklene private. Det kommer til å få noen konsekvenser for trinnene som kommer senere.  
        
5. [x]  Sørg for at port 22 (SSH) tillates i Network -> Security Groups -> Default -> Manage rules. Det enkleste er å trykke på knappen "Add Rule" og la alt så slik det er, men skrive "22" inn i feltet som heter "Port". Dersom man gjør dette på en annen måte, f.eks ved å velge "SSH rule" i drop-down menyen, endrer noen av feltene innhold og man ender opp med å blokkere traffiken hvis man ikke passer på å rette opp alt som er endret.  
      
    
6.  Hvert gruppemedlem burde gjennomføre dette:  
      
    1. [ ]  Lag en virtuell maskin ved å gå til "Compute -> Instances" og trykk på "Launch Instance"  
          
        
    2. [ ]  Det er ikke alle felt som må fylles ut. Her er de viktigste:
        1.  Den trenger et navn  
              
            
        2. [x]  Under "Source" velger du hva slags Linux variant som skal brukes. Det er mange valg her, men vi bruker Ubuntu 22.04 Server i dette emnet. Skriv "Ubuntu" i søkefeltet og velg den riktige  
              
            
        3. [x]  Under "Flavor" velger man hvor mange maskinressurser VM'en skal få. Her kan du godt velge noe enkelt, slik som gx1.1c1r.  
              NB! Husk å legg til ssh nøkkelen din
            
        4. [x]  Det var det hele denne gangen. Trykk "Launch Instance".  
              
            
        5. [x]  Mens den virtuelle maskinen starter, gå til Network -> Floating IPs og be om en “offentlig” IP ved å trykke på "Allocate IP to Project". Disse IP addressene er tilgjengelige på NTNU nettet. Når du har fått den, koble denne IP addressen til den virtuelle maskinen du har laget ved å trykke på "Associate IP".  
              
            
        6. [x]  Nå kommer den store finalen for å se om alt har fungert hittil: Forsøk å koble deg på fra din egen maskin til den nye virtuelle maskinen.  
              
            Gå tilbake til kommandolinjen på din egen maskin. Skriv følgende kommando som vist nedenfor, men husk å bruke Floating IP addressen (den som begynner på 10.212.. )  
              
            ssh ubuntu@10.212.X.X  
              
            Første gang du koler deg på, så før du et spørsmål om du vil lagre informasjon om dette stedet. Skriv "yes" og trykk enter.  
              
            Siden du har lastet opp nøkkel, burde du ikke bli bedt om passord og etter noen sekunder burde du se at du nå har et shell inne på den nye serveren. Gratulerer!  
              
            Dersom du ikke kommer inn på VM'en din, kan noe ha gått galt på veien. Her er noen tips:  
              
            1.  Dersom ssh kommandoen bare henger og til slutt stopper, så er det sannsynligvis reglene i Security Groups som ikke slipper SSH trafikk igjennom.
            2.  Dersom du får melding om "Permission denied", så er det noe problem med SSH nøkkelen.  
                  
                
7. [x]  Hvis man har fått til forrige oppgave, kan man fint slette den virtuelle maskinen man laget. Neste oppgave kommer til å lage en virtuell maskin som dere kommer til å bruke hele tiden.  
    
8. [x]  Gruppen burde lage seg en felles virtuell maskin med navn “manager” som styrer alt det andre dere skal sette opp. Dere trenger enda en offentlig IP til dette. Det anbefales å ha noe mer ressurser i forhold til forrige oppgave. F.eks gx1.2c2r. En av gruppemedlemmene bør opprette denne virtuelle maskinen.  
      
    
9. [x]  Når "manager" er opprettet må man også legge til den offentlige nøkkelen til andre medlemmer i gruppen slik at de kan logge seg inn på samme VM. Som dere husker, er nøklene private, så dersom én har laget VM'en, så kan ikke de andre logge seg inn. Dette fikser man ved å “paste” den offentlige nøkkelen dems inn i filen “~/.ssh/authorized_keys” (en linje per nøkkel):  
      
    1. [x]  Den som opprettet maskinen må logge seg inn på den med ssh kommandoen.  
          shh ubuntu@10.212.171.134
        
    2. [x]  Deretter åpner man den riktige filen med en editor (f.eks nano):  
          
        nano ~/.ssh/authorized_keys  
          
        - [x] Legg merke til at det er én lang linje der nå. Hver nøkkel som skal legges til, skal bli en ny linje. Her må man passe på. Dersom denne filen ikke ser riktig ut lenger, så kan ingen logge seg på. Det blir som å sage av greinen man sitter på.  
          
        
    3. [x]  De andre gruppe medlemmene må sende den offentlige nøkkelen ( den samme som de lastet opp i SkyHigh tidligere ) til medlemmet som laget manager, slik at nøkkelen kan limes inn som nye linjer i filen. Når det er gjort, saver man filen.  
          
        
    4. [x]  Nå burde det være mulig for alle medlemmene å logge seg på som ubuntu på den maskinen. Bruk samme ssh kommando som før, men pass på at man nå bruker Floating IP til manager.  
          
        
10. [x]  Lag et nytt nøkkelpar på manager:  
      
    1. [x]  Alle tre logger seg på manager med ssh  
          
        
    2. [x]  Ett av medlemenne kjører kommandoen ssh-keygen slik som i oppgave 4  
          
        
    3. [x]  Alle medlemmene kjører så kommandoen for å se nøkkelen:  
          
        cat ~/.ssh/id_rsa.pub  
          
        
    4. [x]  Hvert gruppemedlem må nå laste opp denne nye offentlige nøkkelen i skyhigh under "Compute" -> "Key Pairs" og "Import Public Key".  
          
        
11. [x]  Hvert gruppemedlem burde nå prøve å lage en ny virtuell maskin hvor “manager” nøkkelen blir valgt og hvor man ikke knytter en offentlig IP til den. Når man velger "Launch Instance" så er det et menyvalg til venstre som heter "Key Pair". Sørg for at riktig nøkkel er valgt.  
      
    Man trenger ikke gi de nye virtuelle maskinene en Floating IP. Siden manager er på "innsiden" av skyen sammen med dem, skal nå være mulig for alle gruppemedlemmene å koble seg på alle de nye maskinene med ssh så lenge de er ubuntu brukeren på manageren. Bruk 192.168.*.* addressen de har fått tildelt.  
      
      
    Dere kan nå slette de andre virtuelle maskinene, men behold "manager". Den skal brukes videre i emnet.  
      
    **Gratulerer!** Hvis dere har kommet helt hit, så er det aller meste på plass for veien videre. Dere kommer til å lage flere virtuelle maskiner senere. Fra nå av er det alltid klokt å bruke manager nøkkelen for de nye virtuelle maskinene. Manager blir som et springbrett for alle maskinene på innsiden og alle gruppemedlemmene har tilgang til alle serverne så lenge de kommer seg inn på manager.  
      
    
12. [ ]  **(Bonusoppgave)** Blir det ikke litt slitsomt å dele skjerm hver gang man skal vise hva man skal gjøre til de andre? Jo. Heldigvis finnes det alternativer. Hele gruppen burde klare å møtes i en felles screen sesjon, som gjør at dere kan "dele" en kommandolinje. Dette gjøres når alle er logget inn som samme bruker på samme maskin. F.eks som ubuntu brukeren på manager. Da må den ENE av dere kjøre følgende:  
      
    screen -S fellestest  
      
    Dette lager en screen sesjon med navn "fellestest". De andre burde nå kunne se den ved hjelp av kommandoen:  
      
    screen -ls  
      
    For å logge seg på en screen sesjon må de andre skrive følgende kommando:  
      
    screen -x fellestest  
    Kjør en kommando, f.eks "ls". Nå burde alle andre se hva som skjer. Vær på vakt! Alle som er i screen'en samtidig kan skrive kommandoer, så det kan fort bli krøll om man ikke gir beskjed om hvem som skal gjøre hva.  
      
    For å gå ut av den igjen trykker man ctrl+a og ctrl+d. Screen sesjonen lever videre i bakgrunnen selv om alle er logget ut av den. Prøv å se om det stemmer.