Image Docker de développement pour le Unicorn sur Raspberry PI
==============================================================

Cette image embarque la suite de développement Python 2.7 , avec pip ainsi que Git et build-essentials.
L'image n'a pas été optimsiée pour sa taille.

Testée avec un Raspberry Pi Zero, mais toute la famille Raspberry (Pi2, Pi3, Pi Zero) est compatible.

La librairie Pimoroni unifiée pour les Unicorn HAT et pHAT est installée.

Cette image doit être lancée avec l'option `--privileged` , comme suit :

    docker run -it --privileged alexellis2/python2-unicornhat-dev:2 

La librairie détecte automatiquement le type de shield employé.

Le répertoire par défaut est celui des exemples. Vous pouvez donc directement tester les démos, par exemple :

	python rainbow.py
	
Voir le [listing complet des exemples](https://github.com/pimoroni/unicorn-hat/tree/master/examples)

Certains exemples requièrent des librairies Python (Numpy par exemple) qui n'ont pas été incluses par défaut.
	
A propos des Unicorn HAT et pHAT
--------------------------------
Le "Unicorn" est un shield pour Raspberry Pi qui fournit un chouette ensemble de leds RGB (bien puissantes, attention aux yeux).
Ces LEDs sont adressables individuellement (ce sont des WS2812B).

C'est un produit de [Pimoroni](https://shop.pimoroni.com) qui existe en deux versions :

* Le [Unicorn pHAT](http://shop.pimoroni.com/products/unicorn-phat) que j'ai testé, contient 8x4 LEDs, et est du même format que votre Raspberry Pi Zero
* Le [Unicorn HAT](http://shop.pimoroni.com/products/unicorn-hat) est destiné au Raspberry Pi 2 et 3, plus grands, et dispose de 8x8 LEDs
