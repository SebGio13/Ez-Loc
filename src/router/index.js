// ####################################################################
// # router/index.js
// # Définit les routes de l'application (vue-router)
// ####################################################################

import { createRouter, createWebHistory } from 'vue-router';

import Accueil from '../views/Accueil.vue';
import Salles from '../views/Salles.vue';
import Competitions from '../views/Competitions.vue';

const routes = [
   { path: '/', name: 'accueil', component: Accueil },
   { path: '/salles', name: 'salles', component: Salles },
   { path: '/competitions', name: 'competitions', component: Competitions }
];

const router = createRouter({
   // Vue CLI fournit process.env.BASE_URL : c'est la convention standard
   history: createWebHistory(process.env.BASE_URL),
   routes
});

export default router;
