**UKEOPPGAVER**

- [x] (Del av oblig 2) Lag en ny virtuell maskin og installer Docker CE på den. En beskrivelse av prosessen finner dere her:

https://docs.docker.com/install/linux/docker-ce/ubuntu/

(Dette kommer dere til å gjøre ganske ofte, så det er lurt å lage seg et lite shellscript som gjennomfører det, eller i det minste kopiere alle kommandoene. Kommandoen “history” kan være nyttig her.

- [x] (Del av oblig 2) Gode nyheter! Etter møte med utviklerne av bookface, har vi nå klart å få tak i noen optimaliseringer av databasen. Dette var noe utviklerne hadde brukt selv, men glemt å legge til i dokumentasjonen. Se under "Undervisningsmateriell" -> "optimalisering av bookface" for nærmere instruksjoner om hva man kan gjøre.

- [x] (Del av oblig 2) Lag et Docker image som fungerer som en webserver for bookface’n deres. Dere må kanskje diskutere litt hvor mye som skal i containeren og hvor mye som skal være utenfor (f.eks skal config.php og php koden ligge inni, eller utenfor imaget). Sørg for at imaget kan bruke samme database dere allerede har. 
		Hint: Se på Dockerfile i bookface sitt eget repo. Kanskje den kan fungere som utgangspunkt?

- [x] (Del av oblig 2) Start to docker containere på samme maskin som kan fungere som webserver for bookface basert på imaget dere har laget. De trenger ikke lytte på port 80, på den virtuelle serveren deres.

- [x] (Del av oblig 2) La lastbalansereren ha en ekstra backend definisjon som peker til de to docker instansene (ikke fjern den andre backend’en). Nå burdere dere enkelt kunne flytte trafikken over på containerne, dersom dere bytter hvilken backend haproxy skal sende trafikken til. Prøv. ( Husk å restarte HAproxy dersom dere gjør endringer )

- [ ] (Del av oblig 2) Lag et diagram som viser infrastrukturen sålangt inkludert hvilken type webservere som kjører hvor. Diagrammet burde vise portnumrene som brukes, hva som kjører hvor og "flyten" av trafikken. Samme detaljnivå som vi pleier å bruke på tegningene i veideoene.

- [ ] Hva gjør kommandoen docker ps -a?

- [ ] Hvordan fjerner man stoppede docker instanser?

- [ ] Hvordan kan man gi en docker instans et annet navn enn det som er tilfeldig generert?

- [x] (Del av oblig 2) Dersom man kjører en docker instans på en VM, men restarter VM'en, vil docker instansen dukke opp igjen etterpå?

- [ ] Kan to docker instanser "pinge" hverandre på det interne docker nettverket? ( Her må man kanskje google litt )

- [x] (Del av oblig 2) Hva er en docker swarm?

- [ ] (Del av oblig 2) Når man starter en ny VM i OpenStack kan man gi med kommandoer som skal kjøres ved oppstart. Se om dere klarer å lage en VM i OpenStack som automatisk får docker installert. Hva ville dette betydd for måten dere har jobbet på hittil?

- [ ] ACHIEVEMENT UNLOCKED! Denne oppgaven er frivillig, men dersom dere får den til kan dere skrive følgende setning i CV’en deres:

Har satt opp dynamisk docker swarm miljø med redundante webservere.

Istedet for web1 og web2, lag heller en docker swarm (da trenger man en mester og kanskje to «arbeidere». Finn ut hvordan nettverks-oppsettet blir i en docker swarm og om du fortsatt trenger en lastbalanserer. Start webserverene som en tjeneste i docker swarm, her kan dere velge antal replicas, f.eks 2. Nå trenger dere bare ordne trafikken, så vil dere ha en langt mer fleksibel og dynamisk platform hvor flere ting kan kjøre, nesten som en egen sky! (f.eks: er det nødvendig med lastbalanserer som egen maskin? Hva med databasen?)