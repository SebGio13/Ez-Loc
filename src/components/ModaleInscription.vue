<script>
import { URL_API } from '../services/config.js';

export default {
   name: 'ModaleInscription',
   emits: ['fermer', 'inscrit'],
   data() {
      return {
         form: {
            nom: '', prenom: '', pseudo: '',
            telephone: '', mail: '', motDePasse: ''
         },
         message: '',
         typeMessage: ''
      };
   },
   methods: {
      inscription() {
         fetch(URL_API + '/inscription.php', {
            method: 'POST',
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(this.form)
         })
            .then(reponse => reponse.json())
            .then(donnees => {
               this.message = donnees.message;
               this.typeMessage = donnees.succes ? 'succes' : 'erreur';
               if (donnees.succes) {
                  // On prévient le parent pour basculer vers la connexion
                  setTimeout(() => this.$emit('inscrit'), 1500);
               }
            });
      }
   }
};
</script>

<template>
   <div class="fond-modale" @click.self="$emit('fermer')">
      <div class="modale">
         <h2>Inscription</h2>
         <div v-if="message" :class="['message-modale', 'message-' + typeMessage]">
            {{ message }}
         </div>
         <div class="champ">
            <label>Nom</label>
            <input type="text" v-model="form.nom">
         </div>
         <div class="champ">
            <label>Prénom</label>
            <input type="text" v-model="form.prenom">
         </div>
         <div class="champ">
            <label>Pseudo</label>
            <input type="text" v-model="form.pseudo">
         </div>
         <div class="champ">
            <label>Téléphone</label>
            <input type="tel" v-model="form.telephone" maxlength="10">
         </div>
         <div class="champ">
            <label>Adresse mail</label>
            <input type="email" v-model="form.mail">
         </div>
         <div class="champ">
            <label>Mot de passe</label>
            <input type="password" v-model="form.motDePasse">
         </div>
         <div class="actions-modale">
            <button class="btn btn-secondaire" @click="$emit('fermer')">Annuler</button>
            <button class="btn btn-principal" @click="inscription">S'inscrire</button>
         </div>
      </div>
   </div>
</template>
