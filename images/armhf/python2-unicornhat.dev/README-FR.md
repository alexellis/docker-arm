Image Docker de développement pour le Unicorn sur Raspberry PI
==============================================================

Cette image embarque la suite de décveloppement python 2.7 , avec pip ainsi que as git et build-essentials.
L'image n'a pas été optimsiée pour sa taille.

Testée avec un Raspberry Pi Zero, mais toute la famille Raspberry (Pi2, Pi3, Pi Zero) est compatible.

La librairie Pimoroni unifiée pour les Unicorn Hat et pHat est installée.

Cette image doit être lancée avec l'option `--privileged` , comme suit :

    docker run --privileged alexellis2/python2-unicornhat-dev:2 

La librairie détecte automatiquement le type de shield employé.

Le répertoire par défaut est celui des exemples. Vous pouvez donc directement tester les démos, par exemple :

	python rainbow.py
	
Voir le [listing complet des exemples](https://github.com/pimoroni/unicorn-hat/tree/master/examples)
	
A propos des Unicorn Hat et pHat
--------------------------------
Le "Unicorn" est un shield pour Raspberry Pi qui fournit un chouette ensemble de leds RGB leds (bien puissantes, attention aux yeux).
Ces leds sont adressables individuellement (ce sont des WS2812B).

C'est un produit de [Pimoroni](https://shop.pimoroni.com) qui existe en deux versions :

	* Le [Unicorn pHat](http://shop.pimoroni.com/products/unicorn-phat) que j'ai testé, contient 8x4 leds, et est du même format que votre Raspberry Pi Zero
	* Le [Unicorn Hat](http://shop.pimoroni.com/products/unicorn-hat) est destiné au Raspberry Pi 2 et 3, plus grands, et dispose de 8x8 leds

	
@actuino
http://www.actuino.fr/