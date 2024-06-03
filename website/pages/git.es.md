---
title: Revisión de Código
x-reviewed: true
...

Nuestros planes a corto plazo y necesidad de ayuda
==================================================

GNU Boot busca colaboradores para diversos trabajos, tanto simples como
técnicos.

Información
-----------

El nombre Libreboot tiene una larga historia en la comunidad del
software libre. La mayoría de sus apariciones estaban destinadas a hacer
referencia al software de arranque libre, y no hay forma de editar esas
apariciones para hacer referencia al software de arranque libre con un
nombre distinto. Por lo tanto, necesitamos la ayuda de la comunidad en
general para informar a la gente sobre la inclusión de software no-libre
en las versiones de Libreboot.

Otra forma de ayudar a GNU Boot y defender el software realmente libre
es cambiar las URL de la web de <libreboot.org> a
<gnu.org/software/gnuboot>, para asegurarse de que el software
mencionado sea software libre.

También puedes ayudar a nuestro proyecto informando a la gente sobre el
GNU Boot u otro software de arranque 100% libre.

Documentar y/o probar
---------------------

Necesitamos ayuda para revisar y arreglar este sitio web (que también
contiene la documentación). Muchas páginas se heredan de Libreboot y
pueden estar desactualizadas o ser específicas de Libreboot.

Además, también necesitamos ayuda para probar los lanzamientos y
probar/actualizar las instrucciones de instalación.

