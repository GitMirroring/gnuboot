---
title: Revisión del código
x-reviewed: true
...

Nuestros planes a corto plazo y la necesidad de ayuda
=====================================================

GNU Boot está buscando colaboradores para varios trabajos, tanto
sencillos como técnicos.

Información
-----------

El nombre Libreboot tiene una larga historia en la comunidad del
software libre.
La mayoría de menciones fueron pensadas para referirse
al software de arranque que era libre, y no hay manera de editar esas
menciones para referirse al software de arranque libre con un nombre
diferente. Por lo tanto, necesitamos ayuda de la comunidad en general
para informar a la gente sobre la inclusión de software que no es libre
en los lanzamientos de Libreboot.

Otra forma de ayudar a GNU Boot y tomar partido por el software
plenamente libre es cambiar las URL en toda la web de <libreboot.org> a
<gnu.org/software/gnuboot>, para asegurarse de que el software
mencionado es software libre de verdad.

También puedes ayudar a nuestro proyecto informando a la gente sobre GNU
boot u otro software de arranque 100% libre.

Documentación y pruebas
-----------------------

Necesitamos ayuda para revisar y arreglar esta página web (que también
contiene la documentación). Muchas páginas son heredadas de Libreboot y
podrían estar desactualizadas o ser específicas de Libreboot.

Se tienes un programador flash que funcioná (esto es un hardware
especial que es necesario para instalar GNU Boot en varios
computadores) y que sabes como usar esto hardware sin romper
computadores, necesitamos realmente tu ayuda, especialmente porque
pocas personas saben hacer esto.

Aún no tenemos buena instrucciones para usare esto hardware sin ningún
percance, pero hasta que tengamos eso, necesitamos ayuda de personas
que saben usar esto hardware, por lo menos para testar los
lanzamientos no probado y para probar o actualizar instrucciones de
instalación.

