require 'savon'
require 'RSpec'

RSpec.describe 'autenticacion' do
    it "authenticates the user with the service" do
        #Creo el cliente soap
        client = Savon.client(wsdl: "http://172.22.165.74:8071/SmartDealerII-wsUY/AuthenticationWSService?wsdl")
        message = { userName: "ovdregional", password: "directv.00", countryId: 1 }
        response = client.call(:authenticate_user, message: message) 
        
        #Leo el xmk con el formato del response deseado
        archivoLeer = File.open('Escribe.xml', 'r')
        fixture = archivoLeer.read
        
        #Comparo xml obtenido (response) con el xml que se espera (fixture)       
        expect(fixture).to eq response.to_s

    end
end