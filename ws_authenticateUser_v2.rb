require 'multi_xml'
require 'savon'
require 'hashie'

# Se crea el cliente Soap
client = Savon.client(wsdl: 'http://172.22.165.74:8071/SmartDealerII-wsUY/AuthenticationWSService?wsdl')

# Este metodo me trae las operaciones disponibles para ese wsdl
client.operations

# Obtengo el response
response = client.call(:authenticate_user, message: { userName: 'ovdregional', password: 'directv.00', countryId: 1 })

# Escribi el response en un archivo txt
archivo = File.open('login.txt', 'w')
archivo.puts response
archivo.close

arreglo_vacio = []
nuevo_hash =Hash.new
MultiXml.parser = :nokogiri
MultiXml.parser = MultiXml::Parsers::Nokogiri 

# Recorro el archivo txt y lo guardo en un array
File.open('login.txt').readlines.each do |lineas|
    arreglo_vacio.push(lineas)
end

# Recorro el array y pregunto si comienza con '<', si es asi, lo guardo en un .xml
arreglo_vacio.each do |elemento|
    if elemento[0] == '<' 
        nuevo_hash = elemento
        archivo1 = File.open('ResponseLogin.xml', 'w')
        archivo1.puts nuevo_hash
        archivo1.close
    end    
end

# Leo el XML y lo formateo a Hash
nuevo_hash2 =Hash.new
MultiXml.parser = :rexml
MultiXml.parser = MultiXml::Parsers::Rexml # Same as above
File.open('ResponseLogin.xml').readlines.each do |lineas|
    nuevo_hash2 = MultiXml.parse(lineas) # Parsed using REXML
 end

# Busco dentro del Hash la clave :name con valor Dealers 
nuevo_hash2.extend(Hashie::Extensions::DeepLocate)
puts nuevo_hash2.deep_locate -> (key, value, object) {key == :name or value == 'DEALERS' }
