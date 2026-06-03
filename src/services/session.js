// ####################################################################
// # session.js
// # État de connexion partagé entre tous les composants.
// # On utilise reactive() de Vue : pas besoin de Pinia/Vuex à ce stade.
// ####################################################################

import { reactive } from 'vue';
import { URL_API } from './config.js';

export const session = reactive({
   connecte: false,
   pseudo: '',

   // Vérifie auprès du PHP si une session est active
   verifier() {
      fetch(URL_API + '/session.php', { credentials: 'include' })
         .then(reponse => reponse.json())
         .then(donnees => {
            this.connecte = donnees.connecte;
            this.pseudo = donnees.connecte ? donnees.pseudo : '';
         });
   },

   // Met à jour l'état après une connexion réussie
   connecter(pseudo) {
      this.connecte = true;
      this.pseudo = pseudo;
   },

   // Déconnexion
   deconnecter() {
      fetch(URL_API + '/deconnexion.php', { credentials: 'include' })
         .then(reponse => reponse.json())
         .then(() => {
            this.connecte = false;
            this.pseudo = '';
         });
   }
});
