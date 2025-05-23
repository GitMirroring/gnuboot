title: Obtenga GNU Boot
---

Compra un computador con GNU Boot
=================================

La FSF mantiene una [certificación](https://ryf.fsf.org) para
computadores que funcionan sin software no libre.

Algunos (no todos) de los computadores que recibieron la certificación
son compatibles con GNU Boot. En el caso de
[Technoetical](https://ryf.fsf.org/vendors/Technoethical), los
computadores que son compatibles ya vienen con GNU Boot instalado.

Como las empresas que figuran en la certificación son empresas, también
se supone que se ocupan de lo que hay detrás del capó, como las pruebas
contra defectos de hardware para asegurarse de que todo el hardware
funciona con software libre (mediante la sustitución de la tarjeta
WiFi), asegurarse de que el hardware realmente sirve etc, pudiendo ser
la forma más fácil para los usuarios no técnicos de conseguir GNU Boot.

Consulte la página [estado de GNU Boot](../../status.html) para saber qué
computadores RYF son compatibles con GNU Boot.

Si usted es un vendedor de hardware que está o estuvo listado en
https://ryf.fsf.org/vendors/ y que vendió computadores compatibles con
GNU Boot, por favor [contacte con el proyecto GNU
Boot](../../contact.html): estamos buscando información sobre el producto
vendido (tamaño del chip flash, personalización, etc) para darles el
mejor soporte.

Fiestas de instalación de GNU Boot
==================================

A veces hay instaladores que pueden ayudarle a instalar GNU Boot y/o
instalarlo por usted en un computador admitido por los instaladores (y
GNU Boot).

Puede ser más barato que comprar un computador con GNU Boot, pero los
que se encargan de la instalación normalmente no se preocupan de todo.

En primer lugar, obviamente, tendrá que encontrar un computador
compatible y hacerlo sin ejecutar software no libre (como JavaScript no
libre) es complicado.

Además, los que se encargan de la instalación no tienen repuestos para
baterías, tarjetas WiFi que funcionen con software libre, etc y trabajan
con el hardware que tú les llevas. Así que si el hardware tiene defectos
no podrán arreglarlo.

Fiestas de instalación conocidas:

* En mayo de 2024 hubo una fiesta de instalación de GNU Boot en la
  conferencia Libreplanet. Dado que esta conferencia se celebra todos
  los años, es posible que desee comprobar si el próximo año hay una
  fiesta de instalación de GNU Boot allí.

Instrucciones de instalación
============================

Hay varias instrucciones para instalar GNU Boot por uno mismo o para
ayudarse a hacerlo juntos (esto podría ser más fácil y rápido).

Al leer o seguir estas instrucciones, es importante tener en cuenta que:

* Siempre hay que mirar la [página de estado](status.html) para saber si
  se sabe que la imagen que se va a instalar funciona.

  Si se sabe que la imagen no funciona, podría impedir el arranque del
  computador. Para solucionarlo, lo más probable es que tengas que
  desmontar tu computador y utilizar otro computador y un programador
  flash para recuperarlo. Esto es exactamente lo que hace la gente que
  prueba imágenes no probadas cuando las cosas van mal.

  También hay instrucciones para recuperar computadores que no arrancan
  en el sitio web de GNU Boot. Asegúrate de consultarlas primero, si
  quieres ayudar al proyecto GNU Boot a probar imágenes y aún no estás
  familiarizado con cómo rescatar un computador específico (la
  dificultad puede variar mucho dependiendo del computador y de tus
  habilidades).

* También tienes que asegurarte de utilizar la imagen adecuada para el
  computador. Una imagen para el T400 probablemente no funcionará en el
  X301, y también existe el riesgo de romper el computador para siempre
  si utiliza la imagen equivocada porque en algunos casos el código en
  las imágenes también es responsable de establecer el voltaje correcto.
  También es importante saber la versión de GNU Boot que estás
  instalando porque la necesitas para comprobar la página de estado.

* Antes de instalar o actualizar (a) GNU Boot, es importante hacer una
  copia de seguridad de lo que hay en el chip flash que vas a anular. De
  esta manera, si las cosas empeoran en la nueva imagen, todavía puede
  volver a la imagen anterior.

  Si estás probando imágenes que no se probaron antes, también es buena
  idea poner la copia de seguridad en algún lugar al que puedas acceder
  fácilmente si el computador ya no arranca.

Actualícese a partir de una instalación existente
-------------------------------------------------

Existe [documentación de propósito general](install.html) para usuarios
técnicos que puede ayudarle a actualizar a una versión más reciente de
GNU Boot.

Instalación
-----------

Existe [documentación de propósito general](install.html) para usuarios
técnicos que puede ayudarle a instalar GNU Boot.

Descargas
---------

La página [Descargas](../../download.html) tiene documentación sobre cómo
descargar GNU Boot de varias maneras.

Sin embargo, si desea instalar GNU Boot, se recomienda encarecidamente
utilizar la documentación de instalación o actualización, ya que
contiene consejos que le ayudarán a evitar romper su computador.
