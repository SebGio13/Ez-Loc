<script>
import { session } from '../services/session.js';
import { URL_API } from '../services/config.js';

export default {
   name: 'CompetitionsView',
   emits: ['demander-connexion'],
   data() {
      return {
         session,
         competitions: [],
         recherche: ''
      };
   },
   mounted() {
      this.chargerCompetitions();
   },
   methods: {
      chargerCompetitions() {
         const url = URL_API + '/competitions.php?recherche=' + encodeURIComponent(this.recherche);
         fetch(url, { credentials: 'include' })
            .then(reponse => reponse.json())
            .then(donnees => {
               if (donnees.succes) {
                  this.competitions = donnees.competitions;
               }
            });
      },

      sInscrire(competition) {
         if (!this.session.connecte) {
            this.$emit('demander-connexion');
            return;
         }
         fetch(URL_API + '/participer.php', {
            method: 'POST',
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ idCompetition: competition.idCompetition })
         })
            .then(reponse => reponse.json())
            .then(donnees => {
               alert(donnees.message);
               if (donnees.succes) {
                  this.chargerCompetitions();
               }
            });
      }
   }
};
</script>

<template>
   <div class="contenu">
      <h2>Compétitions ouvertes aux inscriptions</h2>

      <div class="barre-recherche">
         <input
            type="text"
            v-model="recherche"
            @input="chargerCompetitions"
            placeholder="Rechercher par nom de compétition ou organisateur...">
      </div>

      <div v-if="competitions.length === 0" class="message-vide">
         Aucune compétition ne correspond à votre recherche.
      </div>

      <div class="grille">
         <div class="carte" v-for="competition in competitions" :key="competition.idCompetition">
            <h3>{{ competition.nom }}</h3>
            <p class="info">🎮 Organisée par {{ competition.organisateur }}</p>
            <p class="info">👥 {{ competition.nbParticipants }} participant(s)</p>
            <div>
               <span class="etiquette" v-for="jeu in competition.jeux" :key="jeu">{{ jeu }}</span>
            </div>

            <button
               v-if="session.connecte"
               class="btn btn-principal"
               @click="sInscrire(competition)">
               S'inscrire
            </button>
            <button v-else class="btn btn-secondaire" @click="$emit('demander-connexion')">
               Connectez-vous pour vous inscrire
            </button>
         </div>
      </div>
   </div>
</template>
