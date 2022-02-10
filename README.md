# Introduction

## Info progetto
Nome: **Alessandro Pucci**,  
Matricola: **317172**,  
Titolo: **Movies**.  

# Spiegazione
L'applicazione che ho sviluppato è una semplice app per mostrare informazioni riguardanti film, serie tv e persone.
L'idea è di poter avere una piattaforma dove poter vedere informazioni riguardanti tante opere, e poter anche capire quale sia il servizio di streaming da cui poterli vedere, senza dover fare ulteriori ricerche su internet.
Se disponibile infatti verrà mostrata la piattaforma di streaming in cui è presente.
  
L'utente inoltre può cercare film e metterli tra i preferiti per poterli salvare per il futuro, una sorta di watch later (questa funzione è disponibile solo previa registrazione o login).

## Casi d'uso
L'utente può entrare nell'app decidendo di registrarsi o di evitare la registrazione/login e andare direttamente alla fase di utilizzo.
L'utente quindi decide di sfogliare la homepage dove troverà film, serie tv e personaggi dello spettacolo in base ai più popoplari, o quelli in tendenza, decidendo di aprirne uno per leggere una breve descrizione o qualche trailer che è stato pubblicato.
Altrimenti se ha sentito parlare di un film da un amico può decidere di cercarlo dalla pagina ricerca e vedere qualche info e su quale piattaforma streaming potrebbe guardarlo.  
  
Se l'utente al momento non ha la possibilità di vedere il film scelto può decidere di metterlo fra i preferiti, se loggato, e in seguito ritrovarlo alla prossima apertura dell'app.

## Esperienza utente
La UI presenta elementi di facile utilizzo per device mobile, come liste orizzontali e pagine a scorrimento verticale, in particolare per la UX si è pensato di creare (oltre il navbar in alto con il pulsante del menù) una bottomNavigationBar perchè più facilmente raggiungibile negli smartphone con il pollice, questa presenta i pulsanti per raggiungere le principali pagine: home, preferiti, ricerca e profilo.

I campi per inserire gli input sono mirati ad aprire la keyboard dello smartphone con il tipo che l'app si aspetta (nel caso della mail il textfield apre la keyboard con i suggerimenti le mail già inserite in altri field della stessa tipologia e con i pulsanti della tastiera per velocizzare l'inserimento di un mail).
  
Splashscreen
![splashscreen](/movies/assets/screenshots/Splashscreen.png?raw=true "Splashcreen")
---
Welcome page
![Welcome page](/movies/assets/screenshots/Welcome_page.png?raw=true "Welcome page")
---
Signup page
![Signup page](/movies/assets/screenshots/sign_up_page.png?raw=true "Signup page")
---
Homepage
![Homepage](/movies/assets/screenshots/homepage.png?raw=true "Homepage")
---
Search page
![Search page](/movies/assets/screenshots/search_page.png?raw=true "Search page")
---
Sidebar
![Sidebar](/movies/assets/screenshots/sidebar.png?raw=true "Sidebar")
---
Details
![Details](/movies/assets/screenshots/details.png?raw=true "Details")

# Techs
Le tecnologie utilizzate: 
- per le APIs ho utilizzato il servizio di TMDB.com, un portale dove si possono trovare APIs per una vasta collezione di dati riguardanti film, serie tv e personaggi dello spettacolo.
Per poterle utilizzare occorre creare un account sul sito ed in seguito fare richieste autenticate con api_key o bearer token, dipendentemente da quale versione di API si intende usare.
- login/Registrazione vengono effettuati utilizzando un json interno che viene gestito dall'app per vedere se l'utente è registrato o meno e in tal caso vedere se la password corrisponde o meno.
- in seguito al login/registrazione si possono sfruttare le funzionalità dei preferiti.
- internamente lo scaffolding dell'app nella folder lib è stato effettuato seguendo la struttura che di norma utilizzo nel mio lavoro dove utilizzo React, una folder con i componenti grafici, quindi folder dentro la root in cui ci sono costanti, funzioni utilities che possono essere usate in più parti del codice (come i mapper), models che utilizzo all'interno del progetto, questo rende il codice più leggibile e più prevedibile perchè lo sviluppatore, se dovesse tornare sul codice per nuove feature o per bugfix, sa già cosa aspettarsi da un oggetto.
- per salvare e cachare le risorse ricevute dalle api e le informazioni riguardanti l'utente ho deciso di sfruttare __HiveDB__ invece di un file JSON o sqflite viste le performance e la facilità d'utilizzo.
- un altro pacchetto utilizzato è __provider__, che è servito a poter centralizzare gli stati e i metodi che li aggiornano, per riutilizzarli poi nei vari widget che sfruttano i dati degli stati e i loro cambiamenti. Ho creato in tutto 5 providers, quindi ho utilizzato MultiProviders per poterli gestire al meglio.
- per gestire i link che escono dall'app come quelli verso youtube o verso siti esterni ho usato __url_launcher__.
- __percent_indicator__ è stato installato per poter creare un indicatore grafico per il voto globale ricevuto dal film o serie tv.
- __device_info_plus__ mi è servito per individuare le informazioni riguardanti il device che esegue l'app ed usarle per adattare l'interfaccia grafica.


Come mostrato nel file pubspec.yml i restanti pacchetti esterni usati sono tmdb_api e flutter_icons, il primo per poter sfruttare al meglio le APIs di tmdb, invece di dover seguire la libreria standard di flutter (http), che mostrava problemi di configurazioni con le APIs di tmdb, il secondo invece è stato sfruttato per creare l'icona dell'app.
