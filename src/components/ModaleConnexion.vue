<script>
import { session } from '../services/session.js';
import { URL_API } from '../services/config.js';

export default {
   name: 'ModaleConnexion',
   emits: ['fermer'],
   data() {
      return {
         form: { mail: '', motDePasse: '' },
         message: '',
         typeMessage: ''
      };
   },
   methods: {
      connexion() {
         fetch(URL_API + '/connexionUtilisateur.php', {
            method: 'POST',
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(this.form)
         })
            .then(reponse => reponse.json())
            .then(donnees => {
               if (donnees.succes) {
                  session.connecter(donnees.utilisateur.pseudo);
                  this.$emit('fermer');
               } else {
                  this.message = donnees.message;
                  this.typeMessage = 'erreur';
               }
            });
      }
   }
};
</script>

<template>
   <div class="fond-modale" @click.self="$emit('fermer')">
      <div class="modale">
         <h2>Connexion</h2>
         <div v-if="message" :class="['message-modale', 'message-' + typeMessage]">
            {{ message }}
         </div>
         <div class="champ">
            <label>Adresse mail</label>
            <input type="email" v-model="form.mail" placeholder="exemple@mail.com">
         </div>
         <div class="champ">
            <label>Mot de passe</label>
            <input type="password" v-model="form.motDePasse" placeholder="••••••••">
         </div>
         <div class="actions-modale">
            <button class="btn btn-secondaire" @click="$emit('fermer')">Annuler</button>
            <button class="btn btn-principal" @click="connexion">Se connecter</button>
         </div>
      </div>
   </div>
</template>
