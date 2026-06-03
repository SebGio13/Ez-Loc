<script>
export default {
   name: 'AccueilView'
};
</script>

<template>
   <div>
      <section class="hero">
         <h1>Bienvenue sur EzLoc</h1>
         <p>
            La plateforme qui vous permet de louer une salle et d'organiser
            vos compétitions e-sport en toute simplicité. Trouvez le lieu idéal,
            réservez en quelques clics et lancez votre tournoi !
         </p>
         <router-link to="/salles" class="btn btn-secondaire">
            Voir les salles disponibles
         </router-link>
      </section>

      <section class="presentation">
         <div class="carte-info">
            <h3>1. Trouvez une salle</h3>
            <p>Parcourez les salles disponibles selon la ville, la capacité ou le type.</p>
         </div>
         <div class="carte-info">
            <h3>2. Organisez votre tournoi</h3>
            <p>Réservez la salle et enregistrez votre compétition et ses jeux en une seule étape.</p>
         </div>
         <div class="carte-info">
            <h3>3. Rassemblez les joueurs</h3>
            <p>Les autres utilisateurs peuvent s'inscrire à votre compétition.</p>
         </div>
      </section>
   </div>
</template>
