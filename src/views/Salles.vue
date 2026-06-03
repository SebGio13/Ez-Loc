<script>
import { session } from '../services/session.js';
import { URL_API } from '../services/config.js';

export default {
   name: 'SallesView',
   // Permet de demander l'ouverture de la modale connexion au parent (App.vue)
   emits: ['demander-connexion'],
   data() {
      return {
         session,
         salles: [],
         recherche: '',

         // Modale de location
         modaleOuverte: false,
         jeux: [],
         formLocation: {
            idSalle: null,
            nomSalle: '',
            nomCompetition: '',
            dateDebut: '',
            dateFin: '',
            jeux: []
         },
         messageModale: '',
         typeMessage: ''
      };
   },
   mounted() {
      this.chargerSalles();
   },
   methods: {
      chargerSalles() {
         const url = URL_API + '/salles.php?recherche=' + encodeURIComponent(this.recherche);
         fetch(url, { credentials: 'include' })
            .then(reponse => reponse.json())
            .then(donnees => {
               if (donnees.succes) {
                  this.salles = donnees.salles;
               }
            });
      },

      chargerJeux() {
         fetch(URL_API + '/jeux.php', { credentials: 'include' })
            .then(reponse => reponse.json())
            .then(donnees => {
               if (donnees.succes) {
                  this.jeux = donnees.jeux;
               }
            });
      },

      ouvrirLocation(salle) {
         if (!this.session.connecte) {
            this.$emit('demander-connexion');
            return;
         }
         this.formLocation = {
            idSalle: salle.idSalle,
            nomSalle: salle.nom,
            nomCompetition: '',
            dateDebut: '',
            dateFin: '',
            jeux: []
         };
         this.messageModale = '';
         this.typeMessage = '';
         this.modaleOuverte = true;
         this.chargerJeux();
      },

      fermerLocation() {
         this.modaleOuverte = false;
      },

      louer() {
         fetch(URL_API + '/louer.php', {
            method: 'POST',
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(this.formLocation)
         })
            .then(reponse => reponse.json())
            .then(donnees => {
               this.messageModale = donnees.message;
               this.typeMessage = donnees.succes ? 'succes' : 'erreur';
               if (donnees.succes) {
                  setTimeout(() => this.fermerLocation(), 1500);
               }
            });
      }
   }
};
</script>

<template>
   <div class="contenu">
      <h2>Salles disponibles</h2>

      <div class="barre-recherche">
         <input
            type="text"
            v-model="recherche"
            @input="chargerSalles"
            placeholder="Rechercher par nom, ville ou type de salle...">
      </div>

      <div v-if="salles.length === 0" class="message-vide">
         Aucune salle ne correspond à votre recherche.
      </div>

      <div class="grille">
         <div class="carte" v-for="salle in salles" :key="salle.idSalle">
            <h3>{{ salle.nom }}</h3>
            <span class="etiquette">{{ salle.libelType }}</span>
            <p class="info">📍 {{ salle.adresse }}, {{ salle.codePostal }} {{ salle.ville }}</p>
            <p class="info">👥 Capacité : {{ salle.capacite }} personnes</p>
            <p class="prix">{{ salle.prixLocation }} €</p>

            <button
               v-if="session.connecte"
               class="btn btn-principal"
               @click="ouvrirLocation(salle)">
               Louer cette salle
            </button>
            <button v-else class="btn btn-secondaire" @click="$emit('demander-connexion')">
               Connectez-vous pour louer
            </button>
         </div>
      </div>

      <!-- Modale de location -->
      <div class="fond-modale" v-if="modaleOuverte" @click.self="fermerLocation">
         <div class="modale">
            <h2>Louer « {{ formLocation.nomSalle }} »</h2>
            <div v-if="messageModale" :class="['message-modale', 'message-' + typeMessage]">
               {{ messageModale }}
            </div>
            <div class="champ">
               <label>Nom de la compétition</label>
               <input type="text" v-model="formLocation.nomCompetition" placeholder="Ex : Tournoi d'été 2026">
            </div>
            <div class="champ">
               <label>Date de début</label>
               <input type="date" v-model="formLocation.dateDebut">
            </div>
            <div class="champ">
               <label>Date de fin</label>
               <input type="date" v-model="formLocation.dateFin">
            </div>
            <div class="champ">
               <label>Jeux de la compétition</label>
               <div class="liste-jeux">
                  <label v-for="jeu in jeux" :key="jeu.idJeu">
                     <input type="checkbox" :value="jeu.idJeu" v-model="formLocation.jeux">
                     <span class="nom-jeu">{{ jeu.nomJeu }}</span>
                     <small>{{ jeu.libelGenre }}</small>
                  </label>
               </div>
            </div>
            <div class="actions-modale">
               <button class="btn btn-secondaire" @click="fermerLocation">Annuler</button>
               <button class="btn btn-principal" @click="louer">Réserver</button>
            </div>
         </div>
      </div>
   </div>
</template>