Actualmente tenemos una lista de los computadores que aún no han sido
probados en el [bug 64754](https://savannah.gnu.org/bugs/?64754).

En cuanto a informar de lo que has probado, puedes abrir una nueva
incidencia o enviar un correo a la lista de correo
[gnuboot](http://lists.gnu.org/mailman/listinfo/gnuboot) o
[Bug-gnuboot](https://lists.gnu.org/mailman/listinfo/bug-gnuboot).

Contribución técnica
--------------------

GNU Boot utiliza actualmente versiones antiguas de software upstream
(como Coreboot, GRUB, etc), por lo que es necesario actualizarlas. Los
parches deben enviarse a la lista de correo
[gnuboot-patches](http://lists.gnu.org/mailman/listinfo/gnuboot-patches).

También tenemos un rastreador de errores en
https://savannah.gnu.org/bugs/?group=gnuboot que contiene una lista de
errores que deben corregirse.

Cómo contribuir
===============

Repositorios de GNU Boot
------------------------

El desarrollo de GNU Boot se realiza utilizando el sistema de control de
versiones Git. Consulte la [documentación oficial de
Git](https://git-scm.com/doc) si no sabe cómo usar Git.

El repositorio principal de GNU Boot está en
<https://git.savannah.gnu.org/cgit/gnuboot.git>. También contiene la
documentación/sitio web y el código para construirlo.

GNU Boot también tiene dos repositorios adicionales: uno para
[presentaciones hechas en
conferencias](https://git.savannah.gnu.org/cgit/gnuboot/presentations.git)
o para [reflejar código fuente que
desapareció](https://git.savannah.gnu.org/cgit/gnuboot/acpica.org-mirror.git).

Puede descargar cualquiera de estos repositorios, realizar los cambios
que desee y enviarlos siguiendo las instrucciones que se indican a
continuación.

Pruebe sus modificaciones
-------------------------

Para las contribuciones técnicas o para contribuir al sitio web, puede
que necesite probar sus modificaciones.

Esto actualmente requiere usar una distribución GNU/Linux ya que
construir GNU Boot o su sitio web en otros sistemas operativos no está
probado.

Para instrucciones sobre la construcción de GNU Boot, puede consultar
las [instrucciones de construcción](docs/build/).

Sitio web
---------

El sitio web está en el código fuente de GNU Boot dentro del directorio
website/pages.

Actualmente está escrito en Markdown, concretamente en su versión
Pandoc, y las páginas HTML estáticas se generan con
[lbssg](https://libreboot.org/docs/sitegen), un generador de sitios web
estáticos.

La documentación que explica cómo construirlo se encuentra en
[README](https://git.savannah.gnu.org/cgit/gnuboot.git/tree/website/README)
dentro del directorio del sitio web.

Nombre no requerido
-------------------

Muchos proyectos que utilizan licencias de software libre aceptan
contribuciones de cualquiera, pero en muchos casos también necesitan
poder rastrear la titularidad de los derechos de autor de las
contribuciones por diversas razones.

Esto normalmente hace que las contribuciones anónimas o pseudónimas al
código sean más complicadas, pero eso no las hace imposibles.

La principal dificultad para GNU Boot es que GNU boot quiere contribuir
con algunos de sus cambios a otros proyectos que reutiliza como
Coreboot, GRUB, Guix, y por lo tanto necesitamos que las contribuciones
al código o documentación de GNU Boot sean compatibles con la forma en
que otros proyectos rastrean la titularidad de los derechos de autor.

Por eso, si quieres contribuir de forma anónima o pseudónima la mejor
forma es contactar con nosotros públicamente (por ejemplo en nuestra
lista de correo, usando un correo y un nombre que uses sólo para eso)
para que podamos estudiarlo e intentar encontrar formas que funcionen
para GNU Boot pero también potencialmente para otros proyectos upstream
y de esta forma permitirte contribuir a una amplia variedad de proyectos
bajo licencias libres con mucha menos fricción.

Ya lo hemos investigado para varios casos, y las contribuciones
pseudónimas no deberían tener ningún problema para contribuir a la mayor
parte de la documentación/sitio web de GNU Boot y para traducirlos, así
como para los paquetes Guix, y para la mayoría de las partes del sistema
de construcción de GNU Boot. En cuanto a las contribuciones que incluyen
parches para otros proyectos upstream como Coreboot, necesitaríamos
estudiarlo.

Ten en cuenta que si envías parches a GNU Boot, las contribuciones que
hagas quedan registradas públicamente, en un repositorio Git al que todo
el mundo puede acceder.

Y estas contribuciones incluyen un nombre, una dirección de correo
electrónico e incluso una fecha precisa en la que se hizo la
contribución. Es relativamente fácil cambiar el nombre y el correo
electrónico por los que quieras, ya que el comando git commit tiene
opciones para ello.

Si lo hace, antes de enviar los parches asegúrese de utilizar [git log
git
\-\-pretty=fuller](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
y [git show \-\-pretty=fuller](https://git-scm.com/docs/git-show) para
confirmar que ha utilizado el nombre y el correo electrónico correctos
antes de publicar los cambios.

Tenga en cuenta que incluso si lo hace, todavía podría ser posible
vincular sus contribuciones a su identidad, por ejemplo con
[stylometry](https://media.ccc.de/v/28c3-4781-en-deceiving_authorship_detection),
mirando las conexiones de red si no utiliza [Tor](torproject.org),
mirando la hora/zona horaria de la contribución, etc.

Licencias
---------

Exigimos que todos los parches se envíen bajo una licencia libre:
<https://www.gnu.org/licenses/license-list.html>.

- Se recomienda encarecidamente la Licencia Pública General GNU v3.
- Para la documentación, se requiere GNU Free Documentation License v1.3
o superior.

¡*Declare siempre* la licencia de su obra!. No declarar una licencia
significa que se aplican las leyes de copyright restrictivas por
defecto, lo que haría que su obra no fuera libre.

Generalmente se recomienda GNU/Linux como el SO de elección, para el
desarrollo de GNU Boot. Sin embargo, los sistemas operativos BSD también
arrancan en máquinas GNU Boot.

Contribución de parches a GNU Boot
----------------------------------

Puede enviar sus parches a la [lista de correo
gnuboot-patches](https://lists.gnu.org/mailman/listinfo/gnuboot-patches),
preferiblemente utilizando [git
send-email](https://git-scm.com/docs/git-send-email).

[sourcehut](https://git-send-email.io/) ha elaborado una sencilla guía
para configurar correctamente tu instalación de git para que envíe
correos electrónicos. También puedes utilizar la interfaz de
[sourcehut](https://man.sr.ht/git.sr.ht/#sending-patches-upstream) para
crear parches.

Tendrá que especificar la dirección de la lista de correo:

	git config --local sendemail.to gnuboot-patches@gnu.org

Por favor, firme también sus parches, que puede configurar con:

	git config format.signOff yes

Una vez que haya enviado su parche, los mantenedores de GNU Boot serán
notificados a través de la lista de correo y comenzarán a revisarlo.

Todos los parches que se añaden a GNU Boot requieren el acuerdo de dos
mantenedores. El acuerdo de los mantenedores a menudo se indica con un
texto como este:

	Acked-by: <maintainer name> <maintainer email>.

en una respuesta (por correo electrónico) del mantenedor en cuestión.

El acuerdo de los mantenedores sobre un parche no significa
necesariamente que haya un acuerdo sobre el orden en el que se añadirá
el parche. Así que los parches también pueden aterrizar en una rama
'gnuboot-next' temporalmente y potencialmente ser reordenados hasta que
todos los mantenedores de GNU Boot estén de acuerdo en empujar todos los
commits en el orden elegido a la rama principal.

Esta rama 'gnuboot-next' también puede usarse cuando los mantenedores de
GNU Boot están de acuerdo en fusionar los parches pero necesitan esperar
a la aprobación del Proyecto GNU, por ejemplo, si hay cuestiones legales
que también requieren la aprobación del Proyecto GNU.

Pruebas para detectar problemas comunes en los parches
------------------------------------------------------

Una vez construidas las imágenes de GNU Boot o el sitio web de GNU Boot,
es posible ejecutar varias pruebas automáticas. Puede ejecutarlas con el
siguiente comando:

```
make check
```

ya sea en el directorio del sitio web (si desea probar el sitio web) o
en el directorio superior (si desea probar el resto).

También tenemos un script que puede probar su parche para los problemas
comunes que hemos identificado. Se puede utilizar de esta manera (con
0001-fix-bug-#1234.patch siendo el parche que está a punto de enviar):

```
$ guile ./scripts/checkpatch.scm ./0001-fix-bug-#1234.patch
  [...]
  total: 0 error, 0 warning, 88 lines checked

  ./0001-fix-bug-#1234.patch has no obvious style problems and is ready for submission.
```

Aunque ejecutar todas estas pruebas no es obligatorio (a menos que seas
un mantenedor de GNU Boot), puede ser útil y puede ahorrar tiempo a todo
el mundo, ya que puede detectar problemas antes de enviar los parches a
las listas de correo, y esto te permitirá solucionar el problema más
rápido que esperar a que otras personas ejecuten las pruebas y te pidan
que arregles tu parche y lo reenvíes una vez arreglado.

Mantenedores
------------

Adrien 'neox' Bourmault y Denis 'GNUtoo' Carikli son los actuales
mantenedores de GNU Boot. También revisarán los parches enviados a la
lista de correo.
