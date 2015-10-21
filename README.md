# Jrxades

Jrxades es una gema JRuby que permite firmar un documento xml con un certificado .p12,
Esta gema ha sido creada para la Facturación Electrónica que se usa en Ecuador, 
sin embargo se basa en las especificaciones definidas en XADES_BES lo que permitiría ser 
usada en otros ambientes que requieran XADES_BES.

## Instalación

Agregar esta linea al archivo Gemfile

    gem 'jrxades'

Luego ejecutar:

    $ bundle

O instalar la gema manualmente:

    $ gem install jrxades


## Como se usa

Solo llamar directamente al metodo de la siguiente forma

Si el certificado tiene contraseña usar:

    xml_sig = Jrxs::XmlSig.new(input_xml_file_path, output_xml_file_path, certificate_file_path, certificate_password)

Si el certificado no tiene contraseña, la contraseña es opcional.

    xml_sig = Jrxs::XmlSig.new(input_xml_file_path, output_xml_file_path, certificate_file_path)

Luego llamar al método 'sign', para firmar, se creará un archivo de salida en el directorio y nombre previamente estaablecido.

    xml_sig.sign

Esta gema tiene los siguíentes métodos

### key_data_valid?
  
Verifica si un certificado p12 es válido

    xml_sig.key_data_valid?

### sign

Firma el archivo xml, y creara un archivo de salida en el directorio previamente estaablecido.

    xml_sig.sign


## Créditos

Esta gema es solo hace referencias a las clases creadas por Cristhian Carreño, quien expone en el siguiente tutorial como firmar un documento.

    http://webcarreno.org/index.php/tutorials/28-sri-tutorial/24-sri-firma-digital-xades-bes

## Código Java

El proyecto que contiene el código base de java se encuentra en

    https://github.com/joselo/sri

## Para contribuir

Clonar el repositorio

    $ git clone https://github.com/joselo/jrxades

Instalar JRuby

    $ cd jrxades

Instalar bundler

    $ gem install bundler

Ejecturar los tests.

    $ rspec .


