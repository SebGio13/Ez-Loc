<script>
import { session } from './services/session.js';
import ModaleConnexion from './components/ModaleConnexion.vue';
import ModaleInscription from './components/ModaleInscription.vue';

export default {
   name: 'App',
   components: { ModaleConnexion, ModaleInscription },
   data() {
      return {
         session,                 // état de connexion partagé
         modaleActive: null       // 'connexion' | 'inscription' | null
      };
   },
   // Au démarrage, on vérifie si une session PHP est déjà ouverte
   mounted() {
      session.verifier();
   },
   methods: {
      ouvrirModale(nom) {
         this.modaleActive = nom;
      },
      fermerModale() {
         this.modaleActive = null;
      },
      // Quand l'inscription réussit, on bascule vers la connexion
      basculerVersConnexion() {
         this.modaleActive = 'connexion';
      },
      deconnexion() {
         session.deconnecter();
      }
   }
};
</script>

<template>
   <nav class="navbar">
      <!-- Logo + nom : retour à l'accueil -->
      <router-link to="/" class="navbar-gauche">
         <img src="./assets/logo.png" alt="Logo EzLoc">
         <span class="nom-site">EzLoc</span>
      </router-link>

      <!-- Onglets centraux -->
      <div class="navbar-milieu">
         <router-link to="/salles">Salles</router-link>
         <router-link to="/competitions">Compétitions</router-link>
      </div>

      <!-- Connexion / inscription ou pseudo + déconnexion -->
      <div class="navbar-droite">
         <template v-if="session.connecte">
            <span class="pseudo">Bonjour, {{ session.pseudo }}</span>
            <button class="btn btn-danger" @click="deconnexion">Déconnexion</button>
         </template>
         <template v-else>
            <button class="btn btn-secondaire" @click="ouvrirModale('connexion')">Connexion</button>
            <button class="btn btn-principal" @click="ouvrirModale('inscription')">Inscription</button>
         </template>
      </div>
   </nav>

   <!-- Affichage de la page courante -->
   <router-view v-slot="{ Component }">
      <component :is="Component" @demander-connexion="ouvrirModale('connexion')" />
   </router-view>

   <!-- Modales globales -->
   <ModaleConnexion
      v-if="modaleActive === 'connexion'"
      @fermer="fermerModale" />

   <ModaleInscription
      v-if="modaleActive === 'inscription'"
      @fermer="fermerModale"
      @inscrit="basculerVersConnexion" />
</template>
