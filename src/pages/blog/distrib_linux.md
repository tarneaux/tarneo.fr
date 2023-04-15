---
title: "Quelle distribution Linux choisir?"
pubDate: 2023-04-14
layout: /src/layouts/BlogPost.astro
---

# Introduction

Si vous êtes un utilisateur de longue date de Windows, vous pouvez vous sentir un peu perdu lorsque vous décidez de passer à Linux: le premier choix à faire est difficile et c'est celui de la distribution. Dans cet article, je vais donc essayer de vous mettre sur la voie vers une distribution Linux qui vous conviendra.

Avant de commencer, je me dois de parler de l'incontournable: quand on cherche une distribution linux, on tombe très vite sur des sites qui listent plusieurs distributions. Ces sites ne sont pas là pour vous aider, mais juste pour rapporter de l'argent, et je ne pense pas avoir à rentrer dans les détails ici: ce ne sont pas des bons conseils. Contrairement à ceux-ci, cet article est modifiable par n'importe qui[^1] (si c'est pertinent) et je cherche uniquement à vous mettre sur la bonne voie.

# La réponse courte


Bon, au cas où vous n'auriez pas tout votre temps, je vais vous donner une solution rapide qui conviendra à la plupart des gens. Notez que moi-même j'ai du mal à recommender une distribution car il en existe beaucoup de très bonnes, et je suis sûr que je vais me faire des ennemis en proposant une solution: il y aura toujours quelqu'un pour dire qu'il manque ceci ou cela à une distribution, mais je dirais juste que si ça marche pour vous, n'importe quelle distribution est la bonne.
À mon avis, vous pouvez juste installer [Fedora](https://getfedora.org/en/workstation/download/). Il existe de nombreux tutoriels sur le processus d'installation de cette distribution.

# La réponse longue et complète

Si vous utilisez votre ordinateur juste pour internet, vous n'avez pas besoin de lire cette section: n'importe quelle distribution fera l'affaire. Gardez le conseil de la section d'avant et utilisez Fedora.

## Qu'est-ce qu'une distribution? Pourquoi y en a-t-il autant?

Rappelons d'abord ce qu'est une distribution linux: ce n'est qu'un ensemble de programmes qui vous sont donnés ensemble, principalement (le plus souvent) un bureau graphique (l'interface utilisateur), un gestionnaire de paquets (ce qui sert à installer ou désinstaller des programmes) et autres (suites bureautiques, navigateurs web, etc.).

Les distributions ne sont pas toutes faites de zéro: il en existe en réalité un arbre avec quelques distributions mères, principalement Debian (dont dérive la très connue Ubuntu), RHEL (Red Hat Enterprise Linux, sur laquelle est basée fedora), Arch et Gentoo. Si vous voulez vous faire une idée de la quantité de distributions existantes, vous pouvez trouver un [arbre des distributions sur Wikipedia](https://upload.wikimedia.org/wikipedia/commons/8/8c/Linux_Distribution_Timeline_Dec._2020.svg). Toutes les distributions qui partagent la même distribution mère ont une chose en commun: leur gestionnaire de paquets. Cela déterminera aussi la disponibilité des différents programmes et la fréquence de leurs mises à jour:
- Debian a un cycle très lent: avec une nouvelle version tous les 2 ans, les mises à jour sont rares et les programmes sont souvent un peu dépassés.
- RHEL a un cycle plus rapide: une nouvelle version tous les 6 mois, et les mises à jour sont plus fréquentes.
- Arch et Gentoo sont des distributions qui ne sont pas basées sur un cycle de version: les mises à jour sont très fréquentes, mais il faut savoir ce que vous faites. N'essayez surtout pas d'installer une de ces distributions si c'est votre première fois sur Linux, car vous devrez lire des centaines de pages de wikis pour comprendre ne serait-ce que le processus d'installation[^2].

D'accord, on a à présent une base, et donc un gestionnaire de paquets. Mais si vous ne voulez pas avoir à tout installer manuellement, il vous faudra trouver une distribution avec un certain environnement de bureau (ou DE, Desktop Environment en anglais). Comme bureaux populaires, on peut citer GNOME (moderne et très peu customisable), KDE (qui se rapproche plus de l'interface de windows, avec une barre des tâches en bas), ou encore XFCE (solution adaptée pour des machines moins puissantes). GNOME est de loin le plus fréquent, étant préinstallé sur les versions originales de Fedora, Ubuntu, openSUSE et j'en passe.

Ensuite, il y a certaines distributions pensées pour une utilisation spécifique: Pop!_OS est de loin la meilleure solution non seulement pour le jeu vidéo mais aussi pour la bureautique, et si vous êtes tenté.e par Ubuntu, elle saura vous satisfaire.

La raison pour laquelle j'ai recommandé Fedora plus haut est qu'elle propose un bon compromis entre la vitesse de mise à jour et la stabilité (Fedora étant basée sur RHEL).

Voilà, maintenant vous savez tout pour choisir une distribution. Trouvez les outils qui vous conviennent, ou bien essayez plusieurs distributions pour trouver celle qui vous convient le mieux.

Attention tout de même à ne pas commencer le distro-hopping: c'est une pratique qui consiste à changer de distribution toutes les semaines. Au lieu de ça, prenez une distribution avec un bon gestionnaire de paquets et vous pourrez faire à peu près ce que vous voulez.


[^1]: Vous pouvez proposer des modifications sur [github](https://github.com/tarneaux/tarneo.fr-astro) ou en [m'envoyant un mail](/).
[^2]: Si vous voulez essayer une distribution basée sur Arch, je vous conseille [EndeavourOS](https://endeavouros.com/), qui est une distribution basée sur Arch mais plus simple d'installation et de configuration. Gentoo n'est pas du tout faite pour être installée directement: son avantage est justement un accès très direct à la manière dont le système est construit.