Actualmente tenemos una lista de las computadoras que aún no se han
probado en el [bug 64754](https://savannah.gnu.org/bugs/?64754).

En cuanto a informar lo que probó, puede abrir un nuevo bug o enviar un
correo a las lista de correo
[gnuboot](http://lists.gnu.org/mailman/listinfo/gnuboot) o
[bug-gnuboot](https:// listas.gnu.org/mailman/listinfo/bug-gnuboot).

Contribuciones técnicas
-----------------------

Actualmente, GNU Boot utiliza versiones viejas de software a
contracorriente (upstream) (como Coreboot, GRUB, etc.) y, por lo tanto,
es necesario actualizarlas. Los parches para esto deben enviarse a la
lista de correo
[gnuboot-patches](http://lists.gnu.org/mailman/listinfo/gnuboot-patches).

También tenemos un rastreador de errores en
https://savannah.gnu.org/bugs/?group=gnuboot que contiene una lista de
errores que deben corregirse.

Como contribuir
===============

Repositorios GNU Boot
---------------------

El desarrollo de GNU Boot se realiza utilizando el sistema de control de
versiones Git. Consulte la [documentación oficial de
Git](https://git-scm.com/doc) si no sabe cómo usar Git.

El repositorio principal de GNU Boot está en
<https://git.savannah.gnu.org/cgit/gnuboot.git>. También contiene el
sitio web/documentación y el código para construirlo.

GNU Boot también tiene dos repositorios adicionales: uno para
[presentaciones realizadas en
conferencias](https://git.savannah.gnu.org/cgit/gnuboot/presentations.git)
o ​​para [duplicar el código fuente que ha
desaparecido](https://git.savannah.gnu.org/cgit/gnuboot/acpica.org-mirror.git).

Puede descargar cualquiera de estos repositorios, realizar los cambios
que desee y luego enviarlos siguiendo las instrucciones a continuación.

Probando tus modificaciones
---------------------------

Para contribuciones técnicas o para contribuir al sitio web, es posible
que necesite probar sus modificaciones.

Actualmente, esto requiere el uso de una distribución de GNU con Linux,
ya que la creación de GNU Boot o su sitio web en otros sistemas
operativos no está completamente probada.

Para obtener instrucciones sobre cómo compilar GNU Boot, puede consultar
las [instrucciones de compilación](docs/build/).

Sitio web
---------

El sitio web está en el código fuente de GNU Boot dentro del directorio
/site.

Actualmente está escrito en Markdown, específicamente la versión Pandoc
y las páginas HTML estáticas se generan con
[Untitled](https://untitled.vimuser.org/), un generador de sitios web
estáticos.

Su documentación se encuentra en el
[README](https://git.savannah.gnu.org/cgit/gnuboot.git/tree/website/README)
dentro del directorio de compilación del sitio web.

Nombre no requerido
-------------------

Muchos proyectos que utilizan licencias de software libre aceptan
contribuciones de cualquier persona, pero en muchos casos también
necesitan poder rastrear la tenencia de Derechos de Autor de las
contribuciones por varias razones.

Esto suele complicar las contribuciones anónimas o seudónimas, pero no
las hace imposibles.

Si desea contribuir de forma anónima o seudónima, la mejor manera es
contactarnos públicamente (por ejemplo, en nuestra lista de correo,
usando un correo y un nombre que use solo para eso) para que podamos
investigarlo e intentar encontrar formas que funcionen para GNU Boot,
pero también potencialmente para otros proyectos anteriores y de esta
manera le permitirá contribuir a una amplia variedad de proyectos bajo
licencias de software libre con mucha menos dificultad.

Tenga en cuenta que, en el caso de los parches, las contribuciones que
realiza se registran públicamente, en un repositorio Git al que todos
pueden acceder.

Y estas aportaciones incluyen un nombre, una dirección de correo
electrónico e incluso una fecha precisa en la que se realizó la
aportación. Es relativamente fácil cambiar el nombre y el correo
electrónico por los que desee, ya que el comando git commit tiene
opciones para eso.

Si haces eso, antes de enviar parches asegúrate de usar [git log
git\-\-pretty=fuller](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
y [git show\-\-pretty=fuller](https://git-scm.com/docs/git-show) para
confirmar que utilizó el nombre y el correo electrónico correctos antes
de publicar los cambios.

Tenga en cuenta que incluso si hace eso, es posible que aún sea posible
vincular sus contribuciones a su identidad, por ejemplo con
[estilometría](https://media.ccc.de/v/28c3-4781-en-deceiving_authorship_detection),
mirando las conexiones de red si no usas [Tor](torproject.org), mirando
la hora/zona horaria de la contribución, etc.

Licencias
--------

Requerimos que todos los parches se envíen bajo una licencia libre:
<https://www.gnu.org/licenses/license-list.html>.

- Se recomienda encarecidamente la licencia pública general de GNU
versión 3. - Para la documentación, requerimos la licencia de
documentación libre GNU v1.3 o superior

*¡Siempre* declara una licencia sobre tu trabajo! No declarar una
licencia significa que se aplican las leyes de Derechos de Autor
restrictivas y predeterminadas, lo que haría que su trabajo no fuera
libre.

Generalmente se recomienda GNU/Linux como sistema operativo de elección
para el desarrollo de GNU Boot. Sin embargo, los sistemas operativos BSD
también arrancan en máquinas con GNU Boot.

Envía parches y contribuye
-------------------------

Puede enviar sus parches a la [lista de correo
gnuboot-patches](https://lists.gnu.org/mailman/listinfo/gnuboot-patches),
preferiblemente usando [git
send-email](https://git-scm.com/docs/git-send-email).

Una guía sencilla para configurar correctamente su instalación de Git
para enviar correos electrónicos ha sido creada por
[sourcehut](https://git-send-email.io/) o puede utilizar la [interfaz
sourcehut](https://man.sr.ht/git.sr.ht/#sending-patches-upstream) para
crear parches.

Tendrás que especificar la dirección de la lista de correo:

	git config --local sendemail.to gnuboot-patches@gnu.org

Cierra también tus parches, que puedes configurar con:

	git config format.signOff yes

Una vez que haya enviado su parche, los mantenedores de GNU Boot serán
notificados a través de la lista de correo y comenzarán a revisarlo.

Todos los parches que se agregan a GNU Boot requieren el acuerdo de dos
mantenedores. El acuerdo de mantenedor a menudo se indica con un texto
como este:

	Acked-by: <nombre del mantenedor> <correo electrónico del mantenedor>.

En una respuesta (correo electrónico) del mantenedor indicado.

El acuerdo de los mantenedores sobre un parche no significa
necesariamente que haya un acuerdo sobre el orden en que se agregará.
Por lo tanto, los parches también pueden aterrizar temporalmente en una
rama 'gnuboot-next' y potencialmente reordenarse hasta que todos los
mantenedores de GNU Boot estén de acuerdo en *push* (empujar) todas las
confirmaciones en el orden elegido en la rama principal.

Esa rama 'gnuboot-next' también se puede utilizar cuando los
mantenedores de GNU Boot acuerdan fusionar los parches pero necesitan
esperar la aprobación del proyecto GNU, por ejemplo, si hay cuestiones
legales que también requieren la aprobación del Proyecto GNU.

Mantenedores
-----------

Adrien 'neox' Bourmault y Denis 'GNUtoo' Carikli son los actuales
mantenedores del proyecto GNU Boot. También revisarán los parches
enviados a la lista de correo.
