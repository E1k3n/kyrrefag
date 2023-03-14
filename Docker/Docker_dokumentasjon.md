 sudo docker run --name bookface1 -p 49001:80 -it -d -v /home/ubuntu/bookface/code:/var/www/html bookface:v1  
  Brukes for å kjøre docker imaget vårt  
    Exposer port 49001  
    -d for å kjøre i bakgrunn  
    legger til /home/ubuntu/bookface/code som volum til docker instansen  
      Mulig å gjøre endringer i koden uten å måtte bygge dockerfilen på nytt igjenn, eller å restarte docker instansen.  
