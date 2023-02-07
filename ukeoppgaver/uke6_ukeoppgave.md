***Besvarelse med bilder ligger i google docs***



1. [x] (Del av oblig 2)  Shellscript er nyttige, men de kan fort bli rotete og vanskelige å forstå. Dessuten fylles de ofte opp med "nyttige" triks, slik som å kunne skrive ut meldinger i flere farger. Mange script betyr at man må vedlikeholde de samme "triksene" i hvert enkelt skript. Dette skalerer ikke. La oss prøve en annen fremgangsmåte. Det blir som å lage seg et lite "bibliotek" som lastes inn i begynnelsen av et script. Litt som "import" i Python eller header filer i C++. 

- [x] a) Begynn med å lage dere en fil "/home/ubuntu/base.sh" (den filen burde dere kanskje ha bedre kontroll på. Kanskje et github repo eller noe? Den trenger heller ikke ligge akkurat der, så lenge dere har kontroll på hvor den ligger.

```
Innholdet i den filen er slik:
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info () {
echo -e "${CYAN}$1${NC}"
}

error () {
echo -e "${RED}$1${NC}"
}

warn () {
echo -e "${YELLOW}$1${NC}"
}

ok () {
echo -e "${GREEN}$1${NC}"
}
Det som skjer i filen over, er at det defineres noen metoder som kan skrive ut tekst i andre farger.
La oss lage et nytt script. Vi kaller det "/home/ubuntu/fargetest.sh". Innholdet lar vi være enkelt:
#!/bin/bash
source /home/ubuntu/base.sh
info "Dette er en infotekst"
error "Dette er en feilmelding"
warn "Dette er en advarsel"
ok "Her er alt OK"
Legg merke til den andre linjen i scriptet. Ved å bruke "source" kommandoen inkluderer vi innholdet fra base.sh inn i det nye scriptet.
Før vi kjører scriptet bør vi gi det riktig tillatelse (må bare gjøres en gang):
chmod +x fargetest.sh
Så kan vi kjøre det:
./fargetest.sh
Hvis dere fikk ut tekst i forskjellige farger er det supert!
```

![[Pasted image 20230207165526.png]]

- [ ] b) Må fargetest.sh ligge i samme mappe som base.sh for at det skal fungere?

- [ ] c) Hvilke andre ting kunne man lagt inn i base.sh som andre script kunne hatt nytte av?

- [ ] d) Hvordan kan man gå frem for at base.sh (og andre nyttige script ) er tilgjengelige på alle servere?


2. [ ] (Del av oblig 2) Undersøk SQL syntaks for å telle antall linjer i en tabell. Bruk det til å lage en kommando som kan telle antall brukere i Bookface.
```
Gjør det samme for antall poster og kommentarer. Hint: bruk "show tables" i sql for å se hva tabellene heter.
For å kjøre en sql spørring rett fra kommandolinjen kan man prøve dette på selve db1:
cockroach --insecure --host=localhost sql --execute="SQL SYNTAX"
```

3. [ ] Undersøk hvordan shellscript fungerer i Linux. Prøv å lage et script som skriver ut en beskjed sammen med argumentet som ble gitt. 

```
For eksempel:
./mittscript.sh kyrre
hello kyrre
```

4. [ ] (Del av oblig 2) Undersøk hva "exit values" betyr for Linux kommandoer. Bruk f.eks. `ls` på en fil som finnes, og en som ikke finnes. 
5. [ ] Finn ut hvordan du kan bruke det sammen med en if-test i et shellscript til å sjekke om en kommando kjører suksessfullt. 

```
Man kan f.eks. lage et script som sjekker om en fil finnes (den bruker `ls` kommandoen).
./finnesfil.sh /home/ubuntu
Exists
./finnesfil.sh /home/tullbuntu
Does not exist
```

5. [ ] Lag et alias i shellet på manager som stopper apache2 på begge webserverene (ikke de som kjører Docker).


6. [ ] Bruk `openstack help` til å finne andre kommandoer man kan kjøre. F.eks. hva med å skru av en VM fra kommandolinjen (og på igjen)?

7. [ ] (Del av oblig 2) Se om du kan flytte floating-IP fra balancer til en annen VM ved hjelp av openstack kommandoer på manager. 
8. [ ] Kan denne kommandoen bli nyttig i noen situasjoner?

8. [ ] (Del av oblig 2) Tenk mise en place og lag en "oppskrift" på det å gå ut og inn av produksjon. En oppskrift er som en prosedyre som hvert gruppemedlem kan gjennomføre på samme måte med samme resultat. Prøv å følge den hver gang dere skal gjøre noe med arkitekturen som dere tror vil gjøre Bookface midlertidig utilgjengelig. 
```
Husk: I oppetidspillet taper man penger om siden er nede, men om man har en side oppe som kan bli vist, selv om det ikke er Bookface, så tjener man fortsatt 10%.
```

9. [ ] Hva gjør kommandoen `wc`?

10. [ ] Hva gjør kommandoene `df -h` og `du -sm * | sort -n`?


```
Noe å tenke på fremover:
Etterhvert som maskiner begynner å gå ned, ville det ikke være en fordel med et script som startet dem opp igjen? Noe slikt kan lages bit for bit. Først kan man lage et script som sørger for at alle VM'ene som skal være oppe faktisk er oppe. Deretter kan man begynne å kjøre scriptet automatisk fra manager ved hjelp av cron. En ny utfordring blir da å sørge for at en server som kommer opp igjen faktisk starter de tjenestene som skal kjøres. Jeg tenker da spesielt på det som skal kjøre som Docker og cockroachdb databasen. Her må dere kanskje teste litt, gjerne på en en egen liten test-server for å se om ting kommer opp igjen etter reboot.
```