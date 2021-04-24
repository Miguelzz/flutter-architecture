import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter_architecture/app/modules/common/components/fonts.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/login/login_controller.dart';
import 'package:flutter_architecture/app/routes/routes_controller.dart';
import 'package:get/get.dart';

class ReadTermsPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  final RouteController route = Get.find();
  final phone = TextEditingController();
  final bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminos y Condiciones'),
      ),
      body: FullScreen(
        safeArea: true,
        child: Column(
          children: [
            H5('TERMINOS Y CONDICIONES DE USO DE LA APLICACIÓN'),
            P('Estos Términos y Condiciones regulan la descarga, acceso y utilización de la aplicación móvil (en adelante, la “APLICACIÓN”), que PRODUCCIONES ERTAL, S.L. ponen a disposición de los usuarios.'),
            P('Esta versión de la APLICACIÓN está disponible de forma gratuita.'),
            P('El acceso a la APLICACIÓN supone que el usuario reconoce ha aceptado y consentido sin reservas de las presentes condiciones de uso.'),
            H5('1. OBJETO'),
            P('Algunos de los colectivos que pueden beneficiarse de este proyecto son para todos los públicos. En el diseño y desarrollo de esta APLICACIÓN han intervenido profesionales especialistas así como un grupo de usuarios que participaron en el periodo de prueba.'),
            P('La APLICACIÓN se pone a disposición de los usuarios para su uso personal (nunca empresarial).'),
            P('Funciona en un teléfono móvil Android o iOS con cámara frontal.'),
            H5('2. DERECHOS DE PROPIEDAD INTELECTUAL E INDUSTRIAL'),
            P('Los derechos de propiedad intelectual e industrial sobre la APLICACIÓN son titularidad de PRODUCCIONES ERTAL, S.L., correspondiéndole el ejercicio exclusivo de los derechos de explotación de los mismos en cualquier forma y, en especial, los derechos de reproducción, distribución, comunicación pública y transformación.'),
            P('Los terceros titulares de derechos de propiedad intelectual e industrial sobre fotografías, logotipos, y cualesquiera otros símbolos o contenidos incluidos en la APLICACIÓN han concedido las correspondientes autorizaciones para su reproducción, distribución y puesta a disposición del público.'),
            P('El usuario reconoce que la reproducción, modificación, distribución, comercialización, descompilación, desensamblado, utilización de técnicas de ingeniería inversa o de cualquier otro medio para obtener el código fuente, transformación o publicación de cualquier resultado de pruebas de referencias no autorizadas de cualquiera de los elementos y utilidades integradas dentro del desarrollo constituye una infracción de los derechos de propiedad intelectual de PRODUCCIONES ERTAL, S.L.,  obligándose, en consecuencia, a no realizar ninguna de las acciones mencionadas.'),
            H5('3. POLITICA DE PRIVACIDAD'),
            P('La APLICACIÓN utilizará Google Analytics como herramienta para conocer uso y las tendencias de interacción de la misma. PRODUCCIONES ERTAL, S.L. podrán utilizar la información de carácter personal que nos facilite de forma disociada (sin identificación personal) para fines internos, tales como la elaboración de estadísticas. La APLICACIÓN podrá recabar, almacenar o acumular determinada información de carácter no personal referente a su uso.'),
            P('Google Analytics se rige por las condiciones generales de Google accesibles en http://www.google.com/analytics/terms/es.html y las políticas de privacidad en Google accesibles en https://www.google.es/intl/es/policies/privacy/. Para proceder a la desactivación de Google Analytics: https://support.google.com/analytics/answer/1009696?hl=es'),
            P('De conformidad con lo dispuesto en las normativas vigentes en protección de datos personales, el Reglamento (UE) 2016/679 de 27 de abril de 2016 (GDPR), se informa que los datos de carácter personal proporcionados mediante la aceptación de estos Términos y Condiciones, formarán parte de un fichero responsabilidad de PRODUCCIONES ERTAL, S.L. y que estos serán tratados con la finalidad descrita en el apartado “1. OBJETO” de este documento y serán conservados mientras dure la relación contractual objeto del uso de la APLICACIÓN, con el único objetivo de facilitar la introducción de mejoras en futuras versiones de la APLICACIÓN, también podrá realizarse el tratamiento de la información de las instalaciones, accesos de usuarios, datos demográficos, pantallas e interacción del usuario y bloqueos y excepciones. Asimismo, se informa que podrá retirar el consentimiento en cualquier momento y ejercer los derechos de acceso, rectificación, supresión, portabilidad, limitación y oposición dirigiéndose a C/ Montserrat, 13 casa E 08960 SANT JUST DESVERN (BARCELONA). Email: yolanda@carloslatre.com. También podrá presentar una reclamación ante la Autoridad de control (www.agpd.es) si considera que el tratamiento no se ajusta a la normativa vigente.'),
            P('PRODUCCIONES ERTAL, S.L. se reserva la facultad de efectuar, en cualquier momento y sin necesidad de previo aviso, modificaciones y actualizaciones en la APLICACIÓN. Asimismo, también se reserva el derecho a modificar los presentes Términos y Condiciones con el objetivo de adaptarlos a las posibles novedades legislativas y cambios en la propia APLICACIÓN, así como a las que se puedan derivar de los códigos tipos existentes en la materia o por motivos estratégicos o corporativos.'),
            H5('4. EXCLUSIÓN DE RESPONSABILIDAD'),
            P('PRODUCCIONES ERTAL, S.L. se reserva el derecho de editar, actualizar, modificar, suspender, eliminar o finalizar los servicios ofrecidos por la Aplicación, incluyendo todo o parte de su contenido, sin necesidad de previo aviso, así como de modificar la forma o tipo de acceso a esta.'),
            P('Las posibles causas de modificación pueden tener lugar, por motivos tales, como su adaptación a las posibles novedades legislativas y cambios en la propia Aplicación, así como a las que se puedan derivar de los códigos tipos existentes en la materia o por motivos estratégicos o corporativos.'),
            P('PRODUCCIONES ERTAL, S.L. no será responsable del uso de la APLICACIÓN por un menor de edad, siendo la descarga y uso de la APLICACIÓN de la exclusiva responsabilidad del usuario.'),
            P('La APLICACIÓN se presta “tal y como es” y sin ninguna clase de garantía. PRODUCCIONES ERTAL, S.L. no se hace responsable de la calidad final de la APLICACIÓN ni de que ésta sirva y cumpla con todos los objetivos de la misma. No obstante lo anterior, PRODUCCIONES ERTAL, S.L. se compromete en la medida de sus posibilidades a contribuir a mejorar la calidad de la APLICACIÓN , pero no puede garantizar la precisión ni la actualidad del contenido de la misma.'),
            P('La responsabilidad de uso de la APLICACIÓN corresponde solo al usuario. Salvo lo establecido en estos Términos y Condiciones, PRODUCCIONES ERTAL, S.L. no es responsable de ninguna pérdida o daño que se produzca en relación con la descarga o el uso de la APLICACIÓN, tales como los producidos como consecuencia de fallos, averías o bloqueos en el funcionamiento de la APLICACIÓN (por ejemplo, y sin carácter limitativo: error en las líneas de comunicaciones, defectos en el hardware o software de la APLICACIÓN o fallos en la red de Internet). Igualmente, PRODUCCIONES ERTAL, S.L. tampoco será responsable de los daños producidos como consecuencia de un uso indebido o inadecuado de la APLICACIÓN por parte de los usuarios.'),
            H5('5. LEGISLACIÓN Y FUERO'),
            P('El usuario acepta que la legislación aplicable y los Juzgados y Tribunales competentes para conocer de las divergencias derivadas de la interpretación o aplicación de este clausulado son los españoles, y se somete, con renuncia expresa a cualquier otro fuero, a los juzgados y tribunales más cercanos a la ciudad de SANT JUST DESVERN.'),
          ],
        ),
      ),
    );
  }
}
